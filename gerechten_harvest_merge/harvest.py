"""
kookkompas harvest + schema_2 generator.

start gewoon met: python harvest.py
en kies in t menuke wat je wil. niks moeilijk.

de shell (schema.sh) roept dit ding ook aan met --herorden, dat hoeft ge
dus niet apart te onthouden. menu is je vriend.
"""

import os, re, sys, time, string, subprocess
import requests
import mysql.connector
from mysql.connector import Error

# windows console doet moeilijk over poolse/spaanse tekens, vandaar UTF-8
sys.stdout.reconfigure(encoding="utf-8", errors="replace")


HIER       = os.path.dirname(os.path.abspath(__file__))
FOTO_MAP   = os.path.join(HIER, "fotos")
SCHEMA   = os.path.join(HIER, "schema.sql")
SHELL      = os.path.join(HIER, "schema.sh")
API_BASIS  = "https://www.themealdb.com/api/json/v1/1"

# xampp standaard, geen paswoord. als ge er een hebt aanpassen
DB_CONFIG = {"host": "localhost", "user": "root", "password": "",
             "database": "recipe_search",
             "charset": "utf8mb4", "use_unicode": True}


# trefwoord -> allergeen mapping. compact gebouwd met fromkeys per categorie
# zo zien we ook makkelijk welke woorden bij welk allergeen horen
# niet perfect (pecorino bv. mist, das ook kaas) maar goed genoeg voor demo
ALLERGEEN_PER_TREFWOORD = {
    **dict.fromkeys(["wheat","flour","bread","pasta","spaghetti","noodle",
                     "couscous","barley","rye","oats"], "Gluten"),
    **dict.fromkeys(["milk","cream","butter","cheese","yogurt","yoghurt",
                     "mozzarella","parmesan"], "Lactose"),
    **dict.fromkeys(["egg","eggs"], "Eggs"),
    **dict.fromkeys(["almond","walnut","cashew","hazelnut","pistachio","pecan"], "Nuts"),
    "peanut": "Peanuts",  # pinda is BOTANISCH geen noot, vandaar apart
    **dict.fromkeys(["soy","soya","tofu"], "Soy"),
    **dict.fromkeys(["shrimp","prawn","crab","lobster","crayfish"], "Shellfish"),
    **dict.fromkeys(["salmon","tuna","cod","haddock","mackerel","anchovy","fish"], "Fish"),
    "celery": "Celery",
    "sesame": "Sesame",
}

# almond milk bevat letterlijk 'milk' maar das geen lactose, plantaardig
# soja melk idem, oat milk idem, ge snapt het wel
PLANTAARDIGE_MELK = {"almond milk","coconut milk","soy milk",
                     "soya milk","oat milk","rice milk"}

# stored procedures in CRUD-volgorde, niet alfabetisch zoals mysqldump doet
# eerst de hoofd-acties op meals (CRUD), dan de helpers (link/add ingredient)
PROCEDURE_VOLGORDE = [
    "add_meal","update_meal","delete_meal",
    "find_meals_by_ingredient","find_meals_without_allergen","get_meal_allergens",
    "add_ingredient","link_meal_ingredient","link_ingredient_allergen",
]


# ---- harvest van themealdb ----
# trekt gerechten binnen via de json api, ingredienten en allergenen erbij

def lees_ingredienten(g):
    """themealdb stopt ingredienten in 20 losse velden strIngredient1 tem 20.
    lege of None overslaan, alles in kleine letters voor de matching erna.
    let op: sommige recepten hebben None-waarden ipv lege strings, vandaar
    de check op `v and v.strip()`."""
    return [v.strip().lower()
            for n in range(1, 21)
            if (v := g.get(f"strIngredient{n}")) and v.strip()]


def detecteer_allergenen(ingredienten):
    """set teruggeven met allergenen die voorkomen in de ingredienten.
    plantaardige melk telt NIET als lactose - speciaal gevalletje."""
    return {a for ingr in ingredienten
              for w, a in ALLERGEEN_PER_TREFWOORD.items()
              if w in ingr and not (ingr in PLANTAARDIGE_MELK and a == "Lactose")}


def download_foto(meal_id, url):
    """foto trekken en wegschrijven als fotos/<meal_id>.jpg.
    bestaat het al? overslaan. geen url? overslaan. faalt het? gewoon
    melden en doorgaan. niet de hele harvest blokkeren op 1 rotte foto."""
    pad = os.path.join(FOTO_MAP, f"{meal_id}.jpg")
    if os.path.exists(pad) or not url:
        return False
    try:
        r = requests.get(url, timeout=15); r.raise_for_status()
        with open(pad, "wb") as f: f.write(r.content)
        return True
    except Exception as e:
        print(f"   (foto {meal_id} ging mis: {e})")
        return False


