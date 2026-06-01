"""
dashboard-generator: trekt data uit de databank en spuwt een rijk,
modern dashboard.html uit. open dat bestand in je browser.

stijl: lichte achtergrond, gele zijbalk, meerdere secties navigeerbaar.

start: python dashboard.py
"""

import os
import json
import mysql.connector

HIER = os.path.dirname(os.path.abspath(__file__))
HTML_BESTAND = os.path.join(HIER, "dashboard.html")

DB_CONFIG = {"host": "localhost", "user": "root", "password": "",
             "database": "recipe_search",
             "charset": "utf8mb4", "use_unicode": True}


def haal(sql, params=()):
    c = mysql.connector.connect(**DB_CONFIG)
    cur = c.cursor()
    cur.execute(sql, params)
    rijen = cur.fetchall()
    cur.close()
    c.close()
    return rijen


# Vlaamse koelkast op basis van echte data:
# - Libelle Lekker artikel "14 ingredienten die je beter altijd in de koelkast hebt"
# - Belgische zuivelconsumptie: kaas 45% van zuivelaankopen, dan yogurt en melk
# - Gemiddelde vlaming pakt 8x per week melk uit de koelkast (njam.tv onderzoek)
# Aangevuld met algemene basisingredienten die elke koelkast/voorraadkast heeft
# Echte Vlaamse specialiteiten - om te checken of de DB ze kent
VLAAMSE_SPECIALITEITEN = [
    "chicory", "endive",                     # witloof
    "mussels",                                # mosselen
    "eel",                                    # paling
    "fries", "chips",                         # frieten
    "speculaas",                              # speculaas
    "waffle", "waffles",                      # belgische wafels
    "kriek", "geuze",                         # bieren
    "beef stew",                              # stoofvlees
    "praline", "pralines",                    # Belgische chocolade
    "white asparagus",                        # witte asperges
    "herring",                                # haring/maatjes
]

VLAAMSE_KOELKAST = [
    # zuivel (de vlaamse hoofdmoot)
    "milk", "butter", "cheese", "yogurt", "yoghurt", "cream",
    # eieren
    "egg", "eggs",
    # vlees/charcuterie typisch belgisch
    "ham", "bacon", "sausages",
    # groenten die altijd in huis
    "onion", "tomato", "tomatoes", "carrot", "carrots", "leek", "potatoes",
    # smaakmakers uit het libelle-artikel
    "mustard", "garlic", "parsley", "lemon", "apples",
    # basis voorraadkast
    "salt", "black pepper", "pepper", "sugar", "flour", "plain flour",
    "olive oil", "vegetable oil", "water",
]


