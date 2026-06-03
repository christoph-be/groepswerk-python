
from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    flash,
    session


)

from config import Config
from services.mealdb_api import (
    search_meals_by_ingredient,
    get_meal_detail,
    extract_ingredients_from_meal
)
from services.db_service import (
    fetch_all_meals,
    fetch_meal_by_id,
    save_meal,
    update_meal_db,
    delete_meal,
    link_meal_ingredient
)
from services.allergen_map import ALLERGEN_MAP


app = Flask(__name__)
app.config.from_object(Config)


# -------------------------
# HOME
# -------------------------
@app.route("/")
def index():
    return render_template(
        "index.html",
        antwoord=None
    )


# -------------------------
# GEBRUIKER
# tijdelijke fake login
# -------------------------
@app.route(
    "/gebruiker",
    methods=["POST"]
)
def gebruiker():

    naam = request.form["naam"]
    email = request.form["email"]
    actie = request.form["actie"]

    if actie == "aanmaken":

        session["user"] = {
            "naam": naam,
            "email": email
        }

        flash(
            f"{naam} aangemaakt en ingelogd",
            "success"
        )

    elif actie == "aanmelden":

        session["user"] = {
            "naam": naam,
            "email": email
        }

        flash(
            f"Welkom terug {naam}",
            "success"
        )

    return redirect(
        url_for("index")
    )



# -------------------------
# Fake Logout
# -------------------------

@app.route("/logout")
def logout():

    session.pop("user", None)

    flash(
        "Je bent uitgelogd",
        "success"
    )

    return redirect(
        url_for("index")
    )


# -------------------------
# SEARCH
# -------------------------
@app.route(
    "/search",
    methods=["POST"]
)
def search():

    ingredient = request.form.get(
        "ingredient"
    )

    meals = search_meals_by_ingredient(
        ingredient
    )

    return render_template(
        "search_results.html",
        meals=meals,
        ingredient=ingredient
    )


# -------------------------
# DETAIL
# -------------------------
@app.route("/meal/<int:meal_id>")
def meal_detail(meal_id):

    api_meal = get_meal_detail(
        meal_id
    )

    if not api_meal:
        flash(
            "Geen gerecht gevonden",
            "error"
        )
        return redirect(
            url_for("index")
        )

    ingredients = (
        extract_ingredients_from_meal(
            api_meal
        )
    )

    allergens = []

    for ingredient in ingredients:
        key = ingredient.lower()

        if key in ALLERGEN_MAP:
            allergens.append({
                "allergen":
                ALLERGEN_MAP[key]
            })

    local_meal = fetch_meal_by_id(
        meal_id
    )

    return render_template(
        "meal_detail.html",
        meal_id=meal_id,
        api_meal=api_meal,
        ingredients=ingredients,
        allergens=allergens,
        local_meal=local_meal
    )


# -------------------------
# SAVE FROM API
# -------------------------
@app.route(
    "/save/<int:meal_id>"
)
def save_meal_from_api(
    meal_id
):

    meal = get_meal_detail(
        meal_id
    )

    if not meal:
        flash(
            "Meal niet gevonden",
            "error"
        )

        return redirect(
            url_for("index")
        )

    existing = fetch_meal_by_id(
        meal_id
    )

    if existing:
        flash(
            "Meal bestaat al",
            "warning"
        )

        return redirect(
            url_for(
                "meal_detail",
                meal_id=meal_id
            )
        )

    save_meal(
        meal_id,
        meal["strMeal"],
        meal["strCategory"],
        meal["strArea"],
        meal["strInstructions"],
        meal["strMealThumb"]
    )

    ingredients = (
        extract_ingredients_from_meal(
            meal
        )
    )

    for ingredient in ingredients:
        link_meal_ingredient(
            meal_id,
            ingredient
        )

    flash(
        "Meal opgeslagen",
        "success"
    )

    return redirect(
        url_for(
            "meal_detail",
            meal_id=meal_id
        )
    )


# -------------------------
# LIST
# -------------------------
@app.route("/meals")
def meals_list():

    meals = fetch_all_meals()

    return render_template(
        "meals_list.html",
        meals=meals
    )


# -------------------------
# EDIT
# -------------------------
@app.route(
    "/meal/<int:meal_id>/edit",
    methods=["GET", "POST"]
)
def edit_meal(meal_id):

    meal = fetch_meal_by_id(
        meal_id
    )

    if not meal:
        flash(
            "Meal niet gevonden",
            "error"
        )

        return redirect(
            url_for("meals_list")
        )

    if request.method == "POST":

        update_meal_db(
            meal_id,
            request.form["name"],
            request.form["category"],
            request.form["area"],
            request.form["instructions"],
            request.form[
                "thumbnail_url"
            ]
        )

        flash(
            "Meal bijgewerkt",
            "success"
        )

        return redirect(
            url_for(
                "meal_detail",
                meal_id=meal_id
            )
        )

    return render_template(
        "meal_form.html",
        meal=meal
    )


# -------------------------
# DELETE
# -------------------------
@app.route(
    "/meal/<int:meal_id>/delete",
    methods=["POST"]
)
def delete_meal_route(
    meal_id
):

    delete_meal(meal_id)

    flash(
        "Meal verwijderd",
        "success"
    )

    return redirect(
        url_for("meals_list")
    )


if __name__ == "__main__":
    app.run(debug=True)

