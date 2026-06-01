import requests

BASE_URL = "https://www.themealdb.com/api/json/v1/1"


def search_meals_by_ingredient(ingredient: str):
    url = f"{BASE_URL}/filter.php"
    params = {"i": ingredient}
    resp = requests.get(url, params=params, timeout=10)
    resp.raise_for_status()
    data = resp.json()
    return data.get("meals") or []


def get_meal_detail(meal_id: int):
    url = f"{BASE_URL}/lookup.php"
    params = {"i": meal_id}
    resp = requests.get(url, params=params, timeout=10)
    resp.raise_for_status()
    data = resp.json()
    meals = data.get("meals") or []
    return meals[0] if meals else None


def extract_ingredients_from_meal(meal: dict):
    ingredients = []
    for i in range(1, 21):
        ing = meal.get(f"strIngredient{i}")
        if ing and ing.strip():
            ingredients.append(ing.strip())
    return ingredients
