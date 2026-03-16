"""
Kookcompas - AI Recepten Module (Ollama)

AI StΔrDust21
"""

import os
import sys
import json

# PATH SETUP
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# CONFIGURATIE LADEN
try:
    from config import OLLAMA_URL, AI_MODEL, AI_MAX_TOKENS
except ImportError:
    try:
        from dotenv import load_dotenv
        load_dotenv()
    except ImportError:
        pass
    OLLAMA_URL = os.getenv('OLLAMA_URL', 'http://localhost:11434')
    AI_MODEL = os.getenv('AI_MODEL', 'qwen2.5-coder:7b')
    AI_MAX_TOKENS = 1024

# HTTP LIBRARY
try:
    import urllib.request
    import urllib.error
    URLLIB_BESCHIKBAAR = True
except ImportError:
    URLLIB_BESCHIKBAAR = False


# CONFIGURATIE CHECK
def check_ollama_status():
    """
    Controleert of Ollama draait op de lokale machine.
    Returns: True als Ollama bereikbaar is, False anders
    """
    if not URLLIB_BESCHIKBAAR:
        print("urllib niet beschikbaar, kan Ollama niet bereiken.")
        return False

    try:
        verzoek = urllib.request.Request(OLLAMA_URL, method='GET')
        with urllib.request.urlopen(verzoek, timeout=5) as antwoord:
            return antwoord.status == 200
    except Exception:
        print(f"Ollama niet bereikbaar op {OLLAMA_URL}. Draait Ollama wel?")
        return False


def stuur_ollama_verzoek(systeem_prompt, gebruiker_prompt):
    """
    Stuurt een chat-verzoek naar Ollama en geeft de response terug.
    Returns: response tekst of None bij fout
    """
    url_chat = f"{OLLAMA_URL}/api/chat"

    payload = {
        "model": AI_MODEL,
        "messages": [
            {"role": "system", "content": systeem_prompt},
            {"role": "user", "content": gebruiker_prompt}
        ],
        "stream": False,
        "options": {
            "num_predict": AI_MAX_TOKENS
        }
    }

    json_bytes = json.dumps(payload).encode('utf-8')

    verzoek = urllib.request.Request(
        url_chat,
        data=json_bytes,
        headers={'Content-Type': 'application/json'},
        method='POST'
    )

    try:
        with urllib.request.urlopen(verzoek, timeout=120) as antwoord:
            response_data = json.loads(antwoord.read().decode('utf-8'))
            bericht = response_data.get('message', {})
            return bericht.get('content', '')
    except urllib.error.URLError as net_fout:
        print(f"Kon Ollama niet bereiken: {net_fout}")
        return None
    except json.JSONDecodeError:
        print("Ollama gaf een onleesbaar antwoord terug.")
        return None
    except Exception as fout:
        print(f"Onverwachte fout bij Ollama verzoek: {fout}")
        return None


# KLEUREN (ANSI CODES)
class Kleuren:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


# PROMPT ENGINEERING

def bouw_systeem_prompt():
    """
    Bouwt de systeem prompt voor de AI.
    Returns: Systeem prompt tekst
    """
    return """### DOEL
- **MUST**: Genereer een recept op basis van de opgegeven ingredienten.
- **MUST**: Analyseer de input op eetbaarheid.

### Taal & Stijl
- **MUST**: Antwoord in het Nederlands.
- **MUST**: Wees direct en duidelijk.
- **MUST NOT**: Geen wollig taalgebruik, focus op het recept.

### Recept Logica (CRUCIAAL)
- **MUST**: Analyseer of de ingredienten samen een logisch gerecht vormen.
- **MUST**: Als ingredienten NIET samenpassen (bijv. Choco + Zalm):
    - **MUST**: Scheid ze. Maak een hoofdgerecht met de passende ingredienten.
    - **MUST**: Suggereer de overige ingredienten als bijgerecht of dessert.
    - **MUST NOT**: Forceer slechte combinaties in een pan.

### Easter Egg (Niet-Voedsel)
- **MUST**: Analyseer ELKE ingredient.
- **MUST**: Bij detectie van minstens 1 DUIDELIJK NIET-VOEDSEL item (baksteen, zetel, etc.):
    - **MUST**: Activeer 'MODUS: BUITENAARDS'.
    - **MUST**: Gebruik EXTREME ZWARTE HUMOR en CYNISME.
    - **MUST**: Beschrijf de ingredienten alsof ze lijden.
- **MUST**: Als alles voedsel is -> 'MODUS: NORMAAL'.

### Output Formaat
- **MUST**: Volg EXACT onderstaand formaat (zonder extra tekst vooraf):

MODUS: [NORMAAL of BUITENAARDS]
TITEL: [naam van het gerecht]
CATEGORIE: [Ontbijt/Lunch/Diner/Snack/Dessert]
TIJD: [bereidingstijd in minuten, alleen het getal]
PERSONEN: [aantal porties, alleen het getal]

INGREDIENTEN:
- [ingredient 1]
- [ingredient 2]

BEREIDING:
1. [stap 1]
2. [stap 2]

TIP: [logische suggestie of variatie]"""


