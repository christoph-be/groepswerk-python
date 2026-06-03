
import mysql.connector
from mysql.connector import Error
from config import Config


def get_connection():
    try:
        conn = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME,
        )
        return conn
    except Error as e:
        print(f"Database connectiefout: {e}")
        raise


def call_procedure(proc_name, params=()):
    conn = None

    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.callproc(proc_name, params)

        results = []

        for result in cursor.stored_results():
            results.extend(result.fetchall())

        conn.commit()
        cursor.close()

        return results

    except Error as e:
        print(
            f"Fout bij procedure {proc_name}: {e}"
        )
        raise

    finally:
        if conn:
            conn.close()


# -------------------------
# Meals
# -------------------------
def fetch_all_meals():
    conn = get_connection()

    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM meals ORDER BY name"
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return rows


def fetch_meal_by_id(meal_id):
    conn = get_connection()

    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM meals WHERE id=%s",
        (meal_id,)
    )

    row = cursor.fetchone()

    cursor.close()
    conn.close()

    return row


def save_meal(
    meal_id,
    name,
    category,
    area,
    instructions,
    thumb
):
    return call_procedure(
        "add_meal",
        (
            meal_id,
            name,
            category,
            area,
            instructions,
            thumb
        )
    )


def update_meal_db(
    meal_id,
    name,
    category,
    area,
    instructions,
    thumb
):
    return call_procedure(
        "update_meal",
        (
            meal_id,
            name,
            category,
            area,
            instructions,
            thumb
        )
    )


def delete_meal(meal_id):
    return call_procedure(
        "delete_meal",
        (meal_id,)
    )


# -------------------------
# Ingredients
# -------------------------
def link_meal_ingredient(
    meal_id,
    ingredient_name
):
    return call_procedure(
        "link_meal_ingredient",
        (
            meal_id,
            ingredient_name
        )
    )


def find_meals_by_ingredient(
    ingredient
):
    return call_procedure(
        "find_meals_by_ingredient",
        (ingredient,)
    )


# -------------------------
# USERS
# -------------------------

def create_user(
    naam,
    email
):
    return call_procedure(
        "create_user",
        (
            naam,
            email
        )
    )


def get_user_by_email(
    email
):
    conn = get_connection()

    cursor = conn.cursor(
        dictionary=True
    )

    cursor.execute(
        """
        SELECT *
        FROM users
        WHERE email = %s
        """,
        (email,)
    )

    user = cursor.fetchone()

    cursor.close()
    conn.close()

    return user


# -------------------------
# FAVORITES
# -------------------------

def add_favorite(
    user_id,
    meal_id
):
    return call_procedure(
        "add_favorite",
        (
            user_id,
            meal_id
        )
    )


def get_user_favorites(
    user_id
):
    return call_procedure(
        "get_user_favorites",
        (user_id,)
    )

