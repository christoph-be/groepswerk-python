"""
analyse-script op de recipe_search databank.
geen onderdeel van het inleverwerk, gewoon om te zien wat er in de
gekookte wereld het meeste voorkomt.

start: python analyse.py
schrijft naar rapport.txt in dezelfde map.
"""

import os
import mysql.connector

HIER = os.path.dirname(os.path.abspath(__file__))
RAPPORT = os.path.join(HIER, "rapport.txt")

DB_CONFIG = {"host": "localhost", "user": "root", "password": "",
             "database": "recipe_search",
             "charset": "utf8mb4", "use_unicode": True}


def query(c, sql, params=()):
    """gewone helper om resultaat als lijst tuples terug te krijgen."""
    cur = c.cursor()
    cur.execute(sql, params)
    rijen = cur.fetchall()
    cur.close()
    return rijen


def cijfer(c, sql, params=()):
    """voor queries die 1 getal teruggeven."""
    return query(c, sql, params)[0][0]


def tabel(titel, kolommen, rijen, breedte=None):
    """maakt een tekst-tabel met titel, kolommen en rijen. simpel maar leesbaar."""
    uit = [titel, "=" * len(titel), ""]

    # kolombreedtes bepalen op basis van inhoud
    if breedte is None:
        breedte = []
        for i in range(len(kolommen)):
            max_len = len(kolommen[i])
            for r in rijen:
                max_len = max(max_len, len(str(r[i])))
            breedte.append(max_len + 2)

    # header
    header = "".join(k.ljust(b) for k, b in zip(kolommen, breedte))
    uit.append(header)
    uit.append("-" * len(header))

    # rijen
    for r in rijen:
        uit.append("".join(str(c).ljust(b) for c, b in zip(r, breedte)))

    uit.append("")
    return "\n".join(uit)


def maak_rapport():
    c = mysql.connector.connect(**DB_CONFIG)

    secties = []
    secties.append("KOOKKOMPAS ANALYSE - RAPPORT")
    secties.append("=" * 28)
    secties.append("")
    secties.append("databank: recipe_search")
    secties.append("bron: themealdb.com")
    secties.append("")

    # algemene cijfers
    aantal_meals = cijfer(c, "SELECT COUNT(*) FROM meals")
    aantal_ingr  = cijfer(c, "SELECT COUNT(*) FROM ingredients")
    aantal_kopp  = cijfer(c, "SELECT COUNT(*) FROM meal_ingredients")
    gem_ingr     = round(aantal_kopp / aantal_meals, 1)

    secties.append("ALGEMEEN")
    secties.append("--------")
    secties.append(f"aantal gerechten:        {aantal_meals}")
    secties.append(f"aantal unieke ingredienten: {aantal_ingr}")
    secties.append(f"aantal koppelingen:      {aantal_kopp}")
    secties.append(f"gemiddeld per gerecht:   {gem_ingr} ingredienten")
    secties.append("")

    # top 20 meest gebruikte ingredienten met kans
    rijen = query(c, """
        SELECT i.name,
               COUNT(*) AS aantal,
               ROUND(COUNT(*) * 100.0 / %s, 1) AS kans_procent
        FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        GROUP BY i.id, i.name
        ORDER BY aantal DESC
        LIMIT 20
    """, (aantal_meals,))
    secties.append(tabel(
        "TOP 20 MEEST GEBRUIKTE INGREDIENTEN",
        ["ingredient", "in # gerechten", "kans dat random gerecht het bevat"],
        rijen
    ))

    # top 10 categorieen
    rijen = query(c, """
        SELECT category, COUNT(*) AS aantal
        FROM meals WHERE category IS NOT NULL
        GROUP BY category ORDER BY aantal DESC LIMIT 10
    """)
    secties.append(tabel(
        "TOP 10 CATEGORIEEN",
        ["categorie", "aantal gerechten"],
        rijen
    ))

    # top 10 herkomsten
    rijen = query(c, """
        SELECT area, COUNT(*) AS aantal
        FROM meals WHERE area IS NOT NULL
        GROUP BY area ORDER BY aantal DESC LIMIT 10
    """)
    secties.append(tabel(
        "TOP 10 HERKOMSTEN",
        ["herkomst", "aantal gerechten"],
        rijen
    ))

    # allergenen-verdeling
    rijen = query(c, """
        SELECT a.name,
               COUNT(*) AS aantal,
               ROUND(COUNT(*) * 100.0 / %s, 1) AS kans
        FROM allergens a
        JOIN meal_allergens ma ON a.id = ma.allergen_id
        GROUP BY a.id, a.name
        ORDER BY aantal DESC
    """, (aantal_meals,))
    secties.append(tabel(
        "ALLERGENEN - VOORKOMEN",
        ["allergeen", "in # gerechten", "kans %"],
        rijen
    ))

    # gerechten zonder allergenen
    aantal_zonder = cijfer(c, """
        SELECT COUNT(*) FROM meals m
        WHERE NOT EXISTS (SELECT 1 FROM meal_allergens WHERE meal_id = m.id)
    """)
    secties.append(f"gerechten zonder gedetecteerde allergenen: {aantal_zonder} "
                   f"({round(aantal_zonder * 100 / aantal_meals, 1)}%)")
    secties.append("")

    # ingredienten die maar in 1 gerecht voorkomen (zeldzaamheden)
    zeldzaam = cijfer(c, """
        SELECT COUNT(*) FROM (
            SELECT ingredient_id FROM meal_ingredients
            GROUP BY ingredient_id HAVING COUNT(*) = 1
        ) AS solo
    """)
    secties.append(f"ingredienten die maar in 1 gerecht voorkomen: {zeldzaam} "
                   f"({round(zeldzaam * 100 / aantal_ingr, 1)}% van alle ingredienten)")
    secties.append("")

    # top 10 herkomsten met meest ingredienten per gerecht (complexe keukens)
    rijen = query(c, """
        SELECT m.area,
               ROUND(AVG(per_meal.aantal), 1) AS gem_ingr
        FROM meals m
        JOIN (SELECT meal_id, COUNT(*) AS aantal
              FROM meal_ingredients GROUP BY meal_id) AS per_meal
          ON per_meal.meal_id = m.id
        WHERE m.area IS NOT NULL
        GROUP BY m.area
        HAVING COUNT(*) >= 5
        ORDER BY gem_ingr DESC LIMIT 10
    """)
    secties.append(tabel(
        "MEEST COMPLEXE KEUKENS (gemiddeld aantal ingredienten per gerecht)",
        ["herkomst", "gem ingredienten"],
        rijen
    ))

    # easter eggs
    rijen = query(c, """
        SELECT i.name, COUNT(*) AS aantal_gerechten
        FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        WHERE i.name LIKE 'cavia%' OR i.name LIKE 'pinguin%'
           OR i.name LIKE 'vampier%' OR i.name LIKE 'glimworm%'
        GROUP BY i.id, i.name
    """)
    if rijen:
        secties.append(tabel(
            "EASTER EGGS (verzonnen ingredienten)",
            ["ingredient", "in # gerechten"],
            rijen
        ))

    c.close()

    inhoud = "\n".join(secties)
    with open(RAPPORT, "w", encoding="utf-8") as f:
        f.write(inhoud)

    print(f"rapport geschreven naar {RAPPORT}")
    print(f"({len(inhoud.splitlines())} regels)")


if __name__ == "__main__":
    maak_rapport()
