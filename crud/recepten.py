"""
Kookcompas - Recepten CRUD Module
=================================
Teamlid 3: CLI Developer

Verantwoordelijkheden:
- CRUD operaties voor recepten
- Recepten menu en navigatie
- Zoeken en filteren van recepten
- Recept weergave en details
"""

import os
import sys

# Voeg parent directory toe aan path voor imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from database.queries import (
    haal_alle_recepten,
    haal_recept_detail,
    verwijder_recept,
    update_recept_notities,
    zoek_recepten,
    filter_op_categorie,
    tel_recepten
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
    toon_info,
    formatteer_datum
)
from config import CATEGORIEEN


# ============================================
# READ - Overzicht
# ============================================

def toon_recepten_overzicht():
    """
    Toont een overzicht van alle opgeslagen recepten.
    Returns: De lijst met recepten (of lege lijst)
    """
    recepten = haal_alle_recepten()

    if recepten is None:
        toon_foutmelding("Kon recepten niet ophalen uit database.")
        return []

    if not recepten:
        print("\n  Je hebt nog geen recepten opgeslagen.")
        print("  Genereer een recept via het hoofdmenu (optie 1).\n")
        return []

    print(f"\n  Opgeslagen recepten ({len(recepten)}):\n")

    # Tabel header
    print(f"  {'ID':<5}{'Titel':<30}{'Categorie':<12}{'Tijd':<10}")
    toon_lijn('-', 57)

    for recept in recepten:
        recept_id = recept.get('id', '?')
        titel = recept.get('titel', 'Onbekend')
        categorie = recept.get('categorie', '-')
        tijd = recept.get('bereidingstijd', '?')

        # Titel inkorten als te lang
        if len(titel) > 28:
            titel = titel[:25] + '...'

        tijd_tekst = f"{tijd} min" if tijd else "?"

        print(f"  {recept_id:<5}{titel:<30}{categorie:<12}{tijd_tekst:<10}")

    toon_lijn('-', 57)
    return recepten


# ============================================
# READ - Detail
# ============================================

def toon_recept_volledig(recept_id):
    """
    Toont een volledig recept met alle details.

    Args:
        recept_id: ID van het recept

    Returns:
        Het recept dictionary of None
    """
    recept = haal_recept_detail(recept_id)

    if recept is None:
        toon_foutmelding(f"Recept met ID {recept_id} niet gevonden.")
        return None

    # Header
    toon_lijn('=', 45)
    print(f"  {recept.get('titel', 'Onbekend').upper()}")
    toon_lijn('=', 45)

    # Meta info
    print(f"  Categorie:      {recept.get('categorie', '-')}")
    print(f"  Bereidingstijd: {recept.get('bereidingstijd', '?')} minuten")
    print(f"  Personen:       {recept.get('personen', '?')}")

    datum = recept.get('opgeslagen_op')
    if datum:
        print(f"  Opgeslagen:     {formatteer_datum(datum)}")

    # Ingredienten
    ingredienten = recept.get('ingredienten', '')
    if ingredienten:
        print(f"\n  INGREDIENTEN:")
        toon_lijn('-', 45)
        for regel in ingredienten.split('\n'):
            regel = regel.strip()
            if regel:
                print(f"  {regel}")

    # Bereiding
    instructies = recept.get('instructies', '')
    if instructies:
        print(f"\n  BEREIDING:")
        toon_lijn('-', 45)
        for regel in instructies.split('\n'):
            regel = regel.strip()
            if regel:
                print(f"  {regel}")

    # Notities
    notities = recept.get('notities', '')
    if notities:
        print(f"\n  NOTITIES:")
        toon_lijn('-', 45)
        print(f"  {notities}")

    toon_lijn('=', 45)
    return recept


def bekijk_recept_detail():
    """
    Vraagt een recept ID en toont het volledige recept.
    Biedt daarna opties: notities bewerken, verwijderen, terug.
    """
    recept_id = vraag_getal("\n  Recept ID om te bekijken (0 = terug): ", 0, 9999)

    if recept_id == 0:
        return

    recept = toon_recept_volledig(recept_id)

    if recept is None:
        wacht_op_enter()
        return

    # Acties na bekijken
    print("\n  Opties:")
    print("    1. Notities bewerken")
    print("    2. Recept verwijderen")
    print("    0. Terug")

    keuze = vraag_getal("\n  Kies een optie: ", 0, 2)

    if keuze == 1:
        bewerk_notities(recept_id)
    elif keuze == 2:
        verwijder_recept_actie(recept_id, recept.get('titel', 'Onbekend'))


# ============================================
# UPDATE - Notities bewerken
# ============================================

def bewerk_notities(recept_id):
    """
    Bewerkt de notities van een recept.

    Args:
        recept_id: ID van het recept
    """
    print("\n--- Notities Bewerken ---\n")

    recept = haal_recept_detail(recept_id)
    if recept is None:
        toon_foutmelding("Recept niet gevonden.")
        return

    huidige_notities = recept.get('notities', '')
    if huidige_notities:
        print(f"  Huidige notities: {huidige_notities}")
    else:
        print("  Nog geen notities.")

    nieuwe_notities = vraag_tekst("\n  Nieuwe notities (of Enter voor leeg): ",
                                  mag_leeg=True)

    resultaat = update_recept_notities(recept_id, nieuwe_notities)

    if resultaat is not None:
        toon_succes("Notities bijgewerkt.")
    else:
        toon_foutmelding("Kon notities niet bijwerken.")