def bouw_gebruiker_prompt(ingredienten_lijst, allergenen_lijst=None, dieet_lijst=None,
                          categorie=None, personen=2, max_tijd=None):
    """
    Bouwt de gebruiker prompt met alle context.
    Returns: Gebruiker prompt tekst
    """
    ingredienten_tekst = ", ".join(ingredienten_lijst)
    allergenen_tekst = ", ".join(allergenen_lijst) if allergenen_lijst else "geen"
    dieet_tekst = ", ".join(dieet_lijst) if dieet_lijst else "geen"

    prompt = f"""Maak een recept met: {ingredienten_tekst}

RESTRICTIES:
- Allergieen: {allergenen_tekst}
- Dieet: {dieet_tekst}
- Personen: {personen}"""

    if categorie:
        prompt += f"\nGEWENSTE CATEGORIE: {categorie}"

    if max_tijd:
        prompt += f"\nMAXIMALE BEREIDINGSTIJD: {max_tijd} minuten"

    prompt += "\n\nGebruik het exacte output formaat zoals beschreven in je instructies."

    return prompt


# RECEPT GENERATIE

def genereer_recept(ingredienten_lijst, allergenen_lijst=None, dieet_lijst=None,
                    categorie=None, personen=2, max_tijd=None):
    """
    Genereert een recept via Ollama (lokaal AI model).
    Returns: dict met recept info of None bij fout
    """
    if not ingredienten_lijst or len(ingredienten_lijst) == 0:
        print("Geef minstens 1 ingredient op.")
        return None

    # Ollama bereikbaarheid checken
    if not check_ollama_status():
        return None

    systeem_prompt = bouw_systeem_prompt()
    gebruiker_prompt = bouw_gebruiker_prompt(
        ingredienten_lijst, allergenen_lijst, dieet_lijst, categorie, personen, max_tijd
    )

    response_tekst = stuur_ollama_verzoek(systeem_prompt, gebruiker_prompt)

    if not response_tekst:
        return None

    recept = parse_recept_response(response_tekst)
    return recept


# RESPONSE PARSING

def parse_recept_response(tekst):
    """
    Leest de AI tekst regel voor regel en stopt dit in een dictionary.
    Werkt als een staatsmachine: kijkt naar headers en verandert van modus.
    """
    recept = {
        'titel': 'Onbekend Recept',
        'categorie': 'Diner',
        'bereidingstijd': 30,
        'personen': 2,
        'ingredienten': '',
        'instructies': '',
        'tip': '',
        'is_easter_egg': False,
        'raw_response': tekst
    }

    if "MODUS:" not in tekst and "TITEL:" not in tekst:
        recept['instructies'] = tekst
        recept['titel'] = "Suggestie van de Chef"
        return recept

    regels = tekst.split('\n')
    huidige_sectie = None
    ingredienten_lijst = []
    instructies_lijst = []

    for regel in regels:
        regel = regel.strip()
        if not regel and huidige_sectie is None:
            continue

        bovenstuk = regel.upper()

        if bovenstuk.startswith('MODUS:'):
            recept['is_easter_egg'] = 'BUITENAARDS' in bovenstuk
            huidige_sectie = None

        elif bovenstuk.startswith('TITEL:'):
            recept['titel'] = regel.split(':', 1)[1].strip()
            huidige_sectie = None

        elif bovenstuk.startswith('CATEGORIE:'):
            cat = regel.split(':', 1)[1].strip()
            geldige_categorieen = ['Ontbijt', 'Lunch', 'Diner', 'Snack', 'Dessert']
            for geldige_cat in geldige_categorieen:
                if geldige_cat.lower() in cat.lower():
                    recept['categorie'] = geldige_cat
                    break
            huidige_sectie = None

        elif bovenstuk.startswith('TIJD:'):
            tijd_tekst = regel.split(':', 1)[1].strip()
            cijfers = ''.join(teken for teken in tijd_tekst if teken.isdigit())
            if cijfers:
                recept['bereidingstijd'] = int(cijfers)
            huidige_sectie = None

        elif bovenstuk.startswith('PERSONEN:'):
            pers_tekst = regel.split(':', 1)[1].strip()
            cijfers = ''.join(teken for teken in pers_tekst if teken.isdigit())
            if cijfers:
                recept['personen'] = int(cijfers)
            huidige_sectie = None

        elif bovenstuk.startswith('INGREDIENTEN:') or bovenstuk.startswith('INGREDI'):
            huidige_sectie = 'ingredienten'

        elif bovenstuk.startswith('BEREIDING:'):
            huidige_sectie = 'bereiding'

        elif bovenstuk.startswith('TIP:'):
            recept['tip'] = regel.split(':', 1)[1].strip()
            huidige_sectie = 'tip'

        elif huidige_sectie == 'ingredienten':
            if regel.startswith('-') or regel.startswith('*'):
                ingredienten_lijst.append(regel)
            elif regel and not bovenstuk.startswith(('BEREIDING', 'TIP')):
                ingredienten_lijst.append(f"- {regel}")

        elif huidige_sectie == 'bereiding':
            if bovenstuk.startswith('TIP:'):
                recept['tip'] = regel.split(':', 1)[1].strip()
                huidige_sectie = 'tip'
            elif regel:
                instructies_lijst.append(regel)

        elif huidige_sectie == 'tip':
            if regel:
                recept['tip'] += ' ' + regel

    recept['ingredienten'] = '\n'.join(ingredienten_lijst)
    recept['instructies'] = '\n'.join(instructies_lijst)

    return recept


