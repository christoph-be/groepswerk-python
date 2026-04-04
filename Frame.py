from flask import Flask, render_template, request
import mysql.connector
from Connection import connect_to_db


app = Flask(__name__, template_folder="template")


@app.route("/")
def home():
    return render_template("Base.html")


@app.route("/Gebruiker", methods=["GET", "POST"])
def Gebruiker():
    antwoord = ""

    if request.method == "POST":
        naam = request.form.get("naam")
        email = request.form.get("email")
        actie = request.form.get("actie")

        if not naam or not email:
            antwoord = "Vul alle velden in!"
            return render_template("Gebruiker.html", antwoord=antwoord)

        conn = connect_to_db()
        cursor = conn.cursor()

        try:
            if actie == "aanmaken":
                cursor.execute(
                    "INSERT INTO gebruikers (naam, email) VALUES (%s, %s)",
                    (naam, email)
                )
                conn.commit()
                antwoord = "Gebruiker aangemaakt!"

            elif actie == "aanmelden":
                cursor.execute(
                    "SELECT * FROM gebruikers WHERE email = %s",
                    (email,)
                )
                user = cursor.fetchone()

                if user:
                    antwoord = f"Welkom {user[1]}!"
                else:
                    antwoord = "Gebruiker niet gevonden!"

        except mysql.connector.IntegrityError:
            antwoord = "Email bestaat al!"

        finally:
            cursor.close()
            conn.close()

    return render_template("Gebruiker.html", antwoord=antwoord)

# @app.route("/Gerechten", methods=["GET", "POST"])
# def Gerechten():
#    Gerechten opslaan als we met een API werken
#    Filteren op gerecht herkomst? bv( Italië , België ,Mexico)
#    Filteren op bereid tijd ?
#    Filteren op allergieen?
#


# @app.route("/Allergieen", methods=["GET", "POST"])
# def Allergieen():
#   Allergieen opslaan bij gebruiker?



if __name__ == "__main__":
    app.run(debug=True)