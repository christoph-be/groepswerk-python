"""
Kookcompas - Helpers Module
===========================
Teamlid 3: CLI Developer

Verantwoordelijkheden:
- Helper functies voor de hele applicatie
- Input validatie functies
- Scherm en weergave functies
- Data formatting functies
"""

import os
from datetime import datetime


# ============================================
# SCHERM EN WEERGAVE
# ============================================

def maak_scherm_leeg():
    """
    Maakt het terminal scherm leeg.
    Werkt op Windows (cls) en Mac/Linux (clear).
    """
    os.system('cls' if os.name == 'nt' else 'clear')


def toon_lijn(karakter='=', breedte=45):
    """
    Print een horizontale lijn.

    Args:
        karakter: Het karakter voor de lijn (standaard '=')
        breedte: Breedte van de lijn (standaard 45)
    """
    print(karakter * breedte)


def toon_titel(tekst, karakter='=', breedte=45):
    """
    Toont een titel met lijnen erboven en eronder.

    Args:
        tekst: De titel tekst
        karakter: Karakter voor de lijnen
        breedte: Breedte van de lijnen
    """
    toon_lijn(karakter, breedte)
    print(f"  {tekst}")
    toon_lijn(karakter, breedte)


def toon_menu_opties(opties, titel=None):
    """
    Toont een genummerd menu.

    Args:
        opties: Dictionary met {nummer: beschrijving}
        titel: Optionele titel boven het menu

    Voorbeeld:
        toon_menu_opties({1: 'Optie A', 2: 'Optie B', 0: 'Terug'})
    """
    if titel:
        print(f"\n--- {titel} ---\n")

    for nummer, beschrijving in opties.items():
        print(f"  {nummer}. {beschrijving}")

    print()


def toon_lijst_genummerd(items, start=1):
    """
    Toont een genummerde lijst van items.

    Args:
        items: Lijst van strings
        start: Startnummer (standaard 1)
    """
    if not items:
        print("  (geen items)")
        return

    for i, item in enumerate(items, start=start):
        print(f"  {i}. {item}")


# ============================================
# GEBRUIKERS INPUT
# ============================================

def vraag_tekst(prompt, mag_leeg=False):
    """
    Vraagt tekstinvoer aan de gebruiker.

    Args:
        prompt: De vraag aan de gebruiker
        mag_leeg: Of lege invoer toegestaan is

    Returns:
        De ingevoerde tekst (gestript)
    """
    while True:
        invoer = input(prompt).strip()

        if invoer or mag_leeg:
            return invoer

        print("  Invoer mag niet leeg zijn. Probeer opnieuw.")


def vraag_getal(prompt, min_val=0, max_val=100):
    """
    Vraagt een getal binnen een bepaald bereik.

    Args:
        prompt: De vraag aan de gebruiker
        min_val: Minimale waarde
        max_val: Maximale waarde

    Returns:
        Het ingevoerde getal (int)
    """
    while True:
        invoer = input(prompt).strip()

        try:
            getal = int(invoer)
            if min_val <= getal <= max_val:
                return getal
            print(f"  Kies een getal tussen {min_val} en {max_val}.")
        except ValueError:
            print("  Voer een geldig getal in.")


def vraag_ja_nee(prompt):
    """
    Vraagt een ja/nee antwoord.

    Args:
        prompt: De vraag (bijv. "Opslaan? (ja/nee): ")

    Returns:
        True voor ja, False voor nee
    """
    while True:
        antwoord = input(prompt).strip().lower()

        if antwoord in ['ja', 'j', 'yes', 'y']:
            return True
        if antwoord in ['nee', 'n', 'no']:
            return False

        print("  Antwoord met ja of nee.")


def wacht_op_enter(bericht="\nDruk op Enter om door te gaan..."):
    """
    Wacht tot de gebruiker op Enter drukt.

    Args:
        bericht: Het bericht dat getoond wordt
    """
    input(bericht)


def bevestig_actie(beschrijving):
    """
    Vraagt bevestiging voor een actie.

    Args:
        beschrijving: Wat er gaat gebeuren

    Returns:
        True als bevestigd, False als geannuleerd
    """
    print(f"\n  {beschrijving}")
    return vraag_ja_nee("  Weet je het zeker? (ja/nee): ")


# ============================================
# DATA VERWERKING
# ============================================

def formatteer_datum(datum):
    """
    Formatteert een datetime object naar een leesbare string.

    Args:
        datum: datetime object

    Returns:
        Geformatteerde string (bijv. "14 jan 2025, 15:30")
    """
    if datum is None:
        return "Onbekend"

    maanden = [
        'jan', 'feb', 'mrt', 'apr', 'mei', 'jun',
        'jul', 'aug', 'sep', 'okt', 'nov', 'dec'
    ]

    try:
        maand = maanden[datum.month - 1]
        return f"{datum.day} {maand} {datum.year}, {datum.hour:02d}:{datum.minute:02d}"
    except (AttributeError, IndexError):
        return str(datum)


def splits_ingredienten(tekst):
    """
    Splitst een komma-gescheiden tekst naar een nette lijst.

    Args:
        tekst: Komma-gescheiden string (bijv. "pasta, tomaat, ui")

    Returns:
        Lijst van gestripte, niet-lege strings
    """
    if not tekst:
        return []

    items = tekst.split(',')
    return [item.strip() for item in items if item.strip()]


def maak_ingredienten_tekst(ingredienten_lijst):
    """
    Maakt een bullet point tekst van een ingredienten lijst.

    Args:
        ingredienten_lijst: Lijst van ingredienten

    Returns:
        String met bullet points (bijv. "- pasta\n- tomaat")
    """
    if not ingredienten_lijst:
        return ""

    return '\n'.join(f"- {item}" for item in ingredienten_lijst)


# ============================================
# BERICHTEN
# ============================================

def toon_foutmelding(bericht):
    """
    Toont een foutmelding.

    Args:
        bericht: De foutmelding
    """
    print(f"\n  [FOUT] {bericht}")


def toon_succes(bericht):
    """
    Toont een succesbericht.

    Args:
        bericht: Het succesbericht
    """
    print(f"\n  [OK] {bericht}")


def toon_info(bericht):
    """
    Toont een informatief bericht.

    Args:
        bericht: Het bericht
    """
    print(f"\n  [INFO] {bericht}")


def toon_waarschuwing(bericht):
    """
    Toont een waarschuwing.

    Args:
        bericht: De waarschuwing
    """
    print(f"\n  [LET OP] {bericht}")