# ============================================
# DELETE - Recept verwijderen
# ============================================

def verwijder_recept_actie(recept_id=None, titel=None):
    """
    Verwijdert een recept na bevestiging.

    Args:
        recept_id: ID van het recept (optioneel, wordt gevraagd)
        titel: Titel voor bevestiging
    """
    if recept_id is None:
        recept_id = vraag_getal("\n  Recept ID om te verwijderen (0 = annuleren): ",
                                0, 9999)
        if recept_id == 0:
            print("  Geannuleerd.")
            return

    if titel is None:
        recept = haal_recept_detail(recept_id)
        if recept:
            titel = recept.get('titel', 'Onbekend')
        else:
            toon_foutmelding(f"Recept met ID {recept_id} niet gevonden.")
            return

    # Bevestiging
    if not bevestig_actie(f"Recept '{titel}' verwijderen?"):
        print("  Geannuleerd.")
        return

    resultaat = verwijder_recept(recept_id)

    if resultaat is not None:
        toon_succes(f"Recept '{titel}' verwijderd.")
    else:
        toon_foutmelding(f"Kon recept '{titel}' niet verwijderen.")


# ============================================
# SEARCH - Zoeken
# ============================================

def zoek_in_recepten():
    """
    Zoekt recepten op titel of ingredienten.
    """
    print("\n--- Recept Zoeken ---\n")

    zoekterm = vraag_tekst("  Zoekterm: ")
    resultaten = zoek_recepten(zoekterm)

    if resultaten is None:
        toon_foutmelding("Zoeken mislukt.")
        return

    if not resultaten:
        toon_info(f"Geen recepten gevonden met '{zoekterm}'.")
        return

    print(f"\n  Gevonden recepten ({len(resultaten)}):\n")
    toon_lijn('-', 50)

    for recept in resultaten:
        recept_id = recept.get('id', '?')
        titel = recept.get('titel', 'Onbekend')
        categorie = recept.get('categorie', '-')
        tijd = recept.get('bereidingstijd', '?')

        print(f"  {recept_id}. {titel}")
        print(f"     Categorie: {categorie} | Tijd: {tijd} min")
        toon_lijn('-', 50)

    print(f"\n  {len(resultaten)} recept(en) gevonden.")

    # Optie om detail te bekijken
    if vraag_ja_nee("\n  Wil je een recept bekijken? (ja/nee): "):
        recept_id = vraag_getal("  Welk ID? ", 1, 9999)
        toon_recept_volledig(recept_id)


# ============================================
# FILTER - Op categorie
# ============================================

def filter_recepten():
    """
    Filtert recepten op categorie.
    """
    print("\n--- Filter op Categorie ---\n")

    # Toon beschikbare categorieën
    for i, cat in enumerate(CATEGORIEEN, 1):
        print(f"    {i}. {cat}")
    print(f"    0. Annuleren")

    keuze = vraag_getal("\n  Kies een categorie: ", 0, len(CATEGORIEEN))

    if keuze == 0:
        return

    gekozen_categorie = CATEGORIEEN[keuze - 1]
    resultaten = filter_op_categorie(gekozen_categorie)

    if resultaten is None:
        toon_foutmelding("Filteren mislukt.")
        return

    if not resultaten:
        toon_info(f"Geen recepten in categorie '{gekozen_categorie}'.")
        return

    print(f"\n  Recepten in '{gekozen_categorie}' ({len(resultaten)}):\n")
    toon_lijn('-', 50)

    for recept in resultaten:
        recept_id = recept.get('id', '?')
        titel = recept.get('titel', 'Onbekend')
        tijd = recept.get('bereidingstijd', '?')

        print(f"  {recept_id}. {titel} ({tijd} min)")

    toon_lijn('-', 50)


# ============================================
# MENU
# ============================================

def recepten_menu():
    """
    Toont het recepten sub-menu en verwerkt keuzes.
    """
    while True:
        maak_scherm_leeg()
        toon_titel("Opgeslagen Recepten")

        # Toon overzicht
        recepten = toon_recepten_overzicht()

        # Menu opties
        print("\n  Opties:")
        print("    1. Recept details bekijken")
        print("    2. Recept zoeken")
        print("    3. Filter op categorie")
        print("    4. Recept verwijderen")
        print("    0. Terug naar hoofdmenu")

        keuze = vraag_getal("\n  Kies een optie: ", 0, 4)

        if keuze == 1:
            bekijk_recept_detail()
            wacht_op_enter()
        elif keuze == 2:
            zoek_in_recepten()
            wacht_op_enter()
        elif keuze == 3:
            filter_recepten()
            wacht_op_enter()
        elif keuze == 4:
            verwijder_recept_actie()
            wacht_op_enter()
        elif keuze == 0:
            return
