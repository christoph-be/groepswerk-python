GERECHTEN = [
    {
        "name": "Spaghetti Bolognese",
        "ingredients": ["gehakt", "tomaat", "ui", "wortel", "selder", "pasta"]
    },
    {
        "name": "Kip Curry",
        "ingredients": ["kip", "room", "currypoeder", "ui", "rijst"]
    },
    {
        "name": "Pannenkoeken",
        "ingredients": ["melk", "bloem", "ei", "boter"]
    },
    {
        "name": "Tomatensoep",
        "ingredients": ["tomaat", "ui", "bouillon", "wortel"]
    }
]


def show_menu():
    print("\n=== Gerechtenzoeker ===")
    print("1. Zoek gerecht op ingrediënt")
    print("2. Toon alle gerechten")
    print("3. Voeg een gerecht toe")
    print("4. Afsluiten")


def search_by_ingredient():
    term = input("Geef een ingrediënt in: ").lower()
    results = []

    for gerecht in GERECHTEN:
        if term in gerecht["ingredients"]:
            results.append(gerecht["name"])

    if results:
        print("\nGevonden gerechten:")
        for r in results:
            print(f"- {r}")
    else:
        print("Geen gerechten gevonden met dit ingrediënt.")


def list_gerechten():
    print("\n--- Alle Gerechten ---")
    for r in RECIPES:
        print(f"- {r['name']}")


def add_gerecht():
    name = input("Naam van het gerecht: ")
    ingredients = input("Ingrediënten (komma gescheiden): ")

    ingredient_list = [i.strip().lower() for i in ingredients.split(",")]

    GERECHTEN.append({
        "name": name,
        "ingredients": ingredient_list
    })

    print("✔ Gerecht toegevoegd!")


def main():
    while True:
        show_menu()
        keuze = input("Kies een optie: ")

        if keuze == "1":
            search_by_ingredient()
        elif keuze == "2":
            list_gerechten()
        elif keuze == "3":
            add_gerecht()
        elif keuze == "4":
            print("Programma afgesloten.")
            break
        else:
            print("Ongeldige keuze.")


if __name__ == "__main__":
    main()
