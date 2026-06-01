"""
tinker-venster met staafdiagrammen op de recipe_search databank.
toont hoe vaak welk ingredient/categorie/allergeen voorkomt.

start: python grafiek.py
"""

import os
import tkinter as tk
from tkinter import ttk
import mysql.connector

DB_CONFIG = {"host": "localhost", "user": "root", "password": "",
             "database": "recipe_search",
             "charset": "utf8mb4", "use_unicode": True}


def haal_data(sql, params=()):
    """sql query uitvoeren en lijst tuples teruggeven."""
    c = mysql.connector.connect(**DB_CONFIG)
    cur = c.cursor()
    cur.execute(sql, params)
    rijen = cur.fetchall()
    cur.close()
    c.close()
    return rijen


def aantal_gerechten():
    return haal_data("SELECT COUNT(*) FROM meals")[0][0]


# de drie dataset-queries
TOTAAL = aantal_gerechten()


VIEWS = {
    "Top 20 ingredienten": ("""
        SELECT i.name, COUNT(*) AS aantal
        FROM ingredients i
        JOIN meal_ingredients mi ON i.id = mi.ingredient_id
        GROUP BY i.id, i.name
        ORDER BY aantal DESC LIMIT 20
    """, "#3d6cb9"),

    "Categorieen": ("""
        SELECT category, COUNT(*) FROM meals
        WHERE category IS NOT NULL
        GROUP BY category ORDER BY COUNT(*) DESC
    """, "#4f8d5e"),

    "Herkomsten": ("""
        SELECT area, COUNT(*) FROM meals
        WHERE area IS NOT NULL
        GROUP BY area ORDER BY COUNT(*) DESC
    """, "#c98c38"),

    "Allergenen": ("""
        SELECT a.name, COUNT(*) AS aantal
        FROM allergens a
        JOIN meal_allergens ma ON a.id = ma.allergen_id
        GROUP BY a.id, a.name
        ORDER BY aantal DESC
    """, "#c93838"),
}


class StaafDiagram:
    def __init__(self, venster):
        self.venster = venster
        self.venster.title("kookkompas analyse")
        self.venster.geometry("900x650")
        self.venster.configure(bg="#1a1a1a")

        # bovenbalk met knoppen om te wisselen tussen views
        knoppenbalk = tk.Frame(self.venster, bg="#0d0d0d", height=50)
        knoppenbalk.pack(fill="x")

        tk.Label(knoppenbalk, text="kookkompas",
                 fg="#fff", bg="#0d0d0d",
                 font=("Segoe UI", 14, "bold")).pack(side="left", padx=15)

        for naam in VIEWS:
            tk.Button(knoppenbalk, text=naam,
                      bg="#242424", fg="#fff",
                      activebackground="#3d6cb9", activeforeground="#fff",
                      relief="flat", padx=12, pady=8,
                      command=lambda n=naam: self.toon(n)
                      ).pack(side="left", padx=4, pady=8)

        # canvas voor de balken
        self.canvas = tk.Canvas(self.venster, bg="#1a1a1a", highlightthickness=0)
        self.canvas.pack(fill="both", expand=True, padx=20, pady=20)

        # status onderaan
        self.status = tk.Label(self.venster, text="",
                               fg="#888", bg="#1a1a1a",
                               font=("Segoe UI", 9))
        self.status.pack(side="bottom", fill="x", pady=5)

        # starten met top ingredienten
        self.toon("Top 20 ingredienten")

    def toon(self, naam):
        sql, kleur = VIEWS[naam]
        rijen = haal_data(sql)
        self.teken(naam, rijen, kleur)

    def teken(self, titel, rijen, kleur):
        self.canvas.delete("all")
        if not rijen:
            return

        max_aantal = max(r[1] for r in rijen)
        breedte = self.canvas.winfo_width() or 850
        ruimte_label = 180  # links voor labels
        ruimte_telling = 70  # rechts voor getallen
        bar_zone = breedte - ruimte_label - ruimte_telling - 40

        hoogte_per_balk = 25
        ruimte_tussen = 4

        # titel bovenaan
        self.canvas.create_text(20, 20, anchor="w", fill="#fff",
                                font=("Segoe UI", 14, "bold"),
                                text=titel)

        y = 60
        for naam, aantal in rijen:
            kans = round(aantal * 100 / TOTAAL, 1)
            balk_breedte = (aantal / max_aantal) * bar_zone

            # label links
            label_text = naam if len(naam) < 25 else naam[:23] + ".."
            self.canvas.create_text(ruimte_label, y + hoogte_per_balk / 2,
                                    anchor="e", fill="#e0e0e0",
                                    font=("Segoe UI", 10),
                                    text=label_text)

            # balk zelf
            x_start = ruimte_label + 10
            self.canvas.create_rectangle(x_start, y,
                                         x_start + balk_breedte,
                                         y + hoogte_per_balk,
                                         fill=kleur, outline="")

            # getal + % rechts van de balk
            self.canvas.create_text(x_start + balk_breedte + 8,
                                    y + hoogte_per_balk / 2,
                                    anchor="w", fill="#fff",
                                    font=("Segoe UI", 10),
                                    text=f"{aantal}  ({kans}%)")

            y += hoogte_per_balk + ruimte_tussen

        self.status.configure(
            text=f"databank: recipe_search   |   {TOTAAL} gerechten in totaal   |   "
                 f"% = aandeel van alle gerechten"
        )


if __name__ == "__main__":
    venster = tk.Tk()
    app = StaafDiagram(venster)
    venster.mainloop()