def bewaar_gerecht(cursor, g):
    """1 gerecht in de db steken: meals + ingredients + meal_ingredients +
    meal_allergens in 1 keer.

    KLEIN MAAR BELANGRIJK: meals.id heeft GEEN auto_increment, we nemen
    de id van themealdb gewoon over. adana kebab is daar id 52969 dus bij
    ons ook 52969. zo heet de foto ook 52969.jpg en weet je altijd waar
    het vandaan komt. andere tabellen (ingredients, allergens) hebben WEL
    auto_increment want die ids verzinnen we zelf.

    INSERT IGNORE op de tussentabellen zodat het script herstartbaar is
    zonder te crashen op duplicaten."""
    meal_id = int(g["idMeal"])
    cursor.execute(
        "INSERT INTO meals (id, name, category, area, instructions, thumbnail_url) "
        "VALUES (%s,%s,%s,%s,%s,%s)",
        (meal_id, g.get("strMeal"), g.get("strCategory"), g.get("strArea"),
         g.get("strInstructions"), g.get("strMealThumb"))
    )

    # ingredienten zelf erin en koppelen via de N-M tussentabel
    ingredienten = lees_ingredienten(g)
    for naam in ingredienten:
        cursor.execute("INSERT IGNORE INTO ingredients (name) VALUES (%s)", (naam,))
        cursor.execute(
            "INSERT IGNORE INTO meal_ingredients (meal_id, ingredient_id) "
            "SELECT %s, id FROM ingredients WHERE name = %s", (meal_id, naam))

    # allergenen via trefwoord matching, dan koppelen
    allergenen = detecteer_allergenen(ingredienten)
    for tag in allergenen:
        cursor.execute(
            "INSERT IGNORE INTO meal_allergens (meal_id, allergen_id) "
            "SELECT %s, id FROM allergens WHERE name = %s", (meal_id, tag))

    return allergenen


def oogst():
    """hoofd ding. loopt alfabet af, vraagt themealdb per letter de gerechten,
    en dropt alles in de db. fotos erbij. duurt ongeveer 1 a 2 minuten."""
    try:
        verbinding = mysql.connector.connect(**DB_CONFIG)
    except Error as e:
        # geen db = niks te doen, gewoon stoppen
        print(f"databank wil niet opendoen: {e}"); return

    os.makedirs(FOTO_MAP, exist_ok=True)
    cursor = verbinding.cursor()
    nieuw = overgeslagen = nieuwe_fotos = mislukt = 0

    # try/finally: cursor en verbinding MOETEN sluiten, ook bij een crash
    try:
        print("harvest van themealdb gestart\n")
        for letter in string.ascii_lowercase:
            print(f"letter '{letter}'... ", end="", flush=True)

            # api call kan falen (internet down, server down,...) niet hele
            # harvest om zeep helpen, gewoon volgende letter
            try:
                lijst = requests.get(f"{API_BASIS}/search.php?f={letter}",
                                     timeout=10).json().get("meals") or []
            except Exception as e:
                print(f"opvraag mislukt: {e}"); mislukt += 1; continue

            print(f"{len(lijst)} gerechten")
            for g in lijst:
                meal_id = int(g["idMeal"])
                naam = g.get("strMeal", "?")

                # zit ie er al in? skippen. foto mag wel nog gedownload worden
                # in geval die de vorige keer faalde
                cursor.execute("SELECT 1 FROM meals WHERE id = %s", (meal_id,))
                if cursor.fetchone():
                    overgeslagen += 1
                else:
                    try:
                        tags = bewaar_gerecht(cursor, g)
                        # commit pas op het einde, atomair per gerecht
                        verbinding.commit(); nieuw += 1
                        print(f"   + {naam}  ->  {', '.join(sorted(tags)) or 'geen'}")
                    except Exception as e:
                        # rollback zodat we geen half gerecht laten staan
                        verbinding.rollback(); mislukt += 1
                        print(f"   ! {naam}: {e}"); continue

                if download_foto(meal_id, g.get("strMealThumb")):
                    nieuwe_fotos += 1
            time.sleep(0.3)  # beleefd zijn tegen de gratis api

        print(f"\n--- klaar ---\nnieuw: {nieuw}\novergeslagen: {overgeslagen}"
              f"\nfoto's nieuw: {nieuwe_fotos}\nmislukt: {mislukt}")
    finally:
        cursor.close(); verbinding.close()


