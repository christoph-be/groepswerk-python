import mysql.connector
from mysql.connector import Error

def connect_to_db():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Root",
            database="Kookkompas"
        )
        if conn.is_connected():
            print("Succesvol verbonden met de database!")
            return conn
    except Error as e:
        print(f"Fout bij het verbinden met de database: {e}")
        return None