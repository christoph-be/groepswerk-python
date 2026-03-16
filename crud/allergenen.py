"""
Kookcompas - Allergenen CRUD Module
===================================
Teamlid 1: Database Developer

Verantwoordelijkheden:
- CRUD operaties voor allergenen
- Allergenen menu en interactie
- Toevoegen, bekijken, verwijderen van allergenen
"""

import os
import sys

# Voeg parent directory toe aan path voor imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from database.queries import (
    haal_alle_allergenen,
    voeg_allergie_toe,
    verwijder_allergie,
    haal_allergie_namen
)
from utils.helpers import (
    maak_scherm_leeg,
    toon_lijn,
    toon_titel,
    vraag_tekst,
    vraag_getal,
    vraag_ja_nee,
    wacht_op_enter,
    bevestig_actie,
    toon_succes,
    toon_foutmelding,
    toon_info
)
from config import STANDAARD_ALLERGENEN


# ============================================
# READ - Lijst tonen
# ============================================

def toon_allergenen_lijst():
    """
    Toont alle opgeslagen allergenen.
    Returns: De lijst met allergenen (of lege lijst)
    """
    allergenen = haal_alle_allergenen()

    if allergenen is None:
        toon_foutmelding("Kon allergenen niet ophalen uit database.")
        return []

    if not allergenen:
        print("\n  Je hebt nog geen allergenen ingesteld.")
        print("  Voeg ze toe zodat de AI er rekening mee houdt.\n")
        return []

    print(f"\n  Jouw allergenen ({len(allergenen)}):\n")
    toon_lijn('-', 45)

    for allergie in allergenen:
        allergie_id = allergie.get('id', '?')
        naam = allergie.get('naam', 'onbekend')
        beschrijving = allergie.get('beschrijving', '')

        if beschrijving:
            print(f"  {allergie_id}. {naam} - {beschrijving}")
        else:
            print(f"  {allergie_id}. {naam}")

    toon_lijn('-', 45)
    return allergenen


# ============================================
# CREATE - Allergie toevoegen
# ============================================

def allergie_toevoegen():
    """
    Voegt een nieuwe allergie toe aan het profiel.
    Toont suggesties en accepteert ook eigen invoer.
    """
    print("\n--- Allergie Toevoegen ---\n")

    # Haal huidige allergenen op om duplicaten te voorkomen
    huidige = haal_allergie_namen()

    # Toon suggesties (alleen die nog niet zijn toegevoegd)
    beschikbare_suggesties = [
        s for s in STANDAARD_ALLERGENEN
        if s not in huidige
    ]

    if beschikbare_suggesties:
        print("  Suggesties:")
        for i, suggestie in enumerate(beschikbare_suggesties, 1):
            print(f"    {i}. {suggestie}")
        print(f"    0. Eigen invoer")
        print()

        keuze = vraag_getal("  Kies een nummer (of 0 voor eigen invoer): ",
                            0, len(beschikbare_suggesties))

        if keuze > 0:
            naam = beschikbare_suggesties[keuze - 1]
        else:
            naam = vraag_tekst("  Naam van de allergie: ")
    else:
        print("  Alle standaard allergenen zijn al toegevoegd.")
        naam = vraag_tekst("  Naam van de allergie: ")

    # Check of allergie al bestaat
    naam_lower = naam.lower().strip()
    if naam_lower in huidige:
        toon_foutmelding(f"'{naam_lower}' staat al in je profiel.")
        return

    # Optionele beschrijving
    beschrijving = vraag_tekst("  Beschrijving (optioneel, Enter om over te slaan): ",
                               mag_leeg=True)

    # Toevoegen aan database
    resultaat = voeg_allergie_toe(naam_lower, beschrijving)

    if resultaat is not None:
        toon_succes(f"Allergie '{naam_lower}' toegevoegd aan je profiel.")
    else:
        toon_foutmelding(f"Kon '{naam_lower}' niet toevoegen. Mogelijk bestaat deze al.")


# ============================================
# DELETE - Allergie verwijderen
# ============================================

def allergie_verwijderen():
    """
    Verwijdert een allergie uit het profiel.
    Toont eerst de lijst en vraagt dan welke te verwijderen.
    """
    print("\n--- Allergie Verwijderen ---\n")

    allergenen = haal_alle_allergenen()

    if not allergenen:
        toon_info("Je hebt geen allergenen om te verwijderen.")
        return

    # Toon lijst
    print("  Huidige allergenen:\n")
    for allergie in allergenen:
        allergie_id = allergie.get('id', '?')
        naam = allergie.get('naam', 'onbekend')
        print(f"    {allergie_id}. {naam}")

    print(f"\n    0. Annuleren")

    # Vraag welke
    geldige_ids = [a['id'] for a in allergenen]
    keuze = vraag_getal("\n  Welk nummer verwijderen? ", 0, max(geldige_ids))

    if keuze == 0:
        print("  Geannuleerd.")
        return

    # Check of ID geldig is
    gekozen_allergie = None
    for allergie in allergenen:
        if allergie['id'] == keuze:
            gekozen_allergie = allergie
            break

    if gekozen_allergie is None:
        toon_foutmelding(f"Geen allergie gevonden met nummer {keuze}.")
        return

    naam = gekozen_allergie['naam']

    # Bevestiging
    if not bevestig_actie(f"Allergie '{naam}' verwijderen?"):
        print("  Geannuleerd.")
        return

    # Verwijderen
    resultaat = verwijder_allergie(keuze)

    if resultaat is not None:
        toon_succes(f"Allergie '{naam}' verwijderd uit je profiel.")
    else:
        toon_foutmelding(f"Kon allergie '{naam}' niet verwijderen.")


# ============================================
# MENU
# ============================================

def allergenen_menu():
    """
    Toont het allergenen sub-menu en verwerkt keuzes.
    Draait in een loop tot de gebruiker 'terug' kiest.
    """
    while True:
        maak_scherm_leeg()
        toon_titel("Mijn Allergenen")

        # Toon huidige allergenen
        toon_allergenen_lijst()

        # Menu opties
        print("\n  Opties:")
        print("    1. Allergie toevoegen")
        print("    2. Allergie verwijderen")
        print("    0. Terug naar hoofdmenu")

        keuze = vraag_getal("\n  Kies een optie: ", 0, 2)

        if keuze == 1:
            allergie_toevoegen()
            wacht_op_enter()
        elif keuze == 2:
            allergie_verwijderen()
            wacht_op_enter()
        elif keuze == 0:
            return