# BOODSCHAPPENLIJST

def genereer_boodschappenlijst(recept):
    """
    Maakt een boodschappenlijst van een recept.
    Returns: string met boodschappenlijst of None bij fout
    """
    if not recept or 'ingredienten' not in recept:
        return None

    ingredienten_tekst = recept['ingredienten']
    if not ingredienten_tekst.strip():
        return None

    regels = ingredienten_tekst.split('\n')
    boodschappen = []

    for regel in regels:
        regel = regel.strip()
        if regel:
            schoon = regel.lstrip('-*').strip()
            if schoon:
                boodschappen.append(f"[ ] {schoon}")

    if not boodschappen:
        return None

    koptekst = f"BOODSCHAPPENLIJST - {recept.get('titel', 'Recept')}\n"
    koptekst += f"   Voor {recept.get('personen', 2)} personen\n"
    koptekst += "=" * 40 + "\n"

    return koptekst + '\n'.join(boodschappen)


# RECEPT WEERGAVE

def formatteer_recept(recept):
    """
    Formatteert een recept dictionary naar mooie terminal output.
    Returns: string met geformatteerd recept
    """
    if not recept:
        return "Geen recept beschikbaar."

    klr = Kleuren
    lijn = "=" * 50

    output = f"\n{klr.OKCYAN}{lijn}{klr.ENDC}\n"

    if recept.get('is_easter_egg'):
        output += f"{klr.FAIL}{klr.BOLD}BUITENAARDS RECEPT GEDETECTEERD{klr.ENDC}\n"
        output += f"{klr.OKCYAN}{lijn}{klr.ENDC}\n"

    titel = recept.get('titel', 'Onbekend Recept').upper()
    output += f"  {klr.HEADER}{klr.BOLD}{titel}{klr.ENDC}\n"
    output += f"{klr.OKCYAN}{lijn}{klr.ENDC}\n"
    output += f"Categorie:      {recept.get('categorie', 'Onbekend')}\n"
    output += f"Bereidingstijd: {recept.get('bereidingstijd', '?')} minuten\n"
    output += f"Personen:       {recept.get('personen', '?')}\n"

    output += f"\n{klr.OKGREEN}{'~' * 50}\n"
    output += "INGREDIENTEN:\n"
    output += f"{'~' * 50}{klr.ENDC}\n"
    output += f"{recept.get('ingredienten', 'Geen ingredienten')}\n"

    output += f"\n{klr.OKBLUE}{'~' * 50}\n"
    output += "BEREIDING:\n"
    output += f"{'~' * 50}{klr.ENDC}\n"
    output += f"{recept.get('instructies', 'Geen bereiding')}\n"

    if recept.get('tip'):
        output += f"\n{klr.WARNING}TIP: {recept['tip']}{klr.ENDC}\n"

    output += f"\n{klr.OKCYAN}{lijn}{klr.ENDC}\n"

    return output


# TEST FUNCTIE
def test_ai_verbinding():
    """
    Test of Ollama bereikbaar is en het model reageert.
    Returns: True als verbinding werkt, False anders
    """
    if not check_ollama_status():
        return False

    response = stuur_ollama_verzoek(
        "Je bent een test-assistent.",
        "Zeg alleen: verbinding OK"
    )

    if response:
        print(f"Ollama verbinding werkt. Response: {response.strip()}")
        return True

    print("Ollama gaf geen antwoord.")
    return False


# HELPER: INGREDIENTEN SPLITSEN
def splits_ingredienten(tekst):
    """
    Splitst een komma-gescheiden tekst naar een schone lijst.
    Returns: ["pasta", "tomaat", "ui", "knoflook"]
    """
    if not tekst or not tekst.strip():
        return []

    onderdelen = tekst.split(',')
    schone_lijst = []

    for onderdeel in onderdelen:
        schoon = onderdeel.strip().lower()
        if schoon:
            schone_lijst.append(schoon)

    return schone_lijst


# DIRECT UITVOEREN (voor snelle test)
if __name__ == "__main__":
    print("=" * 50)
    print("  Kookcompas AI Module - Ollama Test")
    print("=" * 50)

    print(f"\nModel: {AI_MODEL}")
    print(f"Ollama URL: {OLLAMA_URL}")

    print("\n--- Test 1: Verbinding ---")
    if test_ai_verbinding():
        print("\n--- Test 2: Normaal Recept ---")
        recept = genereer_recept(
            ingredienten_lijst=["pasta", "tomaat", "ui", "knoflook"],
            allergenen_lijst=["noten"],
            dieet_lijst=["vegetarisch"]
        )
        if recept:
            print(formatteer_recept(recept))
    else:
        print("Kan niet verder testen zonder werkende verbinding.")