# ---- herorden van schema.sql na mysqldump ----
# mysqldump dumpt in 'mysql-stijl': per tabel structuur+data, procedures
# alfabetisch, /*!XXXXX */ commentaren over heel het bestand.
# in de les hebben we dat zo niet gezien. wij willen schoolvolgorde:
# db -> tabellen -> data -> procedures, en die procedures in CRUD-volgorde.
# en die /*! comments mogen weg, da werkt verwarrend voor medestudenten.

def _per_marker(tekst, marker_regex):
    """splits tekst op marker_regex, yield (naam, blok) per marker.
    handig hulpje, gebruiken we 2 keer (voor tabellen en voor procedures)."""
    stukken = re.split(marker_regex, tekst)
    for i in range(1, len(stukken), 2):
        marker = stukken[i]
        inhoud = stukken[i + 1] if i + 1 < len(stukken) else ""
        naam = re.search(r"`(\w+)`", marker)
        if naam:
            yield naam.group(1), marker + inhoud


def herschik_procedures(sectie):
    """procedures in CRUD-volgorde zetten ipv mysqldump's alfabetische.
    leest logischer: eerst add_meal, dan update, dan delete, dan reads,
    dan de helpers achteraan."""
    eerste = re.search(r"/\*!50003 DROP PROCEDURE", sectie)
    if not eerste:
        return sectie

    # set-statements van het hoofd behouden, daarna de procs herordenen
    hoofd, rest = sectie[:eerste.start()], sectie[eerste.start():]
    procs = dict(_per_marker(rest, r"(/\*!50003 DROP PROCEDURE IF EXISTS `\w+` \*/;)"))

    gesorteerd = [procs[n] for n in PROCEDURE_VOLGORDE if n in procs]
    # voor de zekerheid: procs die we niet voorzien hadden gewoon achteraan
    rest_in = [b for n, b in procs.items() if n not in PROCEDURE_VOLGORDE]
    return hoofd + "".join(gesorteerd + rest_in)


def opkuis_mysql(tekst):
    """/*!XXXXX ... */ comments wissen want die hebben we niet in de les
    gehad en medestudenten beginnen er over te zagen. weg ermee.

    MAAR: enkele essentiele dingen zaten verstopt IN die /*! comments:
    DROP DATABASE IF EXISTS, de CHARSET specificatie, en FK_CHECKS uit/aan.
    die zetten we proper terug in pure SQL-vorm zodat de import nog werkt."""
    # eerst alle /*! ... */ blokken eruit
    tekst = re.sub(r"/\*!\d+\s[^*]*(?:\*(?!/)[^*]*)*\*/", "", tekst)

    # CREATE DATABASE proper maken (DROP ervoor, CHARSET erbij)
    tekst = re.sub(
        r"CREATE DATABASE\s+`(\w+)`\s*;",
        r"DROP DATABASE IF EXISTS `\1`;\n"
        r"CREATE DATABASE `\1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;",
        tekst)

    # foreign keys tijdelijk uit anders klaagt mysql over de volgorde van de
    # tabellen (favorites verwijst naar meals dat alfabetisch later komt enzo)
    # SET NAMES en FK_CHECKS na de USE-statement zodat speciale tekens
    # (½, é, è enz.) correct geinterpreteerd worden bij import
    tekst = re.sub(r"(USE `\w+`;)",
                   r"\1\n\nSET NAMES utf8mb4;\n\nSET FOREIGN_KEY_CHECKS = 0;",
                   tekst, count=1)
    tekst = tekst.rstrip() + "\n\nSET FOREIGN_KEY_CHECKS = 1;\n"

    # opkuis: losse puntkomma-regels en dubbele lege regels
    schoon = "\n".join(r for r in tekst.split("\n") if r.strip() != ";")
    while "\n\n\n" in schoon:
        schoon = schoon.replace("\n\n\n", "\n\n")
    return schoon


