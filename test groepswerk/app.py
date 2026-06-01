from flask import Flask, render_template, request, redirect, url_for, flash
from config import Config
from services import mealdb_api
from services import db_service
from mysql.connector import Error
from services.allergen_map import ALLERGEN_MAP



app = Flask(__name__)
app.config.from_object(Config)



def validate_ingredient_input(ingredient: str):
    ingredient = ingredient.strip()
    if not ingredient:
        return False, "Ingrediënt mag niet leeg zijn."
    if any(char.isdigit() for char in ingredient):
        return False, "Ingrediënt mag geen cijfers bevatten."
    return True, ingredient


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/search", methods=["POST"])
def search():
    ingredient = request.form.get("ingredient", "")
    is_valid, result = validate_ingredient_input(ingredient)
    if not is_valid:
        flash(result, "error")
        return redirect(url_for("index"))

    ingredient = result
    try:
        meals = mealdb_api.search_meals_by_ingredient(ingredient)
        return render_template("search_results.html", meals=meals, ingredient=ingredient)
    except Exception as e:
        print(e)
        return render_template(
            "error.html",
            message="Er ging iets mis bij het opvragen van de API-resultaten.",
        )




@app.route("/meal/<int:meal_id>")
def meal_detail(meal_id):
    try:
        local_meal = db_service.fetch_meal_by_id(meal_id)
    except Error:
        local_meal = None

    api_meal = None
    ingredients = []
    try:
        api_meal = mealdb_api.get_meal_detail(meal_id)
        if api_meal:
            ingredients = mealdb_api.extract_ingredients_from_meal(api_meal)
    except Exception as e:
        print(e)

    # Allergenen ophalen
    try:
        allergens = db_service.call_procedure("get_meal_allergens", (meal_id,))
    except:
        allergens = []

    return render_template(
        "meal_detail.html",
        meal_id=meal_id,
        local_meal=local_meal,
        api_meal=api_meal,
        ingredients=ingredients,
        allergens=allergens
    )



@app.route("/meals")
def meals_list():
    try:
        meals = db_service.fetch_all_meals()
        return render_template("meals_list.html", meals=meals)
    except Error:
        return render_template(
            "error.html",
            message="Kon de lijst met opgeslagen gerechten niet ophalen.",
        )




@app.route("/meals/new/<int:meal_id>")
def save_meal_from_api(meal_id):
    try:
        api_meal = mealdb_api.get_meal_detail(meal_id)
        if not api_meal:
            flash("Gerecht niet gevonden in TheMealDB.", "error")
            return redirect(url_for("index"))

        ingredients = mealdb_api.extract_ingredients_from_meal(api_meal)

        # 1. Gerecht opslaan
        db_service.call_procedure(
            "add_meal",
            (
                int(api_meal["idMeal"]),
                api_meal.get("strMeal"),
                api_meal.get("strCategory"),
                api_meal.get("strArea"),
                api_meal.get("strInstructions"),
                api_meal.get("strMealThumb"),
            ),
        )

        # 2. Ingrediënten koppelen
        for ing in ingredients:
            db_service.call_procedure("link_meal_ingredient", (meal_id, ing))

            # 3. Automatische allergenen-detectie
            ing_lower = ing.lower()
            for keyword, allergen in ALLERGEN_MAP.items():
                if keyword in ing_lower:
                    db_service.call_procedure(
                        "link_ingredient_allergen",
                        (ing, allergen)
                    )

        flash("Gerecht opgeslagen inclusief allergenen.", "success")
        return redirect(url_for("meals_list"))

    except Exception as e:
        print(e)
        flash("Er ging iets mis bij het opslaan van het gerecht.", "error")
        return redirect(url_for("index"))



@app.route("/meals/edit/<int:meal_id>", methods=["GET", "POST"])
def edit_meal(meal_id):
    if request.method == "GET":
        meal = db_service.fetch_meal_by_id(meal_id)

        if not meal:
            flash("Gerecht niet gevonden.", "error")
            return redirect(url_for("meals_list"))

        return render_template("meal_form.html", meal=meal)

    # POST: update
    name = request.form.get("name", "").strip()
    category = request.form.get("category", "").strip()
    area = request.form.get("area", "").strip()
    instructions = request.form.get("instructions", "").strip()
    thumbnail_url = request.form.get("thumbnail_url", "").strip()

    db_service.call_procedure(
        "update_meal",
        (meal_id, name, category, area, instructions, thumbnail_url),
    )

    flash("Gerecht bijgewerkt.", "success")
    return redirect(url_for("meals_list"))





@app.route("/meals/delete/<int:meal_id>", methods=["POST"])
def delete_meal(meal_id):
    try:
        db_service.delete_meal(meal_id)
        flash("Gerecht verwijderd.", "success")
        return redirect(url_for("meals_list"))
    except Error:
        return render_template(
            "error.html",
            message="Kon het gerecht niet verwijderen.",
        )


if __name__ == "__main__":
    app.run()
