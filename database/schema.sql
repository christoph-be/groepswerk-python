-- ==========================================
-- KOOKCOMPAS DATABASE LESMATERIAAL 🎓
-- ==========================================
-- Welkom bij de database van Kookcompas!
-- Dit bestand is niet zomaar code; het is een les in databasedesign.
-- We leggen STAP VOOR STAP uit wat we doen, maar vooral WAAROM.
-- Stel je voor dat je dit op een whiteboard uitlegt aan medestudenten.

-- ------------------------------------------
-- STAP 1: DE DATABASE (De Container)
-- ------------------------------------------
-- Een database is als een archiefkast waar alle mappen (tabellen) in zitten.

-- Commando: CREATE DATABASE
-- Wat: Maakt de archiefkast aan, maar ALLEEN als hij nog niet bestaat (IF NOT EXISTS).
-- Waarom 'utf8mb4'?
-- Computers begrijpen alleen nummers. Tekst moet vertaald worden naar nummers.
-- 'utf8mb4' is de meest complete vertaallijst. Het ondersteunt ALLE tekens ter wereld,
-- inclusief Chinese karakters én Emojis zoals 🥑, 🍕 en 🌶️.
-- Gebruik je de oude 'utf8'? Dan crasht je app als iemand een smiley opslaat!
CREATE DATABASE IF NOT EXISTS kookcompas
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Commando: USE
-- Wat: "Vanaf nu bedoel ik DEZE database met alles wat ik doe".
-- Zonder dit weet de server niet in welke archiefkast hij moet kijken.
USE kookcompas;


-- ------------------------------------------
-- STAP 2: DE TABELLEN (De Data Structuur)
-- ------------------------------------------
-- Nu gaan we de lades van de archiefkast indelen.
-- Elke tabel heeft kolommen met een specifiek DATATYPE (wat mag erin?).

