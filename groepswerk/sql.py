

CREATE DATABASE IF NOT EXISTS Kookkompas
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS gerechten (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gerecht VARCHAR(255) NOT NULL,
    ingredienten TEXT NOT NULL,
    aangemaakt_op TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    aangepast_op TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS ingredienten (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naam VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS gerecht_ingredienten (
    gerecht_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    hoeveelheid VARCHAR(100),

    PRIMARY KEY (gerecht_id, ingredient_id),

    FOREIGN KEY (gerecht_id) REFERENCES gerechten(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredienten(id) ON DELETE CASCADE
);


INSERT INTO gerechten (gerecht, ingredienten)
VALUES
('Spaghetti Bolognese', 'Spaghetti, gehakt, tomatensaus, ui, knoflook'),
('Caesar Salad', 'Sla, kip, croutons, parmezaan, dressing'),
('Pannenkoeken', 'Bloem, melk, eieren, suiker, boter');
