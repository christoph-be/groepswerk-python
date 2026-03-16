"""
Kookcompas - Hoofdapplicatie
============================
Teamlid 3: CLI Developer

Verantwoordelijkheden:
- Hoofdmenu en applicatie flow
- Welkomstscherm en profiel weergave
- Recept generatie flow
- Integratie van alle modules
"""

import os
import sys
import subprocess

# Voeg project root toe aan path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def start_ollama_als_nodig():
    """Start Ollama server automatisch als die niet draait."""
    import urllib.request
    try:
        urllib.request.urlopen('http://localhost:11434', timeout=3)
    except Exception:
        try:
            subprocess.Popen(
                ['ollama', 'serve'],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == 'win32' else 0
            )
            import time
            time.sleep(3)
        except FileNotFoundError:
            pass


start_ollama_als_nodig()

from config import APP_NAAM, VERSION
from database.db_connection import maak_connectie, sluit_connectie
from database.queries import sla_recept_op
from crud.allergenen import allergenen_menu, haal_allergie_namen
from crud.dieetwensen import dieetwensen_menu, haal_dieet_namen
from crud.recepten import recepten_menu
from utils.helpers import (
    maak_scherm_leeg,
    toon_lijn,
    toon_titel,
    vraag_tekst,
    vraag_getal,
    vraag_ja_nee,
    wacht_op_enter,
    splits_ingredienten,
    toon_succes,
    toon_foutmelding,
    toon_info,
    toon_waarschuwing
)

# AI import - kan falen als API niet geconfigureerd
try:
    from ai.recepten_ai import (
        genereer_recept,
        genereer_boodschappenlijst,
        check_ollama_status,
        formatteer_recept
    )
    AI_BESCHIKBAAR = True
except ImportError:
    AI_BESCHIKBAAR = False


# ============================================
# WELKOM EN PROFIEL
# ============================================

def toon_welkomstscherm():
    """
    Toont het welkomstscherm bij het opstarten.
    """
    maak_scherm_leeg()
    toon_lijn('=', 45)
    print(f"  Welkom bij {APP_NAAM} v{VERSION}")
    toon_lijn('=', 45)
    print()
    print("  Slimme recepten generator met AI")
    print("  Houdt rekening met allergenen en dieetwensen")
    print()
    wacht_op_enter("  Druk op Enter om te beginnen...")


def toon_profiel():
    """
    Toont het gebruikersprofiel (allergenen en dieetwensen).
    """
    allergenen = haal_allergie_namen()
    dieetwensen = haal_dieet_namen()

    allergie_tekst = ', '.join(allergenen) if allergenen else 'geen ingesteld'
    dieet_tekst = ', '.join(dieetwensen) if dieetwensen else 'geen ingesteld'

    print("\n  Jouw profiel:")
    print(f"  - Allergenen: {allergie_tekst}")
    print(f"  - Dieet:      {dieet_tekst}")


def toon_header():
    """
    Toont de app header met profiel.
    """
    toon_lijn('=', 45)
    print(f"  {APP_NAAM} v{VERSION}")
    toon_lijn('=', 45)
    toon_profiel()


# ============================================
# RECEPT GENERATIE FLOW
# ============================================

