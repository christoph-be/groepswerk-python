-- schema.sql
DROP DATABASE IF EXISTS recipe_search;
CREATE DATABASE recipe_search CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE recipe_search;

-- Tabel: ingredients
CREATE TABLE ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Tabel: meals (we slaan TheMealDB ID op als PK)
CREATE TABLE meals (
    id INT PRIMARY KEY, -- TheMealDB meal ID
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    area VARCHAR(255),
    instructions TEXT,
    thumbnail_url VARCHAR(500)
);

-- N-M tussentabel: meal_ingredients
CREATE TABLE meal_ingredients (
    meal_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    PRIMARY KEY (meal_id, ingredient_id),
    CONSTRAINT fk_meal
        FOREIGN KEY (meal_id) REFERENCES meals(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ingredient
        FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
        ON DELETE CASCADE
);

-- Optioneel: favorieten
CREATE TABLE favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    meal_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fav_meal
        FOREIGN KEY (meal_id) REFERENCES meals(id)
        ON DELETE CASCADE
);

-- Stored procedures

DELIMITER $$

-- Voeg een maaltijd toe
CREATE PROCEDURE add_meal(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_category VARCHAR(255),
    IN p_area VARCHAR(255),
    IN p_instructions TEXT,
    IN p_thumb VARCHAR(500)
)
BEGIN
    INSERT INTO meals(id, name, category, area, instructions, thumbnail_url)
    VALUES(p_id, p_name, p_category, p_area, p_instructions, p_thumb);
END$$

-- Update maaltijd
CREATE PROCEDURE update_meal(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_category VARCHAR(255),
    IN p_area VARCHAR(255),
    IN p_instructions TEXT,
    IN p_thumb VARCHAR(500)
)
BEGIN
    UPDATE meals
    SET name = p_name,
        category = p_category,
        area = p_area,
        instructions = p_instructions,
        thumbnail_url = p_thumb
    WHERE id = p_id;
END$$

-- Verwijder maaltijd
CREATE PROCEDURE delete_meal(
    IN p_id INT
)
BEGIN
    DELETE FROM meals WHERE id = p_id;
END$$

-- Voeg ingrediënt toe (of negeer bij duplicate)
CREATE PROCEDURE add_ingredient(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT IGNORE INTO ingredients(name) VALUES(p_name);
END$$

-- Koppel maaltijd en ingrediënt
CREATE PROCEDURE link_meal_ingredient(
    IN p_meal_id INT,
    IN p_ingredient_name VARCHAR(255)
)
BEGIN
    CALL add_ingredient(p_ingredient_name);
    INSERT IGNORE INTO meal_ingredients(meal_id, ingredient_id)
    SELECT p_meal_id, id FROM ingredients WHERE name = p_ingredient_name;
END$$

-- Zoek maaltijden op ingrediëntnaam
CREATE PROCEDURE find_meals_by_ingredient(
    IN p_ingredient VARCHAR(255)
)
BEGIN
    SELECT m.*
    FROM meals m
    JOIN meal_ingredients mi ON m.id = mi.meal_id
    JOIN ingredients i ON mi.ingredient_id = i.id
    WHERE i.name = p_ingredient;
END$$

DELIMITER ;
