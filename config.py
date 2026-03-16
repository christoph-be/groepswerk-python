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

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

# === DATABASE CONFIGURATIE ===
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''),
    'database': os.getenv('DB_DATABASE', 'kookcompas')
}

# === AI CONFIGURATIE (Ollama - lokaal) ===
OLLAMA_URL = os.getenv('OLLAMA_URL', 'http://localhost:11434')
AI_MODEL = os.getenv('AI_MODEL', 'qwen2.5-coder:7b')
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
