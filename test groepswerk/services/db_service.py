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
        print(f"Fout bij uitvoeren stored procedure {proc_name}: {e}")
        raise
    finally:
        if conn:
            conn.close()


def fetch_all_meals():
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM meals ORDER BY name;")
        rows = cursor.fetchall()
        cursor.close()
        return rows
    except Error as e:
        print(f"Fout bij ophalen meals: {e}")
        raise
    finally:
        if conn:
            conn.close()


def fetch_meal_by_id(meal_id: int):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM meals WHERE id = %s;", (meal_id,))
        row = cursor.fetchone()
        cursor.close()
        return row
    except Error as e:
        print(f"Fout bij ophalen meal: {e}")
        raise
    finally:
        if conn:
            conn.close()


def delete_meal(meal_id: int):
    return call_procedure("delete_meal", (meal_id,))