def hernumeret_ingredienten(tekst):
    """ingredient-IDs van 1,2,3,... ipv de willekeurige harvest-nummers.

    waarom rommelig: tijdens de harvest krijgen ingredienten een auto_inc-id
    in de volgorde dat ze voor het eerst tegengekomen worden. krijg je rare
    nummers als 4459, 33, 2548, ... omdat ze later alfabetisch gesorteerd
    worden in de dump. niet wat een mens verwacht te zien.

    we doen 2 dingen tegelijk:
    1. ingredient-IDs vervangen door 1,2,3,...
    2. de meal_ingredients koppeltabel meteen meeupdaten zodat alle
       verwijzingen blijven kloppen.

    meals.id en allergens.id raken we NIET aan (themealdb-id en 1-10)."""
    m = re.search(r"INSERT INTO `ingredients` VALUES\s*(.*?);", tekst, re.DOTALL)
    if not m: return tekst

    # alle (id, 'naam') paren eruit halen, mysqldump gaf ze al gesorteerd
    paren = re.findall(r"\((\d+),('(?:[^'\\]|\\.)*')\)", m.group(1))
    if not paren: return tekst

    # mapping oud_id -> nieuw_id, gewoon doortellen vanaf 1
    mapping = {int(oud): nieuw for nieuw, (oud, _) in enumerate(paren, start=1)}
    nieuwe = ",".join(f"({mapping[int(oud)]},{naam})" for oud, naam in paren)
    tekst = tekst[:m.start()] + f"INSERT INTO `ingredients` VALUES {nieuwe};" + tekst[m.end():]

    # nu de tussentabel meeupdaten met de nieuwe ids
    mi = re.search(r"INSERT INTO `meal_ingredients` VALUES\s*(.*?);", tekst, re.DOTALL)
    if not mi: return tekst

    koppels = re.findall(r"\((\d+),(\d+)\)", mi.group(1))
    nieuwe_mi = ",".join(f"({meal},{mapping.get(int(ingr), int(ingr))})"
                         for meal, ingr in koppels)
    return tekst[:mi.start()] + f"INSERT INTO `meal_ingredients` VALUES {nieuwe_mi};" + tekst[mi.end():]


def herorden():
    """hoofdfunctie. doet in 1 keer:
    1. de dump opsplitsen in stukken
    2. herbouwen in schoolvolgorde (db -> tabellen -> data -> procedures)
    3. mysql /*! comments eruit, FK en CHARSET proper terugzetten
    4. ingredient-IDs naar opvolgende nummers"""
    with open(SCHEMA, "r", encoding="utf-8") as f:
        tekst = f.read()

    # secties knippen: kopstuk, midden (per-tabel), procs, staart
    eerste = re.search(r"^--\s*Table structure for table `(\w+)`", tekst, re.MULTILINE)
    routines_start = tekst.index("--\n-- Dumping routines")
    staart_idx = tekst.rindex("/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;")

    kopstuk = tekst[:eerste.start()]
    midden  = tekst[eerste.start():routines_start]
    procs   = tekst[routines_start:staart_idx]
    staart  = tekst[staart_idx:]

    # per tabel: structuur en data uit elkaar trekken zodat we ze apart
    # in schoolvolgorde kunnen herplaatsen (eerst alle structuren, dan alle data)
    tabellen, data = {}, {}
    for naam, blok in _per_marker(midden, r"(--\s*Table structure for table `\w+`)"):
        delen = re.split(r"(--\s*Dumping data for table `\w+`)", blok, maxsplit=1)
        tabellen[naam] = delen[0]
        data[naam] = "".join(delen[1:]) if len(delen) >= 3 else ""

    # schoolvolgorde herbouwen: db -> alle structuren -> alle data -> procs
    nieuw = kopstuk + "".join(tabellen.values()) + "".join(data.values()) \
            + herschik_procedures(procs) + staart
    nieuw = hernumeret_ingredienten(opkuis_mysql(nieuw))

    with open(SCHEMA, "w", encoding="utf-8") as f:
        f.write(nieuw)

    print(f"{len(tabellen)} tabellen, {len(data)} data-secties klaar.")
    print("procedures:", ", ".join(PROCEDURE_VOLGORDE))


# ---- cli menu ----
# simpel keuzemenu. shell roept dit script ook aan met --herorden, maar
# voor menselijk gebruik gewoon python harvest.py en kiezen.

MENU = """
kookkompas harvest
==================
1. data ophalen van themealdb (vult de databank)
2. schema.sql regenereren (mysqldump + herorden)
3. stoppen
"""


def regenereer_via_shell():
    """shell aanroepen die mysqldump doet en daarna 'python harvest.py --herorden'"""
    if not os.path.exists(SHELL):
        print(f"shellscript niet gevonden: {SHELL}"); return
    subprocess.run(["bash", SHELL], cwd=HIER)


# keuze -> functie. nieuwe optie toevoegen? gewoon hier bijzetten
ACTIES = {"1": oogst, "2": regenereer_via_shell}


def cli():
    while True:
        print(MENU)
        keuze = input("keuze: ").strip()
        if keuze == "3":
            print("doei."); return
        actie = ACTIES.get(keuze)
        if actie:
            actie()
        else:
            print("kies 1, 2 of 3.")


if __name__ == "__main__":
    # shell roept dit script aan met --herorden vlag na de mysqldump
    # anders gewone cli starten voor menselijk gebruik
    if "--herorden" in sys.argv:
        herorden()
    else:
        cli()
