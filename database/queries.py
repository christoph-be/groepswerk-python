"""
Kookcompas - Database Queries Module
====================================
Teamlid 1: Database Developer

Verantwoordelijkheden:
- Query functies voor allergenen
- Query functies voor dieetwensen
- Query functies voor recepten
- Wrapper functies voor stored procedures
"""

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from database.db_connection import maak_connectie, sluit_connectie
from mysql.connector import Error


def voer_procedure_uit(naam, parameters=()):
    """
    Voert een stored procedure uit en geeft resultaten terug.

    Args:
        naam: naam van de stored procedure
        parameters: tuple met parameters

    Returns:
        lijst met dictionaries of None bij fout
    """
    conn = maak_connectie()
    if not conn:
        return None

    try:
        cursor = conn.cursor(dictionary=True)
        cursor.callproc(naam, parameters)

        resultaten = []
        for result in cursor.stored_results():
            resultaten.extend(result.fetchall())

        cursor.close()
        conn.commit()
        return resultaten

    except Error as fout:
        print(f"Database fout bij {naam}: {fout}")
        return None


# ============================================================
#  ALLERGENEN QUERIES
# ============================================================

def haal_alle_allergenen():
    """Haalt alle allergenen op. Returns: lijst met dicts of lege lijst"""
    resultaat = voer_procedure_uit('sp_haal_allergenen_op')
    return resultaat if resultaat else []


def voeg_allergie_toe(naam, beschrijving=''):
    """
    Voegt een allergie toe.
    Returns: dict met id of None bij fout (bijv. duplicate)
    """
    try:
        resultaat = voer_procedure_uit('sp_voeg_allergie_toe', (naam, beschrijving))
        return resultaat[0] if resultaat else None
    except Exception as fout:
        print(f"Kon allergie niet toevoegen: {fout}")
        return None


def verwijder_allergie(allergie_id):
    """Verwijdert een allergie op ID. Returns: True als gelukt"""
    resultaat = voer_procedure_uit('sp_verwijder_allergie', (allergie_id,))
    if resultaat and resultaat[0].get('verwijderd', 0) > 0:
        return True
    return False


def haal_allergie_namen():
    """
    Haalt alleen de namen van allergenen op (voor AI module).
    Returns: lijst met strings ["noten", "lactose", ...]
    """
    allergenen = haal_alle_allergenen()
    return [a['naam'] for a in allergenen] if allergenen else []


# ============================================================
#  DIEETWENSEN QUERIES
# ============================================================

def haal_alle_dieetwensen():
    """Haalt alle dieetwensen op. Returns: lijst met dicts of lege lijst"""
    resultaat = voer_procedure_uit('sp_haal_dieet_op')
    return resultaat if resultaat else []


def voeg_dieet_toe(naam, beschrijving=''):
    """Voegt een dieetwens toe. Returns: dict met id of None"""
    try:
        resultaat = voer_procedure_uit('sp_voeg_dieet_toe', (naam, beschrijving))
        return resultaat[0] if resultaat else None
    except Exception as fout:
        print(f"Kon dieetwens niet toevoegen: {fout}")
        return None


def verwijder_dieet(dieet_id):
    """Verwijdert een dieetwens op ID. Returns: True als gelukt"""
    resultaat = voer_procedure_uit('sp_verwijder_dieet', (dieet_id,))
    if resultaat and resultaat[0].get('verwijderd', 0) > 0:
        return True
    return False


def haal_dieet_namen():
    """
    Haalt alleen de namen van dieetwensen op (voor AI module).
    Returns: lijst met strings ["vegetarisch", "halal", ...]
    """
    dieet = haal_alle_dieetwensen()
    return [d['naam'] for d in dieet] if dieet else []


# ============================================================
#  RECEPTEN QUERIES
# ============================================================

def sla_recept_op(titel, categorie, ingredienten, instructies, bereidingstijd=30, personen=2):
    """
    Slaat een recept op in de database.
    Returns: dict met id of None bij fout
    """
    try:
        resultaat = voer_procedure_uit('sp_voeg_recept_toe', (
            titel, categorie, ingredienten, instructies, bereidingstijd, personen
        ))
        return resultaat[0] if resultaat else None
    except Exception as fout:
        print(f"Kon recept niet opslaan: {fout}")
        return None


def haal_alle_recepten():
    """Haalt alle recepten op (overzicht). Returns: lijst met dicts"""
    resultaat = voer_procedure_uit('sp_haal_recepten_op')
    return resultaat if resultaat else []


def haal_recept_detail(recept_id):
    """Haalt een recept op met alle details. Returns: dict of None"""
    resultaat = voer_procedure_uit('sp_haal_recept_detail', (recept_id,))
    return resultaat[0] if resultaat else None


def verwijder_recept(recept_id):
    """Verwijdert een recept op ID. Returns: True als gelukt"""
    resultaat = voer_procedure_uit('sp_verwijder_recept', (recept_id,))
    if resultaat and resultaat[0].get('verwijderd', 0) > 0:
        return True
    return False


def update_recept_notities(recept_id, notities):
    """Wijzigt de notities van een recept. Returns: True als gelukt"""
    resultaat = voer_procedure_uit('sp_update_notities', (recept_id, notities))
    if resultaat and resultaat[0].get('bijgewerkt', 0) > 0:
        return True
    return False


def zoek_recepten(zoekterm):
    """Zoekt recepten op titel of ingredienten. Returns: lijst met dicts"""
    resultaat = voer_procedure_uit('sp_zoek_recepten', (zoekterm,))
    return resultaat if resultaat else []


def filter_op_categorie(categorie):
    """Filtert recepten op categorie. Returns: lijst met dicts"""
    resultaat = voer_procedure_uit('sp_filter_categorie', (categorie,))
    return resultaat if resultaat else []


def tel_recepten():
    """Telt het totaal aantal recepten. Returns: int"""
    resultaat = voer_procedure_uit('sp_tel_recepten')
    if resultaat:
        return resultaat[0].get('aantal', 0)
    return 0
