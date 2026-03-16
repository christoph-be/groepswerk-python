-- KookKompas Database Schema
-- SQLite versie

CREATE TABLE IF NOT EXISTS allergenen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    naam TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dieetwensen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    naam TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS recepten (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    naam TEXT NOT NULL,
    categorie TEXT DEFAULT 'Diner',
    bereidingstijd INTEGER DEFAULT 30,
    ingredienten TEXT,
    bereiding TEXT,
    personen INTEGER DEFAULT 2,
    aangemaakt_op TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS boodschappen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recept_id INTEGER,
    item TEXT NOT NULL,
    afgevinkt INTEGER DEFAULT 0,
    FOREIGN KEY (recept_id) REFERENCES recepten(id) ON DELETE CASCADE
);

-- Seed data
INSERT OR IGNORE INTO allergenen (naam) VALUES ('Noten');
INSERT OR IGNORE INTO allergenen (naam) VALUES ('Gluten');
INSERT OR IGNORE INTO allergenen (naam) VALUES ('Lactose');

INSERT OR IGNORE INTO dieetwensen (naam) VALUES ('Vegetarisch');
INSERT OR IGNORE INTO dieetwensen (naam) VALUES ('Glutenvrij');

INSERT OR IGNORE INTO recepten (naam, categorie, bereidingstijd, ingredienten, bereiding, personen) VALUES (
    'Mediterrane Pasta met Verse Tomaten',
    'Diner',
    25,
    '["250g glutenvrije pasta","4 rijpe tomaten, in blokjes","1 ui, fijngesneden","3 teentjes knoflook, geperst","2 el olijfolie","Zout, peper, verse basilicum"]',
    '["Kook de pasta volgens de verpakking. Giet af en houd een kopje kookvocht apart.","Verhit olijfolie in een grote pan en fruit de ui 3-4 minuten glazig.","Voeg knoflook toe en bak 1 minuut mee tot het geurt.","Voeg tomaten en een snufje zout toe. Laat 8-10 minuten zachtjes pruttelen.","Meng de pasta door de saus. Voeg kookvocht toe voor extra romigheid.","Serveer met verse basilicum en een draai peper. Eet smakelijk!"]',
    2
);

INSERT OR IGNORE INTO recepten (naam, categorie, bereidingstijd, ingredienten, bereiding, personen) VALUES (
    'Havermout Power Bowl',
    'Ontbijt',
    10,
    '["80g havermout","200ml amandelmelk","1 banaan","Handvol blauwe bessen","1 el chiazaad","1 tl honing","Snufje kaneel"]',
    '["Kook de havermout met amandelmelk op middelhoog vuur, 5 minuten roerend.","Snijd de banaan in plakjes.","Schep de havermout in een kom.","Top met banaanplakjes, blauwe bessen en chiazaad.","Druppel honing erover en bestrooi met kaneel."]',
    1
);

INSERT OR IGNORE INTO recepten (naam, categorie, bereidingstijd, ingredienten, bereiding, personen) VALUES (
    'Groene Power Salade',
    'Lunch',
    15,
    '["200g gemengde sla","1 avocado","100g kikkererwten (uit blik)","1 komkommer","10 cherrytomaatjes","2 el pompoenpitten","Citroendressing"]',
    '["Was de sla en verdeel over twee borden.","Snijd de avocado in partjes en de komkommer in halve plakjes.","Halveer de cherrytomaatjes.","Spoel de kikkererwten af en verdeel alles over de sla.","Bestrooi met pompoenpitten en besprenkel met citroendressing."]',
    2
);
