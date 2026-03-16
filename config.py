"""
Kookcompas - Configuratie Module
================================
Teamlid 3: CLI Developer

Verantwoordelijkheden:
- Applicatie configuratie
- Database instellingen
- AI instellingen
- Constanten en standaard waarden
"""

import os
from dotenv import load_dotenv

# === .env laden ===
load_dotenv()

# === DATABASE CONFIGURATIE ===
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''),
    'database': os.getenv('DB_DATABASE', 'kookcompas')
}

# === AI CONFIGURATIE ===
ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY', '')

# Claude 4.5 Haiku - snel en goedkoop
AI_MODEL = "claude-haiku-4-5-20251001"
AI_MAX_TOKENS = 1024

# === APP CONFIGURATIE ===
APP_NAAM = "Kookcompas"
VERSION = "1.0.0"

CATEGORIEEN = ['Ontbijt', 'Lunch', 'Diner', 'Snack', 'Dessert']

STANDAARD_ALLERGENEN = [
    'noten', 'gluten', 'lactose', 'ei',
    'schaaldieren', 'soja', 'selderij', 'mosterd'
]

STANDAARD_DIEET = [
    'vegetarisch', 'veganistisch', 'keto',
    'halal', 'glutenvrij', 'lactosevrij'
]