def verzamel():
    """alles wat het dashboard nodig heeft, in een grote dict."""
    aantal_meals = haal("SELECT COUNT(*) FROM meals")[0][0]
    aantal_ingr  = haal("SELECT COUNT(*) FROM ingredients")[0][0]
    aantal_kopp  = haal("SELECT COUNT(*) FROM meal_ingredients")[0][0]
    aantal_aller = haal("SELECT COUNT(*) FROM meal_allergens")[0][0]
    aantal_zonder = haal("""
        SELECT COUNT(*) FROM meals m
        WHERE NOT EXISTS (SELECT 1 FROM meal_allergens WHERE meal_id = m.id)
    """)[0][0]

    top50_ingr = haal("""
        SELECT i.name, COUNT(*) FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        GROUP BY i.id, i.name ORDER BY COUNT(*) DESC LIMIT 50
    """)
    zeldzaam_ingr = haal("""
        SELECT i.name FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        GROUP BY i.id, i.name HAVING COUNT(*) = 1 LIMIT 30
    """)
    categorieen = haal("""
        SELECT category, COUNT(*) FROM meals WHERE category IS NOT NULL
        GROUP BY category ORDER BY COUNT(*) DESC
    """)
    herkomsten = haal("""
        SELECT area, COUNT(*) FROM meals WHERE area IS NOT NULL
        GROUP BY area ORDER BY COUNT(*) DESC
    """)
    allergenen = haal("""
        SELECT a.name, COUNT(*) FROM allergens a
        JOIN meal_allergens ma ON a.id = ma.allergen_id
        GROUP BY a.id, a.name ORDER BY COUNT(*) DESC
    """)
    complexste = haal("""
        SELECT m.area, ROUND(AVG(t.aantal), 1) FROM meals m
        JOIN (SELECT meal_id, COUNT(*) AS aantal FROM meal_ingredients
              GROUP BY meal_id) AS t ON t.meal_id = m.id
        WHERE m.area IS NOT NULL
        GROUP BY m.area HAVING COUNT(*) >= 5
        ORDER BY AVG(t.aantal) DESC LIMIT 15
    """)
    aantal_per_meal = haal("""
        SELECT t.aantal, COUNT(*) FROM (
            SELECT meal_id, COUNT(*) AS aantal
            FROM meal_ingredients GROUP BY meal_id
        ) AS t GROUP BY t.aantal ORDER BY t.aantal
    """)
    top_meals_ingr = haal("""
        SELECT m.name, COUNT(*) AS aantal FROM meals m
        JOIN meal_ingredients mi ON m.id = mi.meal_id
        GROUP BY m.id, m.name ORDER BY aantal DESC LIMIT 10
    """)
    allergeen_combos = haal("""
        SELECT a1.name, a2.name, COUNT(*) FROM meal_allergens ma1
        JOIN meal_allergens ma2 ON ma1.meal_id = ma2.meal_id AND ma1.allergen_id < ma2.allergen_id
        JOIN allergens a1 ON ma1.allergen_id = a1.id
        JOIN allergens a2 ON ma2.allergen_id = a2.id
        GROUP BY a1.name, a2.name ORDER BY COUNT(*) DESC LIMIT 10
    """)
    easter = haal("""
        SELECT i.name, COUNT(*) FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        WHERE i.name LIKE 'cavia%' OR i.name LIKE 'pinguin%'
           OR i.name LIKE 'vampier%' OR i.name LIKE 'glimworm%'
        GROUP BY i.id, i.name
    """)

    # Vlaamse koelkast analyse
    # 1. Voor elk koelkast-ingredient: hoeveel gerechten gebruiken het
    placeholders = ",".join(["%s"] * len(VLAAMSE_KOELKAST))
    koelkast_per_ingr = haal(f"""
        SELECT i.name, COUNT(*) FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        WHERE i.name IN ({placeholders})
        GROUP BY i.id, i.name
        ORDER BY COUNT(*) DESC
    """, tuple(VLAAMSE_KOELKAST))

    # 2. Top 15 gerechten die het meest met de koelkast overlappen
    koelkast_top_meals = haal(f"""
        SELECT m.name,
               COUNT(*) AS overlap,
               (SELECT COUNT(*) FROM meal_ingredients WHERE meal_id = m.id) AS totaal_ingr
        FROM meals m
        JOIN meal_ingredients mi ON m.id = mi.meal_id
        JOIN ingredients i ON i.id = mi.ingredient_id
        WHERE i.name IN ({placeholders})
        GROUP BY m.id, m.name
        ORDER BY overlap DESC, totaal_ingr ASC
        LIMIT 15
    """, tuple(VLAAMSE_KOELKAST))

    # Vlaamse specialiteiten check
    placeholders_spec = ",".join(["%s"] * len(VLAAMSE_SPECIALITEITEN))
    spec_in_db = haal(f"""
        SELECT name FROM ingredients
        WHERE LOWER(name) IN ({placeholders_spec})
    """, tuple(VLAAMSE_SPECIALITEITEN))
    spec_aanwezig = {r[0].lower() for r in spec_in_db}

    # Belgische gerechten in de DB (vaak onder Dutch/French/Other gecategoriseerd)
    belg_gerechten = haal("""
        SELECT name, area FROM meals
        WHERE area = 'Belgian' OR name LIKE '%speculaas%'
           OR name LIKE '%waterzooi%' OR name LIKE '%waffle%'
           OR name LIKE '%moules%' OR name LIKE '%witloof%'
        ORDER BY name
    """)

    # Hoeveel vlaamse koelkast-ingredienten zitten WEL in de db
    placeholders_koel = ",".join(["%s"] * len(VLAAMSE_KOELKAST))
    koelkast_match = haal(f"""
        SELECT COUNT(DISTINCT name) FROM ingredients
        WHERE name IN ({placeholders_koel})
    """, tuple(VLAAMSE_KOELKAST))[0][0]

    # 3. Gerechten die je BIJNA volledig kan maken (>= 70% overlap)
    haalbaar = haal(f"""
        SELECT COUNT(*) FROM (
            SELECT m.id,
                   (SELECT COUNT(*) FROM meal_ingredients mi
                    JOIN ingredients i ON i.id = mi.ingredient_id
                    WHERE mi.meal_id = m.id AND i.name IN ({placeholders})) AS overlap,
                   (SELECT COUNT(*) FROM meal_ingredients WHERE meal_id = m.id) AS totaal
            FROM meals m
            HAVING totaal > 0 AND overlap * 1.0 / totaal >= 0.7
        ) AS haal
    """, tuple(VLAAMSE_KOELKAST))[0][0]

    return {
        "stats": {
            "meals": aantal_meals,
            "ingredienten": aantal_ingr,
            "koppelingen": aantal_kopp,
            "allergeen_tags": aantal_aller,
            "gem_per_meal": round(aantal_kopp / aantal_meals, 1),
            "zonder_allergeen": aantal_zonder,
            "veilig_pct": round(aantal_zonder * 100 / aantal_meals, 1),
        },
        "top50_ingr":       top50_ingr,
        "zeldzaam_ingr":    [r[0] for r in zeldzaam_ingr],
        "categorieen":      categorieen,
        "herkomsten":       herkomsten,
        "allergenen":       allergenen,
        "complexste":       [(a, float(n)) for a, n in complexste],
        "aantal_per_meal":  aantal_per_meal,
        "top_meals_ingr":   top_meals_ingr,
        "allergeen_combos": allergeen_combos,
        "easter":           easter,
        "vlaamse_lijst":    VLAAMSE_KOELKAST,
        "koelkast_per_ingr": koelkast_per_ingr,
        "koelkast_top_meals": koelkast_top_meals,
        "koelkast_haalbaar": haalbaar,
        "vlaamse_spec":      VLAAMSE_SPECIALITEITEN,
        "spec_aanwezig":     list(spec_aanwezig),
        "belg_gerechten":    belg_gerechten,
        "koelkast_match":    koelkast_match,
    }


