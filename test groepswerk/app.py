from flask import (
    Flask, render_template, request, redirect,
    url_for, flash, session
)

from config import Config

from services.mealdb_api import (
    search_meals_by_ingredient,
    get_meal_detail,
    extract_ingredients_from_meal
)

from services.db_service import (
    fetch_meal_by_id,
    save_meal,
    update_meal_db,
    delete_meal,
    link_meal_ingredient,
    create_user,
    get_user_by_email,
    add_favorite,
    get_user_favorites
)

from services.allergen_map import ALLERGEN_MAP

app = Flask(__name__)
app.config.from_object(Config)


def login_required():
    if "user" not in session:
        flash("Meld je eerst aan.", "warning")
        return False
    return True


@app.route("/")
def index():
    return render_template("index.html", antwoord=None)


@app.route("/gebruiker", methods=["POST"])
def gebruiker():
    naam = request.form["naam"]
    email = request.form["email"]
    actie = request.form["actie"]

    if actie == "aanmaken":
        bestaande_user = get_user_by_email(email)

        if bestaande_user:
            flash("Email bestaat al.", "warning")
            return redirect(url_for("index"))

        create_user(naam, email)
        user = get_user_by_email(email)

        session["user"] = user
        flash(f"{naam} aangemaakt en ingelogd", "success")

    elif actie == "aanmelden":
        user = get_user_by_email(email)

        if not user:
            flash("Gebruiker bestaat niet.", "error")
            return redirect(url_for("index"))

        session["user"] = user
        flash(f"Welkom terug {user['naam']}", "success")

    return redirect(url_for("index"))


@app.route("/logout")
def logout():
    session.pop("user", None)
    flash("Je bent uitgelogd", "success")
    return redirect(url_for("index"))


@app.route("/search", methods=["POST"])
def search():
    ingredient = request.form.get("ingredient")

    if not ingredient:
        flash("Geef een ingrediënt op.", "warning")
        return redirect(url_for("index"))

    meals = search_meals_by_ingredient(ingredient)

    return render_template(
        "search_results.html",
        meals=meals,
        ingredient=ingredient
    )


@app.route("/meal/<int:meal_id>")
def meal_detail(meal_id):
    api_meal = get_meal_detail(meal_id)

    if not api_meal:
        flash("Geen gerecht gevonden", "error")
        return redirect(url_for("index"))

    ingredients = extract_ingredients_from_meal(api_meal)

    allergens = []
    for ingredient in ingredients:
        key = ingredient.lower()
        if key in ALLERGEN_MAP:
            allergens.append(
                {"allergen": ALLERGEN_MAP[key]}
            )

    local_meal = fetch_meal_by_id(meal_id)

    return render_template(
        "meal_detail.html",
        meal_id=meal_id,
        api_meal=api_meal,
        ingredients=ingredients,
        allergens=allergens,
        local_meal=local_meal
    )


@app.route("/save/<int:meal_id>")
def save_meal_from_api(meal_id):

    if not login_required():
        return redirect(url_for("index"))

    meal = get_meal_detail(meal_id)

    if not meal:
        flash("Meal niet gevonden", "error")
        return redirect(url_for("index"))

    existing = fetch_meal_by_id(meal_id)

    if not existing:
        save_meal(
            meal_id,
            meal["strMeal"],
            meal["strCategory"],
            meal["strArea"],
            meal["strInstructions"],
            meal["strMealThumb"]
        )

        for ingredient in extract_ingredients_from_meal(meal):
            link_meal_ingredient(meal_id, ingredient)

    add_favorite(
        session["user"]["id"],
        meal_id
    )

    flash("Meal opgeslagen.", "success")

    return redirect(
        url_for("meal_detail", meal_id=meal_id)
    )


@app.route("/meals")
def meals_list():

    if not login_required():
        return redirect(url_for("index"))

    meals = get_user_favorites(
        session["user"]["id"]
    )

    return render_template(
        "meals_list.html",
        meals=meals
    )


@app.route("/meal/<int:meal_id>/edit",
           methods=["GET", "POST"])
def edit_meal(meal_id):

    if not login_required():
        return redirect(url_for("index"))

    meal = fetch_meal_by_id(meal_id)

    if not meal:
        flash("Meal niet gevonden.", "error")
        return redirect(url_for("meals_list"))

    if request.method == "POST":
        update_meal_db(
            meal_id,
            request.form["name"],
            request.form["category"],
            request.form["area"],
            request.form["instructions"],
            request.form["thumbnail_url"]
        )

        flash("Meal bijgewerkt.", "success")

        return redirect(
            url_for("meal_detail", meal_id=meal_id)
        )

    return render_template(
        "meal_form.html",
        meal=meal
    )


@app.route("/meal/<int:meal_id>/delete",
           methods=["POST"])
def delete_meal_route(meal_id):

    if not login_required():
        return redirect(url_for("index"))

    delete_meal(meal_id)

    flash("Meal verwijderd.", "success")

    return redirect(url_for("meals_list"))


if __name__ == "__main__":
    app.run(debug=True)
