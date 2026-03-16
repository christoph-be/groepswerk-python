"""
Kookcompas - Dieetwensen CRUD Module
====================================
Teamlid 1: Database Developer

Verantwoordelijkheden:
- CRUD operaties voor dieetwensen
- Dieetwensen menu en interactie
- Toevoegen, bekijken, verwijderen van dieetwensen
"""

import os
import sys

# Voeg parent directory toe aan path voor imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from database.queries import (
    haal_alle_dieetwensen,
    voeg_dieet_toe,
    verwijder_dieet,
    haal_dieet_namen
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
from config import STANDAARD_DIEET


# ============================================
# READ - Lijst tonen
# ============================================

def toon_dieetwensen_lijst():
    """
    Toont alle opgeslagen dieetwensen.
    Returns: De lijst met dieetwensen (of lege lijst)
    """
    dieetwensen = haal_alle_dieetwensen()

    if dieetwensen is None:
        toon_foutmelding("Kon dieetwensen niet ophalen uit database.")
        return []

    if not dieetwensen:
        print("\n  Je hebt nog geen dieetwensen ingesteld.")
        print("  Voeg ze toe zodat de AI er rekening mee houdt.\n")
        return []

    print(f"\n  Jouw dieetwensen ({len(dieetwensen)}):\n")
    toon_lijn('-', 45)

    for dieet in dieetwensen:
        dieet_id = dieet.get('id', '?')
        naam = dieet.get('naam', 'onbekend')
        beschrijving = dieet.get('beschrijving', '')

        if beschrijving:
            print(f"  {dieet_id}. {naam} - {beschrijving}")
        else:
            print(f"  {dieet_id}. {naam}")

    toon_lijn('-', 45)
    return dieetwensen


# ============================================
# CREATE - Dieetwens toevoegen
# ============================================

def dieetwens_toevoegen():
    """
    Voegt een nieuwe dieetwens toe aan het profiel.
    Toont suggesties en accepteert ook eigen invoer.
    """
    print("\n--- Dieetwens Toevoegen ---\n")

    # Haal huidige dieetwensen op om duplicaten te voorkomen
    huidige = haal_dieet_namen()

    # Toon suggesties (alleen die nog niet zijn toegevoegd)
    beschikbare_suggesties = [
        s for s in STANDAARD_DIEET
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
            naam = vraag_tekst("  Naam van de dieetwens: ")
    else:
        print("  Alle standaard dieetwensen zijn al toegevoegd.")
        naam = vraag_tekst("  Naam van de dieetwens: ")

    # Check of dieetwens al bestaat
    naam_lower = naam.lower().strip()
    if naam_lower in huidige:
        toon_foutmelding(f"'{naam_lower}' staat al in je profiel.")
        return

    # Optionele beschrijving
    beschrijving = vraag_tekst("  Beschrijving (optioneel, Enter om over te slaan): ",
                               mag_leeg=True)

    # Toevoegen aan database
    resultaat = voeg_dieet_toe(naam_lower, beschrijving)

    if resultaat is not None:
        toon_succes(f"Dieetwens '{naam_lower}' toegevoegd aan je profiel.")
    else:
        toon_foutmelding(f"Kon '{naam_lower}' niet toevoegen. Mogelijk bestaat deze al.")


# ============================================
# DELETE - Dieetwens verwijderen
# ============================================

def dieetwens_verwijderen():
    """
    Verwijdert een dieetwens uit het profiel.
    """
    print("\n--- Dieetwens Verwijderen ---\n")

    dieetwensen = haal_alle_dieetwensen()

    if not dieetwensen:
        toon_info("Je hebt geen dieetwensen om te verwijderen.")
        return

    # Toon lijst
    print("  Huidige dieetwensen:\n")
    for dieet in dieetwensen:
        dieet_id = dieet.get('id', '?')
        naam = dieet.get('naam', 'onbekend')
        print(f"    {dieet_id}. {naam}")

    print(f"\n    0. Annuleren")

    # Vraag welke
    geldige_ids = [d['id'] for d in dieetwensen]
    keuze = vraag_getal("\n  Welk nummer verwijderen? ", 0, max(geldige_ids))

    if keuze == 0:
        print("  Geannuleerd.")
        return

    # Check of ID geldig is
    gekozen_dieet = None
    for dieet in dieetwensen:
        if dieet['id'] == keuze:
            gekozen_dieet = dieet
            break

    if gekozen_dieet is None:
        toon_foutmelding(f"Geen dieetwens gevonden met nummer {keuze}.")
        return

    naam = gekozen_dieet['naam']

    # Bevestiging
    if not bevestig_actie(f"Dieetwens '{naam}' verwijderen?"):
        print("  Geannuleerd.")
        return

    # Verwijderen
    resultaat = verwijder_dieet(keuze)

    if resultaat is not None:
        toon_succes(f"Dieetwens '{naam}' verwijderd uit je profiel.")
    else:
        toon_foutmelding(f"Kon dieetwens '{naam}' niet verwijderen.")


# ============================================
# MENU
# ============================================

def dieetwensen_menu():
    """
    Toont het dieetwensen sub-menu en verwerkt keuzes.
    """
    while True:
        maak_scherm_leeg()
        toon_titel("Mijn Dieetwensen")

        # Toon huidige dieetwensen
        toon_dieetwensen_lijst()

        # Menu opties
        print("\n  Opties:")
        print("    1. Dieetwens toevoegen")
        print("    2. Dieetwens verwijderen")
        print("    0. Terug naar hoofdmenu")

        keuze = vraag_getal("\n  Kies een optie: ", 0, 2)

        if keuze == 1:
            dieetwens_toevoegen()
            wacht_op_enter()
        elif keuze == 2:
            dieetwens_verwijderen()
            wacht_op_enter()
        elif keuze == 0:
            return
