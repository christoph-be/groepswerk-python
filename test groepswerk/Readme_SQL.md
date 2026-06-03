# Kookkompas

Een recepten-zoeker, gemaakt als groepswerk voor Python voor databanken. De kern is een MySQL-databank; Flask zet er een website bovenop en alle databankbewerkingen lopen via stored procedures.

## Wat de toepassing doet
- gerechten zoeken op een ingredient en het resultaat bekijken
- gerechten opslaan, bekijken, bewerken en verwijderen
- de allergenen van een gerecht tonen
- aanmelden als gebruiker, eigen allergenen bewaren, en daarna enkel de gerechten zonder die allergenen krijgen

## Onder de motorkap
- Python met Flask, en Jinja voor de pagina's
- MySQL via XAMPP, met stored procedures voor elke bewerking
- de databank recipe_search bevat 605 gerechten

## De databank
Acht tabellen, met koppeltabellen voor de veel-op-veel-relaties.
- meals en ingredients hangen samen via meal_ingredients: een gerecht telt meerdere ingredienten, en een ingredient duikt in meerdere gerechten op
- allergens hangt aan de gerechten vast via meal_allergens
- gebruikers krijgen hun allergenen via gebruiker_allergenen
- favorites staat klaar voor bewaarde gerechten per gebruiker

De stored procedures, geordend per onderwerp:
- gerechten: add_meal, update_meal, delete_meal, find_meals_by_ingredient
- ingredienten en allergenen: add_ingredient, link_meal_ingredient, link_ingredient_allergen, get_meal_allergens, find_meals_without_allergen
- gebruikers: gebruiker_aanmaken, gebruiker_aanmelden, gebruiker_allergeen_toevoegen, gebruiker_allergenen_ophalen, gerechten_voor_gebruiker

## Opzetten en starten
1. MySQL starten in XAMPP
2. de databank importeren: in phpMyAdmin Importeren kiezen en schema.sql selecteren. In een keer staan recipe_search, alle tabellen, de 605 gerechten en de procedures klaar
3. config.py nakijken: standaard root zonder wachtwoord, zoals een verse XAMPP. Staat er wel een wachtwoord op MySQL, dan hoort dat daar
4. de pakketten installeren met pip install -r requirements.txt
5. starten met python app.py en surfen naar http://127.0.0.1:8888

## Wat waar staat
- app.py: de routes en de logica per pagina
- config.py: de databankinstellingen
- schema.sql: de volledige databank, structuur en data en procedures samen
- services: db_service.py voor de databanktoegang, allergen_map.py voor het herkennen van allergenen
- templates: de Jinja-pagina's
- static/fotos: de foto's van de gerechten
