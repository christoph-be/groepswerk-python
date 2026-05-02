from flask import Flask, render_template, request, redirect, url_for
from Connection import connect_to_db

app = Flask(__name__, template_folder="template")


@app.route("/")
def home():
    return render_template("base.html")



@app.route("/Gerechten", methods=["GET", "POST"])
def gerechten():
    conn = connect_to_db()
    cursor = conn.cursor()

    if request.method == "POST":
        gerecht = request.form.get("gerecht")
        ingredienten = request.form.get("ingredienten")

        cursor.execute(
            "INSERT INTO gerechten (gerecht, ingredienten) VALUES (%s, %s)",
            (gerecht, ingredienten)
        )
        conn.commit()

    cursor.execute("SELECT * FROM gerechten")
    alle_gerechten = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template("Gerechten.html", gerechten=alle_gerechten)



@app.route("/Gerecht/update/<int:id>", methods=["GET", "POST"])
def gerecht_updaten(id):
    conn = connect_to_db()
    cursor = conn.cursor()

    if request.method == "POST":
        nieuw_gerecht = request.form.get("gerecht")
        nieuwe_ingredienten = request.form.get("ingredienten")

        cursor.execute("""
            UPDATE gerechten
            SET gerecht = %s, ingredienten = %s
            WHERE id = %s
        """, (nieuw_gerecht, nieuwe_ingredienten, id))

        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for("gerechten"))


    cursor.execute("SELECT * FROM gerechten WHERE id = %s", (id,))
    gerecht = cursor.fetchone()

    cursor.close()
    conn.close()

    return render_template("Gerecht_update.html", gerecht=gerecht)



@app.route("/Gerecht/delete/<int:id>")
def gerecht_verwijderen(id):
    conn = connect_to_db()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM gerechten WHERE id = %s", (id,))
    conn.commit()

    cursor.close()
    conn.close()

    return redirect(url_for("gerechten"))