-- === Tabel 1: Allergenen ===
-- Doel: Een vaste lijst met allergenen (Gluten, Pinda, etc.)
CREATE TABLE IF NOT EXISTS Allergenen (
    -- id INT AUTO_INCREMENT PRIMARY KEY
    -- INT: Het is een heel getal.
    -- AUTO_INCREMENT: De database telt zelf: 1, 2, 3... Je hoeft dit nooit zelf in te vullen.
    -- PRIMARY KEY: Dit is de unieke identiteitskaart van de rij. Hiermee vinden we data terug.
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- naam VARCHAR(50) UNIQUE NOT NULL
    -- VARCHAR(50): Variabele tekst van maximaal 50 letters. Waarom 50? Lang genoeg voor 'Schaaldieren', kort genoeg om snel te zijn.
    -- UNIQUE: Je mag niet 2x 'Gluten' erin zetten. Dat voorkomt dubbele data!
    -- NOT NULL: Dit veld MOET ingevuld zijn. Een allergeen zonder naam bestaat niet.
    naam VARCHAR(50) UNIQUE NOT NULL,
    
    -- beschrijving VARCHAR(200)
    -- Hier mag je wat meer typen (200 tekens), maar het HOEFT niet (geen NOT NULL).
    beschrijving VARCHAR(200),
    
    -- aangemaakt_op DATETIME DEFAULT CURRENT_TIMESTAMP
    -- DATETIME: Datum + Tijd.
    -- DEFAULT CURRENT_TIMESTAMP: Als je niks invult, pakt hij automatisch "NU".
    -- Handig om te zien wanneer iets is toegevoegd zonder dat je het zelf hoeft te programmeren!
    aangemaakt_op DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- === Tabel 2: Dieetwensen ===
-- Doel: Lijst met voorkeuren (Vega, Vegan, Halal).
-- Zelfde structuur als Allergenen (Consistentie is koning!).
CREATE TABLE IF NOT EXISTS Dieetwensen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naam VARCHAR(50) UNIQUE NOT NULL,
    beschrijving VARCHAR(200),
    aangemaakt_op DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- === Tabel 3: Recepten (De Hoofdtabel) ===
-- Hier komt alle belangrijke info samen.
CREATE TABLE IF NOT EXISTS Recepten (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    titel VARCHAR(100) NOT NULL, -- Titel van het gerecht. Max 100 tekens is ruim voldoende.
    
    -- categorie ENUM(...)
    -- ENUM is een vaste keuzelijst.
    -- Waarom? Het dwingt veiligheid af. Je KUNT GEEN typefouten maken zoals 'Deser' of 'Lunsh'.
    -- De database weigert alles wat niet in dit lijstje staat. Super strikt en veilig!
    categorie ENUM('Ontbijt', 'Lunch', 'Diner', 'Snack', 'Dessert') NOT NULL,
    
    -- ingredienten TEXT
    -- Waarom TEXT en geen VARCHAR?
    -- VARCHAR heeft een limiet (vaak 255). Een ingrediëntenlijst kan lang zijn!
    -- TEXT kan tot 65.000 tekens bevatten. Ruim baan voor creativiteit.
    ingredienten TEXT NOT NULL,
    instructies TEXT NOT NULL,
    
    bereidingstijd INT, -- In minuten. Makkelijk om later op te rekenen (totaal tijd).
    
    -- personen INT DEFAULT 2
    -- Als de gebruiker vergeet in te vullen voor hoeveel mensen het is, gokken we op 2.
    -- Dat maakt de app gebruiksvriendelijk (minder verplichte velden).
    personen INT DEFAULT 2,
    
    notities TEXT, -- Ruimte voor persoonlijke aantekeningen.
    opgeslagen_op DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- INDEXEN (De Snelwegwijzers)
    -- Stel je zoekt in een telefoonboek zonder alfabet... dat duurt eeuwen.
    -- Een INDEX sorteert de data op de achtergrond.
    -- Zoeken op 'Lunch'? De database springt direct naar de 'L'.
    -- Zoeken op datum? Direct naar de juiste tijd.
    -- Kost iets meer opslagruimte, maar maakt je app BLIKSEMSNEL.
    INDEX idx_categorie (categorie),
    INDEX idx_opgeslagen (opgeslagen_op)
);


-- ------------------------------------------
-- STAP 3: STORED PROCEDURES (De Functies)
-- ------------------------------------------
-- Dit is waar SQL echt krachtig wordt.
-- In plaats van in Python te zeggen: "SELECT * FROM...", maken we hier functies.
-- Waarom?
-- 1. Veiligheid: Hackers kunnen de code niet aanpassen (SQL Injection proof).
-- 2. Netheid: Je Python code blijft schoon ("haal_recepten()" vs 5 regels SQL).
-- 3. Snelheid: De database compileert dit voor en weet precies wat hij moet doen.

-- DELIMITER //
-- Standaard sluit je een commando af met een puntkomma (;).
-- Maar... onze functie BEVAT puntkomma's!
-- Dus we zeggen even: "Let op, het commando eindigt pas als je $$ ziet".
DELIMITER $$

-- Functie: Nieuw Recept Toevoegen
-- We gebruiken parameters (beginnen met p_) om verwarring met kolomnamen te voorkomen.
CREATE PROCEDURE sp_voeg_recept_toe(
    IN p_titel VARCHAR(100), 
    IN p_categorie VARCHAR(20), 
    IN p_ingredienten TEXT, 
    IN p_instructies TEXT, 
    IN p_bereidingstijd INT, 
    IN p_personen INT
)
BEGIN
    -- Hier gebeurt het echte werk: de data in de lades stoppen.
    INSERT INTO Recepten (titel, categorie, ingredienten, instructies, bereidingstijd, personen)
    VALUES (p_titel, p_categorie, p_ingredienten, p_instructies, p_bereidingstijd, p_personen);
    
    -- We geven direct het nieuwe ID terug.
    -- Waarom? Dan kan je Python programma meteen zeggen: "Recept #42 is aangemaakt!"
    SELECT LAST_INSERT_ID() AS id;
END $$

-- Functie: Procedures voor Allergenen 
-- Waarom LOWER(p_naam)?
-- Stel iemand typt 'GLUTEN' en iemand anders 'gluten'.
-- Voor een computer zijn die NIET hetzelfde.
-- Door alles naar kleine letters te dwingen, houden we de data schoon en uniform.
CREATE PROCEDURE sp_voeg_allergie_toe(IN p_naam VARCHAR(50), IN p_beschrijving VARCHAR(200))
BEGIN
    INSERT INTO Allergenen (naam, beschrijving) VALUES (LOWER(p_naam), p_beschrijving);
    SELECT LAST_INSERT_ID() AS id;
END $$

CREATE PROCEDURE sp_haal_allergenen_op()
BEGIN
    -- ORDER BY naam: Het is wel zo netjes als lijstjes op alfabetische volgorde staan.
    SELECT id, naam, beschrijving, aangemaakt_op FROM Allergenen ORDER BY naam;
END $$

CREATE PROCEDURE sp_verwijder_allergie(IN p_id INT)
BEGIN
    DELETE FROM Allergenen WHERE id = p_id;
    -- ROW_COUNT(): Vertelt ons of het gelukt is.
    -- 1 = Ja, verwijderd. 0 = Nee, bestond niet.
    SELECT ROW_COUNT() AS verwijderd;
END $$

-- Functie: Slim Zoeken
-- LIKE CONCAT('%', ..., '%')
-- % is een wildcard. Het betekent "alles".
-- '%pinda%' vindt dus: 'pinda', 'pindakaas', 'gebrande pinda's'.
-- Dit maakt je zoekbalk flexibel!
CREATE PROCEDURE sp_zoek_allergie(IN p_naam VARCHAR(50))
BEGIN
    SELECT id, naam, beschrijving FROM Allergenen WHERE naam LIKE CONCAT('%', LOWER(p_naam), '%');
END $$

-- --- Dieetwensen (Kopie van Allergenen logica) ---
CREATE PROCEDURE sp_voeg_dieet_toe(IN p_naam VARCHAR(50), IN p_beschrijving VARCHAR(200))
BEGIN
    INSERT INTO Dieetwensen (naam, beschrijving) VALUES (LOWER(p_naam), p_beschrijving);
    SELECT LAST_INSERT_ID() AS id;
END $$

CREATE PROCEDURE sp_haal_dieet_op()
BEGIN
    SELECT id, naam, beschrijving, aangemaakt_op FROM Dieetwensen ORDER BY naam;
END $$

CREATE PROCEDURE sp_verwijder_dieet(IN p_id INT)
BEGIN
    DELETE FROM Dieetwensen WHERE id = p_id;
    SELECT ROW_COUNT() AS verwijderd;
END $$

-- --- Overige Recepten Functies ---

-- Alleen de basis ophalen voor het overzicht (geen zware teksten laden = sneller!)
CREATE PROCEDURE sp_haal_recepten_op()
BEGIN
    SELECT id, titel, categorie, bereidingstijd, personen, opgeslagen_op 
    FROM Recepten 
    ORDER BY opgeslagen_op DESC; -- DESC = Descending (Nieuwste bovenaan)
END $$

-- Alles ophalen voor de detailpagina
CREATE PROCEDURE sp_haal_recept_detail(IN p_id INT)
BEGIN
    SELECT * FROM Recepten WHERE id = p_id;
END $$

CREATE PROCEDURE sp_verwijder_recept(IN p_id INT)
BEGIN
    DELETE FROM Recepten WHERE id = p_id;
    SELECT ROW_COUNT() AS verwijderd;
END $$

CREATE PROCEDURE sp_update_notities(IN p_id INT, IN p_notities TEXT)
BEGIN
    UPDATE Recepten SET notities = p_notities WHERE id = p_id;
    SELECT ROW_COUNT() AS bijgewerkt;
END $$

-- Zoeken in twee kolommen tegelijk!
-- OR: Als het woord in de Titel staat OF in de Ingredienten, dan hebben we een match.
CREATE PROCEDURE sp_zoek_recepten(IN p_zoekterm VARCHAR(100))
BEGIN
    SELECT id, titel, categorie, bereidingstijd, opgeslagen_op FROM Recepten
    WHERE titel LIKE CONCAT('%', p_zoekterm, '%') OR ingredienten LIKE CONCAT('%', p_zoekterm, '%')
    ORDER BY opgeslagen_op DESC;
END $$

CREATE PROCEDURE sp_filter_categorie(IN p_categorie VARCHAR(20))
BEGIN
    SELECT id, titel, categorie, bereidingstijd, personen, opgeslagen_op FROM Recepten
    WHERE categorie = p_categorie ORDER BY opgeslagen_op DESC;
END $$

CREATE PROCEDURE sp_tel_recepten()
BEGIN
    SELECT COUNT(*) AS aantal FROM Recepten;
END $$

-- We zijn klaar, dus we zetten het eind-teken weer terug naar normaal (;).
DELIMITER ;


-- ------------------------------------------
-- STAP 4: TESTDATA (Idempotentie)
-- ------------------------------------------
-- Idempotentie = Je kunt iets herhalen zonder dat het kapot gaat.
-- INSERT IGNORE is hier de held.

-- Scenario:
-- Je klikt per ongeluk 2x op 'Start App'.
-- Keer 1: Database voegt 'noten' toe. Succes!
-- Keer 2: Database ziet 'noten', ziet dat het UNIQUE moet zijn...
-- Zonder IGNORE: **CRASH** "Duplicate entry 'noten'".
-- Met IGNORE: "Oh, bestaat al? Prima, ik sla deze regel over en ga verder."
-- Resultaat: Een robuuste app die niet crasht bij herstarten!

INSERT IGNORE INTO Allergenen (naam, beschrijving) VALUES
('noten', 'Alle soorten noten inclusief pinda'),
('lactose', 'Melk en zuivelproducten'),
('gluten', 'Tarwe, rogge, gerst'),
('ei', 'Eieren en ei-producten'),
('schaaldieren', 'Garnalen, krab, kreeft');

INSERT IGNORE INTO Dieetwensen (naam, beschrijving) VALUES
('vegetarisch', 'Geen vlees of vis'),
('veganistisch', 'Geen dierlijke producten'),
('halal', 'Volgens islamitische voedingsregels'),
('glutenvrij', 'Geen gluten bevattende producten'),
('keto', 'Weinig koolhydraten, veel vet');

-- Voorbeeldrecept zodat de app niet leeg is bij de eerste keer opstarten.
INSERT INTO Recepten (titel, categorie, ingredienten, instructies, bereidingstijd, personen, notities) VALUES
('Pasta Pomodoro', 'Diner',
'- 250g pasta\n- 4 rijpe tomaten\n- 1 ui\n- 2 teentjes knoflook\n- 2 el olijfolie\n- Zout, peper, basilicum',
'1. Kook de pasta volgens de verpakking\n2. Fruit de ui in olijfolie\n3. Voeg knoflook toe, bak 1 minuut\n4. Tomaten in blokjes erbij\n5. 10 minuten laten sudderen\n6. Meng pasta door de saus\n7. Garneer met basilicum',
25, 2, 'Dit is een testrecept om te laten zien hoe de data eruit ziet!');

-- Als je dit ziet, is alles gelukt!
SELECT '🎉 LES VOLTOOID: Database succesvol opgebouwd en klaar voor gebruik!' AS status;