def recept_genereren_flow():
    """
    Complete flow voor het genereren van een recept:
    1. Toon profiel
    2. Vraag ingredienten
    3. Genereer met AI
    4. Toon recept
    5. Opslaan vraag
    6. Boodschappenlijst vraag
    """
    maak_scherm_leeg()
    toon_titel("Recept Genereren")

    # Check of AI beschikbaar is
    if not AI_BESCHIKBAAR:
        toon_foutmelding("AI module kon niet geladen worden.")
        toon_info("Zorg dat Ollama draait op de achtergrond.")
        wacht_op_enter()
        return

    if not check_ollama_status():
        toon_foutmelding("AI is niet geconfigureerd.")
        toon_info("Controleer of Ollama draait en het model beschikbaar is.")
        wacht_op_enter()
        return

    # Toon huidig profiel
    toon_profiel()

    # Vraag ingredienten
    print("\n  Welke ingredienten heb je?")
    print("  (gescheiden door komma, bijv: pasta, tomaat, ui)\n")

    ingredienten_tekst = vraag_tekst("  Ingredienten: ")
    ingredienten_lijst = splits_ingredienten(ingredienten_tekst)

    if not ingredienten_lijst:
        toon_foutmelding("Voer minimaal 1 ingredient in.")
        wacht_op_enter()
        return

    # Bevestig ingredienten
    print(f"\n  Je ingredienten: {', '.join(ingredienten_lijst)}")

    # Haal profiel op
    allergenen_lijst = haal_allergie_namen()
    dieet_lijst = haal_dieet_namen()

    # Genereer recept
    print("\n  Even denken...\n")

    recept = genereer_recept(
        ingredienten_lijst=ingredienten_lijst,
        allergenen_lijst=allergenen_lijst,
        dieet_lijst=dieet_lijst
    )

    if recept is None:
        toon_foutmelding("Kon geen recept genereren. Probeer opnieuw.")
        wacht_op_enter()
        return

    # Toon het recept
    maak_scherm_leeg()
    recept_tekst = formatteer_recept(recept)
    print(recept_tekst)

    # Opslaan vraag
    print()
    if vraag_ja_nee("  Wil je dit recept opslaan? (ja/nee): "):
        opslaan_resultaat = sla_recept_op(
            titel=recept.get('titel', 'Onbekend recept'),
            categorie=recept.get('categorie', 'Diner'),
            ingredienten=recept.get('ingredienten', ''),
            instructies=recept.get('instructies', ''),
            bereidingstijd=recept.get('bereidingstijd', 30),
            personen=recept.get('personen', 2)
        )

        if opslaan_resultaat is not None:
            toon_succes("Recept opgeslagen als favoriet!")
        else:
            toon_foutmelding("Kon recept niet opslaan in database.")

    # Boodschappenlijst vraag
    if vraag_ja_nee("\n  Boodschappenlijst maken? (ja/nee): "):
        toon_boodschappenlijst(recept)

    wacht_op_enter()


def toon_boodschappenlijst(recept):
    """
    Genereert en toont een boodschappenlijst voor een recept.

    Args:
        recept: Recept dictionary
    """
    print("\n  Boodschappenlijst wordt gemaakt...\n")

    boodschappen = genereer_boodschappenlijst(recept)

    if boodschappen:
        toon_lijn('-', 40)
        print("  BOODSCHAPPENLIJST")
        toon_lijn('-', 40)
        print(boodschappen)
        toon_lijn('-', 40)
    else:
        # Fallback: toon ingredienten als boodschappen
        toon_lijn('-', 40)
        print("  BOODSCHAPPENLIJST")
        toon_lijn('-', 40)

        ingredienten = recept.get('ingredienten', '')
        for regel in ingredienten.split('\n'):
            regel = regel.strip()
            if regel.startswith('-'):
                regel = regel[1:].strip()
            if regel:
                print(f"  [ ] {regel}")

        toon_lijn('-', 40)


# ============================================
# HOOFDMENU
# ============================================

def toon_hoofdmenu():
    """
    Toont het hoofdmenu.
    """
    print("\n  Hoofdmenu:")
    print("    1. Recept genereren")
    print("    2. Mijn allergenen")
    print("    3. Mijn dieetwensen")
    print("    4. Opgeslagen recepten")
    print("    0. Afsluiten")


def verwerk_keuze(keuze):
    """
    Verwerkt de menukeuze van de gebruiker.

    Args:
        keuze: Gekozen optie (0-4)

    Returns:
        True om door te gaan, False om af te sluiten
    """
    if keuze == 1:
        recept_genereren_flow()
    elif keuze == 2:
        allergenen_menu()
    elif keuze == 3:
        dieetwensen_menu()
    elif keuze == 4:
        recepten_menu()
    elif keuze == 0:
        return False

    return True


# ============================================
# MAIN
# ============================================

def main():
    """
    Hoofdfunctie - start de applicatie.
    """
    # Database connectie testen
    if not maak_connectie():
        print("\n  Kon geen verbinding maken met de database.")
        print("  Check je .env instellingen en of MySQL draait.")
        print()
        return

    # Welkomstscherm
    toon_welkomstscherm()

    # Hoofdmenu loop
    actief = True
    while actief:
        maak_scherm_leeg()
        toon_header()
        toon_hoofdmenu()

        keuze = vraag_getal("\n  Kies een optie: ", 0, 4)
        actief = verwerk_keuze(keuze)

    # Netjes afsluiten
    maak_scherm_leeg()
    print()
    toon_lijn('=', 45)
    print(f"  Bedankt voor het gebruiken van {APP_NAAM}!")
    print("  Tot de volgende keer!")
    toon_lijn('=', 45)
    print()

    sluit_connectie()


if __name__ == "__main__":
    main()