HTML = """<!DOCTYPE html>
<html lang="nl">
<head>
<meta charset="UTF-8">
<title>Kookkompas Dashboard</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Inter', sans-serif; background: #f7f5f0; color: #2a2a2a; display: flex; min-height: 100vh; }

  aside {
    width: 240px; background: #f5c542; padding: 1.5rem 1rem;
    display: flex; flex-direction: column; gap: 0.3rem;
    position: sticky; top: 0; height: 100vh;
  }
  aside .logo { display: flex; align-items: center; gap: 0.6rem; padding: 0.5rem; margin-bottom: 1rem; }
  aside .logo .bol { width: 32px; height: 32px; border-radius: 50%; background: #fff;
                     display: flex; align-items: center; justify-content: center; font-weight: 700; }
  aside .logo .naam { font-weight: 700; font-size: 1.1rem; color: #2a2a2a; }
  aside .zoek { background: #fff; border-radius: 10px; padding: 0.6rem 0.9rem; margin-bottom: 0.5rem;
                color: #888; font-size: 0.9rem; }
  aside .menu-item {
    padding: 0.7rem 0.9rem; border-radius: 10px; cursor: pointer;
    display: flex; align-items: center; gap: 0.7rem; font-weight: 500;
    color: #2a2a2a; transition: background 0.15s;
  }
  aside .menu-item:hover { background: rgba(255,255,255,0.4); }
  aside .menu-item.actief { background: #fff; font-weight: 600; }
  aside .menu-item .ic { width: 18px; opacity: 0.7; }

  main { flex: 1; padding: 2rem 2.5rem; overflow-x: hidden; }
  .top-balk { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
  .top-balk h1 { font-size: 1.8rem; font-weight: 700; }
  .top-balk .sub { color: #888; font-size: 0.9rem; }

  .grid { display: grid; gap: 1.2rem; }
  .grid-2 { grid-template-columns: repeat(2, 1fr); }
  .grid-4 { grid-template-columns: repeat(4, 1fr); }
  .vol-breed { grid-column: 1 / -1; }

  .kaart {
    background: #fff; border-radius: 16px; padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.04);
  }
  .kaart h3 { font-size: 1rem; margin-bottom: 1rem; color: #2a2a2a; font-weight: 600; }
  .kaart canvas { max-height: 320px; }

  .stat-kaart {
    background: #f5c542; border-radius: 16px; padding: 1.5rem;
  }
  .stat-kaart .label { font-size: 1rem; font-weight: 600; color: #2a2a2a; }
  .stat-kaart .nr { font-size: 2.8rem; font-weight: 800; color: #2a2a2a; margin: 0.5rem 0; line-height: 1; }
  .stat-kaart .badge {
    display: inline-block; background: rgba(0,0,0,0.08); padding: 0.2rem 0.6rem;
    border-radius: 6px; font-size: 0.8rem; font-weight: 600;
  }
  .stat-kaart.blauw { background: #1d3a8a; color: #fff; }
  .stat-kaart.blauw .label, .stat-kaart.blauw .nr { color: #fff; }
  .stat-kaart.blauw .badge { background: rgba(255,255,255,0.2); color: #fff; }
  .stat-kaart.licht { background: #fff; }

  .sectie { display: none; }
  .sectie.actief { display: block; }

  table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
  th, td { padding: 0.7rem 0.5rem; text-align: left; border-bottom: 1px solid #eee; }
  th { font-weight: 600; color: #666; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px; }
  tr:hover td { background: #fafafa; }

  .chip {
    display: inline-block; padding: 0.3rem 0.7rem; border-radius: 14px;
    background: #f5c542; font-size: 0.85rem; font-weight: 500; margin: 0.2rem;
  }
  .chip.licht { background: #f0f0f0; }
  .chip.rood  { background: #c93838; color: #fff; }

  input.zoekveld {
    width: 100%; padding: 0.8rem 1rem; border: 1px solid #ddd;
    border-radius: 10px; font-family: inherit; font-size: 0.95rem;
    margin-bottom: 1rem;
  }
</style>
</head>
<body>

<aside>
  <div class="logo">
    <div class="bol">K</div>
    <div class="naam">kookkompas</div>
  </div>
  <div class="zoek">zoeken (geen actie)</div>

  <div class="menu-item actief" data-doel="home">
    <span class="ic">⌂</span> Home
  </div>
  <div class="menu-item" data-doel="ingredients">
    <span class="ic">▤</span> Ingredienten
  </div>
  <div class="menu-item" data-doel="cuisine">
    <span class="ic">⬢</span> Categorieen
  </div>
  <div class="menu-item" data-doel="herkomst">
    <span class="ic">⌖</span> Herkomsten
  </div>
  <div class="menu-item" data-doel="allergens">
    <span class="ic">⚠</span> Allergenen
  </div>
  <div class="menu-item" data-doel="vlaams">
    <span class="ic">⚜</span> Vlaamse koelkast
  </div>
  <div class="menu-item" data-doel="dbmatch">
    <span class="ic">⚖</span> DB-match
  </div>
  <div class="menu-item" data-doel="extra">
    <span class="ic">✦</span> Extra inzichten
  </div>
</aside>

<main>

  <section id="home" class="sectie actief">
    <div class="top-balk">
      <div>
        <h1>kookkompas analyse</h1>
        <div class="sub">data uit recipe_search, bron themealdb</div>
      </div>
    </div>

    <div class="grid grid-4" style="margin-bottom: 1.2rem;">
      <div class="stat-kaart">
        <div class="label">Gerechten</div>
        <div class="nr" id="s-meals"></div>
        <div class="badge">100%</div>
      </div>
      <div class="stat-kaart blauw">
        <div class="label">Ingredienten</div>
        <div class="nr" id="s-ingr"></div>
        <div class="badge">uniek</div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Gem ingr / gerecht</div>
        <div class="nr" id="s-gem"></div>
        <div class="badge">N-M koppelingen</div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Allergeen-vrij</div>
        <div class="nr" id="s-veilig"></div>
        <div class="badge" id="s-veilig-aantal"></div>
      </div>
    </div>

    <div class="grid grid-2">
      <div class="kaart"><h3>Top 10 meest gebruikte ingredienten</h3><canvas id="c-top10"></canvas></div>
      <div class="kaart"><h3>Verdeling per categorie</h3><canvas id="c-cat-donut"></canvas></div>
      <div class="kaart vol-breed"><h3>Top 15 herkomsten</h3><canvas id="c-herk-overzicht"></canvas></div>
    </div>
  </section>

  <section id="ingredients" class="sectie">
    <div class="top-balk">
      <div><h1>ingredienten deep-dive</h1>
      <div class="sub">welke ingredienten domineren de keuken</div></div>
    </div>

    <input class="zoekveld" placeholder="filter de top 50 lijst..." oninput="filterTop(this.value)">

    <div class="grid grid-2">
      <div class="kaart vol-breed"><h3>Top 50 ingredienten</h3><canvas id="c-top50" style="max-height:600px"></canvas></div>
      <div class="kaart">
        <h3>Zeldzaamheden (komen maar 1x voor)</h3>
        <div id="zeldzaam-chips"></div>
      </div>
      <div class="kaart">
        <h3>Aantal ingredienten per gerecht (verdeling)</h3>
        <canvas id="c-per-meal"></canvas>
      </div>
      <div class="kaart vol-breed"><h3>Top 10 meest complexe gerechten</h3><canvas id="c-meals-ingr"></canvas></div>
    </div>
  </section>

  <section id="cuisine" class="sectie">
    <div class="top-balk">
      <div><h1>categorieen</h1><div class="sub">wat voor soort gerechten zitten in de databank</div></div>
    </div>

    <div class="grid grid-2">
      <div class="kaart"><h3>Aandeel per categorie</h3><canvas id="c-cat-pie"></canvas></div>
      <div class="kaart"><h3>Categorie verdeling (staaf)</h3><canvas id="c-cat-bar"></canvas></div>
      <div class="kaart vol-breed">
        <h3>Tabel categorieen</h3>
        <table>
          <thead><tr><th>Categorie</th><th>Aantal</th><th>Percentage</th></tr></thead>
          <tbody id="t-cat"></tbody>
        </table>
      </div>
    </div>
  </section>

  <section id="herkomst" class="sectie">
    <div class="top-balk">
      <div><h1>herkomsten</h1><div class="sub">welke keukens zitten vertegenwoordigd</div></div>
    </div>

    <div class="grid grid-2">
      <div class="kaart vol-breed"><h3>Aantal gerechten per herkomst</h3><canvas id="c-herk-volledig" style="max-height:500px"></canvas></div>
      <div class="kaart vol-breed"><h3>Meest complexe keukens (gem ingredienten per gerecht)</h3><canvas id="c-complex"></canvas></div>
    </div>
  </section>

  <section id="allergens" class="sectie">
    <div class="top-balk">
      <div><h1>allergenen</h1><div class="sub">wat zit waar in en wat is veilig</div></div>
    </div>

    <div class="grid grid-2">
      <div class="kaart"><h3>Allergenen aandeel</h3><canvas id="c-all-donut"></canvas></div>
      <div class="kaart"><h3>Kans per allergeen</h3><canvas id="c-all-bar"></canvas></div>
      <div class="kaart vol-breed">
        <h3>Combinaties die vaak samen voorkomen</h3>
        <table>
          <thead><tr><th>Combinatie</th><th>Aantal gerechten</th></tr></thead>
          <tbody id="t-combos"></tbody>
        </table>
      </div>
    </div>
  </section>

  <section id="vlaams" class="sectie">
    <div class="top-balk">
      <div><h1>vlaamse koelkast</h1>
      <div class="sub">wat heeft een gemiddelde vlaming altijd in huis, en hoeveel themealdb gerechten kunnen daarmee gemaakt worden</div></div>
    </div>

    <div class="grid grid-4" style="margin-bottom: 1.2rem;">
      <div class="stat-kaart">
        <div class="label">In de koelkast</div>
        <div class="nr" id="v-aantal"></div>
        <div class="badge">basis-ingredienten</div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Gerechten haalbaar (>=70%)</div>
        <div class="nr" id="v-haalbaar"></div>
        <div class="badge" id="v-haalbaar-pct"></div>
      </div>
      <div class="stat-kaart blauw">
        <div class="label">Gebruikt salt</div>
        <div class="nr" id="v-salt"></div>
        <div class="badge">van de 605 gerechten</div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Gebruikt aardappel</div>
        <div class="nr" id="v-aardappel"></div>
        <div class="badge">gerechten</div>
      </div>
    </div>

    <div class="grid grid-2">
      <div class="kaart vol-breed">
        <h3>Hoe vaak komt elk koelkast-ingredient voor in themealdb</h3>
        <canvas id="c-koelkast" style="max-height:500px"></canvas>
      </div>
      <div class="kaart vol-breed">
        <h3>Top 15 gerechten die je met de koelkast bijna volledig kan maken</h3>
        <table>
          <thead><tr><th>Gerecht</th><th>Koelkast-overlap</th><th>Totaal ingredienten</th><th>Volledig haalbaar</th></tr></thead>
          <tbody id="t-koelkast-meals"></tbody>
        </table>
      </div>
      <div class="kaart vol-breed">
        <h3>De vlaamse basisuitrusting</h3>
        <div id="koelkast-chips"></div>
      </div>
    </div>
  </section>

  <section id="dbmatch" class="sectie">
    <div class="top-balk">
      <div><h1>themealdb match met de vlaming</h1>
      <div class="sub">is deze databank wel geschikt voor onze keuken, of moeten we een andere zoeken</div></div>
    </div>

    <div class="grid grid-4" style="margin-bottom: 1.2rem;">
      <div class="stat-kaart">
        <div class="label">Match-score</div>
        <div class="nr" id="m-score"></div>
        <div class="badge" id="m-verdict"></div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Koelkast-dekking</div>
        <div class="nr" id="m-koelkast"></div>
        <div class="badge" id="m-koelkast-pct"></div>
      </div>
      <div class="stat-kaart blauw">
        <div class="label">Vlaamse specialiteiten gevonden</div>
        <div class="nr" id="m-spec"></div>
        <div class="badge" id="m-spec-totaal"></div>
      </div>
      <div class="stat-kaart licht">
        <div class="label">Belgische gerechten</div>
        <div class="nr" id="m-belg"></div>
        <div class="badge">van de 605</div>
      </div>
    </div>

    <div class="grid grid-2">
      <div class="kaart vol-breed">
        <h3>Welke vlaamse specialiteiten zitten erin?</h3>
        <table>
          <thead><tr><th>Specialiteit</th><th>Aanwezig?</th></tr></thead>
          <tbody id="t-specs"></tbody>
        </table>
      </div>
      <div class="kaart">
        <h3>Echte Belgische gerechten in de DB</h3>
        <div id="belg-lijst"></div>
      </div>
      <div class="kaart">
        <h3>Conclusie</h3>
        <div id="conclusie" style="line-height: 1.6;"></div>
      </div>
      <div class="kaart vol-breed">
        <h3>Alternatieve databanken om te overwegen</h3>
        <ul style="list-style: disc; padding-left: 1.2rem; line-height: 1.8;" id="alt-lijst"></ul>
      </div>
    </div>
  </section>

  <section id="extra" class="sectie">
    <div class="top-balk">
      <div><h1>extra inzichten</h1><div class="sub">leuke vondsten en easter eggs</div></div>
    </div>

    <div class="grid grid-2">
      <div class="kaart">
        <h3>Easter eggs (verzonnen ingredienten)</h3>
        <div id="easter-lijst"></div>
      </div>
      <div class="kaart">
        <h3>Snelle feiten</h3>
        <ul id="feiten-lijst" style="list-style: disc; padding-left: 1.2rem; line-height: 1.8;"></ul>
      </div>
    </div>
  </section>

</main>

<script>
const D = __DATA__;
const TOT = D.stats.meals;

// veilige DOM helpers - geen innerHTML voor data
function maakChip(tekst, klasse) {
  const el = document.createElement('span');
  el.className = 'chip ' + (klasse || '');
  el.textContent = tekst;
  return el;
}

function rij(...cellen) {
  const tr = document.createElement('tr');
  cellen.forEach(c => {
    const td = document.createElement('td');
    if (c instanceof Node) td.appendChild(c);
    else td.textContent = String(c);
    tr.appendChild(td);
  });
  return tr;
}

// menu navigatie
document.querySelectorAll('.menu-item').forEach(m => {
  m.addEventListener('click', () => {
    document.querySelectorAll('.sectie').forEach(s => s.classList.remove('actief'));
    document.querySelectorAll('.menu-item').forEach(x => x.classList.remove('actief'));
    document.getElementById(m.dataset.doel).classList.add('actief');
    m.classList.add('actief');
  });
});

// stat-kaarten
document.getElementById('s-meals').textContent = D.stats.meals;
document.getElementById('s-ingr').textContent = D.stats.ingredienten;
document.getElementById('s-gem').textContent = D.stats.gem_per_meal;
document.getElementById('s-veilig').textContent = D.stats.veilig_pct + '%';
document.getElementById('s-veilig-aantal').textContent = D.stats.zonder_allergeen + ' gerechten';

const GEEL = '#f5c542', BLAUW = '#1d3a8a', GROEN = '#4f8d5e', ROOD = '#c93838';
const PALET = [GEEL, BLAUW, GROEN, ROOD, '#9b59b6', '#16a085', '#e67e22', '#34495e',
               '#fde8a6', '#7fa6e8', '#f39c12', '#1abc9c', '#e74c3c', '#8e44ad'];
const ASOPTIES = {
  y: { ticks: { color: '#666' }, grid: { color: '#eee' } },
  x: { ticks: { color: '#666' }, grid: { color: '#eee' } }
};

new Chart(document.getElementById('c-top10'), {
  type: 'bar',
  data: { labels: D.top50_ingr.slice(0, 10).map(r => r[0]),
          datasets: [{ data: D.top50_ingr.slice(0, 10).map(r => r[1]),
                       backgroundColor: GEEL, borderRadius: 6 }] },
  options: { indexAxis: 'y', plugins: { legend: { display: false } }, scales: ASOPTIES }
});

new Chart(document.getElementById('c-cat-donut'), {
  type: 'doughnut',
  data: { labels: D.categorieen.map(r => r[0]),
          datasets: [{ data: D.categorieen.map(r => r[1]), backgroundColor: PALET }] },
  options: { plugins: { legend: { position: 'right', labels: { font: { size: 11 } } } } }
});

new Chart(document.getElementById('c-herk-overzicht'), {
  type: 'bar',
  data: { labels: D.herkomsten.slice(0, 15).map(r => r[0]),
          datasets: [{ data: D.herkomsten.slice(0, 15).map(r => r[1]),
                       backgroundColor: BLAUW, borderRadius: 6 }] },
  options: { plugins: { legend: { display: false } }, scales: ASOPTIES }
});

let top50Chart;
function tekenTop50(rijen) {
  if (top50Chart) top50Chart.destroy();
  top50Chart = new Chart(document.getElementById('c-top50'), {
    type: 'bar',
    data: { labels: rijen.map(r => r[0]),
            datasets: [{ data: rijen.map(r => r[1]), backgroundColor: GEEL, borderRadius: 4 }] },
    options: {
      indexAxis: 'y',
      plugins: { legend: { display: false },
                 tooltip: { callbacks: {
                   label: ctx => ctx.raw + ' gerechten (' + (ctx.raw*100/TOT).toFixed(1) + '%)'
                 }}},
      scales: ASOPTIES
    }
  });
}
tekenTop50(D.top50_ingr);

function filterTop(t) {
  t = t.toLowerCase();
  const f = D.top50_ingr.filter(r => r[0].toLowerCase().includes(t));
  tekenTop50(f.length ? f : D.top50_ingr);
}

// zeldzaamheden via DOM
const zeldHost = document.getElementById('zeldzaam-chips');
D.zeldzaam_ingr.forEach(n => zeldHost.appendChild(maakChip(n, 'licht')));

new Chart(document.getElementById('c-per-meal'), {
  type: 'bar',
  data: { labels: D.aantal_per_meal.map(r => r[0]),
          datasets: [{ data: D.aantal_per_meal.map(r => r[1]),
                       backgroundColor: BLAUW, borderRadius: 4 }] },
  options: { plugins: { legend: { display: false } }, scales: ASOPTIES }
});

new Chart(document.getElementById('c-meals-ingr'), {
  type: 'bar',
  data: { labels: D.top_meals_ingr.map(r => r[0]),
          datasets: [{ data: D.top_meals_ingr.map(r => r[1]),
                       backgroundColor: GROEN, borderRadius: 6 }] },
  options: { indexAxis: 'y', plugins: { legend: { display: false } }, scales: ASOPTIES }
});

new Chart(document.getElementById('c-cat-pie'), {
  type: 'pie',
  data: { labels: D.categorieen.map(r => r[0]),
          datasets: [{ data: D.categorieen.map(r => r[1]), backgroundColor: PALET }] },
  options: { plugins: { legend: { position: 'right' } } }
});

new Chart(document.getElementById('c-cat-bar'), {
  type: 'bar',
  data: { labels: D.categorieen.map(r => r[0]),
          datasets: [{ data: D.categorieen.map(r => r[1]),
                       backgroundColor: GEEL, borderRadius: 6 }] },
  options: { indexAxis: 'y', plugins: { legend: { display: false } }, scales: ASOPTIES }
});

const tCat = document.getElementById('t-cat');
D.categorieen.forEach(r =>
  tCat.appendChild(rij(r[0], r[1], (r[1]*100/TOT).toFixed(1) + '%'))
);

new Chart(document.getElementById('c-herk-volledig'), {
  type: 'bar',
  data: { labels: D.herkomsten.map(r => r[0]),
          datasets: [{ data: D.herkomsten.map(r => r[1]),
                       backgroundColor: BLAUW, borderRadius: 4 }] },
  options: { indexAxis: 'y', plugins: { legend: { display: false } }, scales: ASOPTIES }
});

new Chart(document.getElementById('c-complex'), {
  type: 'bar',
  data: { labels: D.complexste.map(r => r[0]),
          datasets: [{ data: D.complexste.map(r => r[1]),
                       backgroundColor: GROEN, borderRadius: 6 }] },
  options: { plugins: { legend: { display: false } }, scales: ASOPTIES }
});

new Chart(document.getElementById('c-all-donut'), {
  type: 'doughnut',
  data: { labels: D.allergenen.map(r => r[0]),
          datasets: [{ data: D.allergenen.map(r => r[1]),
                       backgroundColor: ['#c93838','#f5c542','#1d3a8a','#9b59b6',
                                         '#16a085','#e67e22','#34495e','#f39c12',
                                         '#1abc9c','#8e44ad'] }] },
  options: { plugins: { legend: { position: 'right' } } }
});

new Chart(document.getElementById('c-all-bar'), {
  type: 'bar',
  data: { labels: D.allergenen.map(r => r[0]),
          datasets: [{ data: D.allergenen.map(r => +(r[1]*100/TOT).toFixed(1)),
                       backgroundColor: ROOD, borderRadius: 6 }] },
  options: {
    plugins: { legend: { display: false },
      tooltip: { callbacks: { label: ctx => ctx.raw + '% van alle gerechten' }}
    },
    scales: ASOPTIES
  }
});

const tCombos = document.getElementById('t-combos');
D.allergeen_combos.forEach(r => {
  const cel = document.createElement('div');
  cel.appendChild(maakChip(r[0], 'rood'));
  cel.appendChild(document.createTextNode(' + '));
  cel.appendChild(maakChip(r[1], 'rood'));
  tCombos.appendChild(rij(cel, r[2]));
});

const easterHost = document.getElementById('easter-lijst');
D.easter.forEach(r => {
  const p = document.createElement('p');
  p.style.margin = '0.5rem 0';
  p.appendChild(maakChip(r[0]));
  const span = document.createElement('span');
  span.style.color = '#666';
  span.textContent = ' in ' + r[1] + ' gerecht' + (r[1] > 1 ? 'en' : '');
  p.appendChild(span);
  easterHost.appendChild(p);
});

// db-match sectie
const koelkastDekkingPct = Math.round(D.koelkast_match * 100 / D.vlaamse_lijst.length);
const specGevonden = D.spec_aanwezig.length;
const specTotaal = D.vlaamse_spec.length;
const belgAantal = D.belg_gerechten.length;

// match-score berekening: koelkast-dekking telt voor 5, specs voor 3, belg-gerechten voor 2
const score = Math.round(
  (koelkastDekkingPct / 100) * 5 +
  (specGevonden / specTotaal) * 3 +
  Math.min(belgAantal / 10, 1) * 2
);

document.getElementById('m-score').textContent = score + '/10';
document.getElementById('m-verdict').textContent =
  score >= 7 ? 'goede match' : (score >= 4 ? 'redelijk' : 'matig');
document.getElementById('m-koelkast').textContent = D.koelkast_match + '/' + D.vlaamse_lijst.length;
document.getElementById('m-koelkast-pct').textContent = koelkastDekkingPct + '% dekking';
document.getElementById('m-spec').textContent = specGevonden + '/' + specTotaal;
document.getElementById('m-spec-totaal').textContent = 'vlaams specifiek';
document.getElementById('m-belg').textContent = belgAantal;

// Tabel specialiteiten
const tSpecs = document.getElementById('t-specs');
D.vlaamse_spec.forEach(s => {
  const aanwezig = D.spec_aanwezig.includes(s.toLowerCase());
  const status = document.createElement('span');
  status.className = 'chip ' + (aanwezig ? '' : 'rood');
  status.textContent = aanwezig ? 'ja, gevonden' : 'ontbreekt';
  tSpecs.appendChild(rij(s, status));
});

// Belgische gerechten lijst
const belgHost = document.getElementById('belg-lijst');
if (D.belg_gerechten.length) {
  D.belg_gerechten.forEach(g => {
    const p = document.createElement('p');
    p.style.margin = '0.4rem 0';
    p.appendChild(maakChip(g[0]));
    if (g[1]) {
      const s = document.createElement('span');
      s.style.color = '#666';
      s.textContent = ' (' + g[1] + ')';
      p.appendChild(s);
    }
    belgHost.appendChild(p);
  });
} else {
  const p = document.createElement('p');
  p.style.color = '#666';
  p.textContent = 'Geen enkel echt Belgisch gerecht gevonden.';
  belgHost.appendChild(p);
}

// Conclusie tekst
const conclusie = document.getElementById('conclusie');
const conP = document.createElement('p');
let conTekst;
if (score >= 7) {
  conTekst = 'TheMealDB werkt prima voor de vlaamse koelkast. Basisingredienten zitten erin, een paar specialiteiten ook, je kan ermee aan de slag.';
} else if (score >= 4) {
  conTekst = 'TheMealDB is redelijk bruikbaar. De basisingredienten zitten erin, maar typische vlaamse specialiteiten (witloof, paling, kriek, stoofvlees, waterzooi) ontbreken grotendeels. Voor een echt vlaams kookkompas zou je een lokale receptenbron erbij willen.';
} else {
  conTekst = 'TheMealDB is een engelstalige/internationale databank zonder vlaamse specialiteiten. Voor een vlaams publiek mist veel essentieels. Aanrader: combineer met een lokale bron.';
}
conP.textContent = conTekst;
conclusie.appendChild(conP);

const alternatieven = [
  'Smulweb (NL/BE recepten, gratis API beschikbaar)',
  '15gram.be of dagelijksekost.een.be voor specifiek Vlaamse recepten',
  'Allerhande (Albert Heijn) - veel Belgische klassiekers',
  'Lekker van bij ons / VLAM database voor 100% Belgisch product-info',
  'Eigen lokaal samengestelde DB met handmatig ingevoerde stoofvlees, waterzooi, mosselen-friet enz.',
];
const altHost = document.getElementById('alt-lijst');
alternatieven.forEach(a => {
  const li = document.createElement('li');
  li.textContent = a;
  altHost.appendChild(li);
});

// vlaamse koelkast sectie
const koelkastIngrLijst = D.koelkast_per_ingr;
const saltRij = koelkastIngrLijst.find(r => r[0] === 'salt');
const aardappelRij = koelkastIngrLijst.find(r => r[0] === 'potatoes');
document.getElementById('v-aantal').textContent = D.vlaamse_lijst.length;
document.getElementById('v-haalbaar').textContent = D.koelkast_haalbaar;
document.getElementById('v-haalbaar-pct').textContent =
  (D.koelkast_haalbaar * 100 / TOT).toFixed(1) + '% van db';
document.getElementById('v-salt').textContent = saltRij ? saltRij[1] : 0;
document.getElementById('v-aardappel').textContent = aardappelRij ? aardappelRij[1] : 0;

new Chart(document.getElementById('c-koelkast'), {
  type: 'bar',
  data: { labels: koelkastIngrLijst.map(r => r[0]),
          datasets: [{ data: koelkastIngrLijst.map(r => r[1]),
                       backgroundColor: GEEL, borderRadius: 4 }] },
  options: {
    indexAxis: 'y',
    plugins: { legend: { display: false },
               tooltip: { callbacks: {
                 label: ctx => ctx.raw + ' gerechten (' + (ctx.raw*100/TOT).toFixed(1) + '%)'
               }}},
    scales: ASOPTIES
  }
});

const tKoelkast = document.getElementById('t-koelkast-meals');
D.koelkast_top_meals.forEach(r => {
  const pct = (r[1] * 100 / r[2]).toFixed(0) + '%';
  tKoelkast.appendChild(rij(r[0], r[1], r[2], pct));
});

const koelkastChips = document.getElementById('koelkast-chips');
D.vlaamse_lijst.forEach(n => koelkastChips.appendChild(maakChip(n)));

const meestGebruikt = D.top50_ingr[0];
const feiten = [
  meestGebruikt[0] + ' is het meest gebruikte ingredient: in ' + meestGebruikt[1] + ' gerechten oftewel ' + (meestGebruikt[1]*100/TOT).toFixed(1) + '% van alles.',
  'gemiddeld ' + D.stats.gem_per_meal + ' ingredienten per gerecht.',
  D.stats.zonder_allergeen + ' gerechten hebben geen enkele gedetecteerde allergeen (' + D.stats.veilig_pct + '%).',
  D.zeldzaam_ingr.length + '+ ingredienten komen maar in 1 gerecht voor - lange staart.',
  'lactose is het meest voorkomende allergeen: in ' + D.allergenen[0][1] + ' gerechten.',
  'de ' + D.complexste[0][0] + ' keuken is het meest complex: gemiddeld ' + D.complexste[0][1] + ' ingredienten per gerecht.',
];
const feitenHost = document.getElementById('feiten-lijst');
feiten.forEach(f => {
  const li = document.createElement('li');
  li.textContent = f;
  feitenHost.appendChild(li);
});
</script>
</body>
</html>
"""


def schrijf():
    data = verzamel()
    html = HTML.replace("__DATA__", json.dumps(data, ensure_ascii=False))
    with open(HTML_BESTAND, "w", encoding="utf-8") as f:
        f.write(html)
    print(f"dashboard.html geschreven: {HTML_BESTAND}")
    print("open in browser om het dashboard te zien.")


if __name__ == "__main__":
    schrijf()
