-- =============================================
-- Kookcompas Database
-- =============================================

CREATE DATABASE IF NOT EXISTS kookcompas;
USE kookcompas;

-- ---------------------------------------------
-- Tabel: gerechten (opgehaald via TheMealDB API)
-- ---------------------------------------------
CREATE TABLE gerechten (
    gerecht_id INT AUTO_INCREMENT PRIMARY KEY,
    api_id VARCHAR(20),
    naam VARCHAR(30) NOT NULL,
    categorie VARCHAR(100),
    herkomst VARCHAR(100),
    instructies TEXT,
    afbeelding_url VARCHAR(500),
    datum_opgeslagen DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------
-- Tabel: allergieen
-- ---------------------------------------------
CREATE TABLE allergieen (
    allergie_id INT AUTO_INCREMENT PRIMARY KEY,
    naam VARCHAR(100) NOT NULL UNIQUE,
    omschrijving VARCHAR(255)
);

-- ---------------------------------------------
-- Voorbeelddata allergieen
-- ---------------------------------------------
INSERT INTO allergieen (naam, omschrijving) VALUES
('Pinda', 'Allergie voor pinda en pindaproducten'),
('Gluten', 'Overgevoeligheid voor gluten in tarwe, rogge, gerst'),
('Lactose', 'Intolerantie voor melksuiker'),
('Schaaldieren', 'Allergie voor garnalen, krab, kreeft'),
('Ei', 'Allergie voor kippenei'),
('Soja', 'Allergie voor sojaproducten'),
('Noten', 'Allergie voor walnoten, cashew, amandel en dergelijke'),
('Selderij', 'Allergie voor selderij en selderijproducten');
