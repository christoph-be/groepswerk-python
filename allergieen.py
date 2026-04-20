import tkinter as tk
from tkinter import messagebox
import mysql.connector
from db_verbinding import maak_verbinding


# --- DATABASE FUNCTIES ---

def haal_alle_allergieen_op():
    verbinding = maak_verbinding()
    if not verbinding:
        return []
    cursor = verbinding.cursor()
    cursor.execute("SELECT allergie_id, naam, omschrijving FROM allergieen ORDER BY naam")
    rijen = cursor.fetchall()
    cursor.close()
    verbinding.close()
    return rijen


def sla_allergie_op(allergie_naam, beschrijving):
    verbinding = maak_verbinding()
    if not verbinding:
        return False
    try:
        cursor = verbinding.cursor()
        cursor.execute(
            "INSERT INTO allergieen (naam, omschrijving) VALUES (%s, %s)",
            (allergie_naam, beschrijving)
        )
        verbinding.commit()
        cursor.close()
        verbinding.close()
        return True
    except mysql.connector.IntegrityError:
        verbinding.close()
        return False


def werk_allergie_bij(allergie_id, nieuwe_naam, nieuwe_beschrijving):
    verbinding = maak_verbinding()
    if not verbinding:
        return False
    cursor = verbinding.cursor()
    cursor.execute(
        "UPDATE allergieen SET naam = %s, omschrijving = %s WHERE allergie_id = %s",
        (nieuwe_naam, nieuwe_beschrijving, allergie_id)
    )
    verbinding.commit()
    cursor.close()
    verbinding.close()
    return True


def verwijder_allergie_uit_db(allergie_id):
    verbinding = maak_verbinding()
    if not verbinding:
        return False
    cursor = verbinding.cursor()
    cursor.execute("DELETE FROM allergieen WHERE allergie_id = %s", (allergie_id,))
    verbinding.commit()
    cursor.close()
    verbinding.close()
    return True


# --- GUI ---

class AllergieScherm:
    def __init__(self, hoofd_venster):
        self.venster = hoofd_venster
        self.venster.title("Kookcompas - Allergieen beheren")
        self.venster.geometry("520x480")
        self.geselecteerde_id = None

        # Lijst
        self.lijst = tk.Listbox(self.venster, width=60, height=12)
        self.lijst.pack(pady=10)
        self.lijst.bind("<<ListboxSelect>>", self.bij_selectie)

        # Invoervelden
        velden_frame = tk.Frame(self.venster)
        velden_frame.pack(pady=5)

        tk.Label(velden_frame, text="Naam:").grid(row=0, column=0, sticky="e", padx=5)
        self.invoer_naam = tk.Entry(velden_frame, width=30)
        self.invoer_naam.grid(row=0, column=1, padx=5, pady=3)

        tk.Label(velden_frame, text="Omschrijving:").grid(row=1, column=0, sticky="e", padx=5)
        self.invoer_omschrijving = tk.Entry(velden_frame, width=30)
        self.invoer_omschrijving.grid(row=1, column=1, padx=5, pady=3)

        # Knoppen
        knoppen_frame = tk.Frame(self.venster)
        knoppen_frame.pack(pady=10)

        tk.Button(knoppen_frame, text="Toevoegen", width=12, command=self.voeg_toe).grid(row=0, column=0, padx=5)
        tk.Button(knoppen_frame, text="Wijzigen", width=12, command=self.wijzig).grid(row=0, column=1, padx=5)
        tk.Button(knoppen_frame, text="Verwijderen", width=12, command=self.verwijder).grid(row=0, column=2, padx=5)
        tk.Button(knoppen_frame, text="Leegmaken", width=12, command=self.maak_velden_leeg).grid(row=0, column=3, padx=5)

        self.ververs_lijst()

    def ververs_lijst(self):
        self.lijst.delete(0, tk.END)
        self.alle_allergieen = haal_alle_allergieen_op()
        for allergie in self.alle_allergieen:
            weergave = f"{allergie[1]}  -  {allergie[2] or 'geen omschrijving'}"
            self.lijst.insert(tk.END, weergave)

    def bij_selectie(self, event):
        selectie = self.lijst.curselection()
        if not selectie:
            return
        positie = selectie[0]
        gekozen = self.alle_allergieen[positie]
        self.geselecteerde_id = gekozen[0]

        self.invoer_naam.delete(0, tk.END)
        self.invoer_naam.insert(0, gekozen[1])
        self.invoer_omschrijving.delete(0, tk.END)
        self.invoer_omschrijving.insert(0, gekozen[2] or "")

    def voeg_toe(self):
        allergie_naam = self.invoer_naam.get().strip()
        beschrijving = self.invoer_omschrijving.get().strip()

        if not allergie_naam:
            messagebox.showwarning("Leeg veld", "Vul minstens een naam in")
            return

        gelukt = sla_allergie_op(allergie_naam, beschrijving)
        if gelukt:
            self.maak_velden_leeg()
            self.ververs_lijst()
        else:
            messagebox.showerror("Bestaat al", f"'{allergie_naam}' staat al in de lijst")

    def wijzig(self):
        if self.geselecteerde_id is None:
            messagebox.showwarning("Niks geselecteerd", "Klik eerst op een allergie in de lijst")
            return

        nieuwe_naam = self.invoer_naam.get().strip()
        nieuwe_beschrijving = self.invoer_omschrijving.get().strip()

        if not nieuwe_naam:
            messagebox.showwarning("Leeg veld", "Naam mag niet leeg zijn")
            return

        werk_allergie_bij(self.geselecteerde_id, nieuwe_naam, nieuwe_beschrijving)
        self.maak_velden_leeg()
        self.ververs_lijst()

    def verwijder(self):
        if self.geselecteerde_id is None:
            messagebox.showwarning("Niks geselecteerd", "Klik eerst op een allergie in de lijst")
            return

        bevestig = messagebox.askyesno("Bevestiging", "Weet je zeker dat deze allergie weg mag?")
        if bevestig:
            verwijder_allergie_uit_db(self.geselecteerde_id)
            self.maak_velden_leeg()
            self.ververs_lijst()

    def maak_velden_leeg(self):
        self.geselecteerde_id = None
        self.invoer_naam.delete(0, tk.END)
        self.invoer_omschrijving.delete(0, tk.END)
        self.lijst.selection_clear(0, tk.END)


if __name__ == "__main__":
    root = tk.Tk()
    scherm = AllergieScherm(root)
    root.mainloop()
