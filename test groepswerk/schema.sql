
DROP DATABASE IF EXISTS recipe_search;
CREATE DATABASE recipe_search
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE recipe_search;


-- =====================================
-- USERS
-- =====================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naam VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =====================================
-- INGREDIENTS
-- =====================================

CREATE TABLE ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);


-- =====================================
-- MEALS
-- =====================================

CREATE TABLE meals (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    area VARCHAR(255),
    instructions TEXT,
    thumbnail_url VARCHAR(500)
);


-- =====================================
-- MEAL INGREDIENTS
-- =====================================

CREATE TABLE meal_ingredients (
    meal_id INT NOT NULL,
    ingredient_id INT NOT NULL,

    PRIMARY KEY (
        meal_id,
        ingredient_id
    ),

    CONSTRAINT fk_meal
        FOREIGN KEY (meal_id)
        REFERENCES meals(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ingredient
        FOREIGN KEY (ingredient_id)
        REFERENCES ingredients(id)
        ON DELETE CASCADE
);


-- =====================================
-- FAVORITES PER USER
-- =====================================

CREATE TABLE favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,
    meal_id INT NOT NULL,

    created_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_favorite_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_favorite_meal
        FOREIGN KEY (meal_id)
        REFERENCES meals(id)
        ON DELETE CASCADE,

    UNIQUE (
        user_id,
        meal_id
    )
);


DELIMITER $$


-- =====================================
-- USER AANMAKEN
-- =====================================

CREATE PROCEDURE create_user(
    IN p_naam VARCHAR(255),
    IN p_email VARCHAR(255)
)
BEGIN

    INSERT INTO users(
        naam,
        email
    )
    VALUES(
        p_naam,
        p_email
    );

END$$


-- =====================================
-- USER OPHALEN
-- =====================================

CREATE PROCEDURE get_user_by_email(
    IN p_email VARCHAR(255)
)
BEGIN

    SELECT *
    FROM users
    WHERE email = p_email;

END$$


-- =====================================
-- MEAL TOEVOEGEN
-- =====================================

CREATE PROCEDURE add_meal(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_category VARCHAR(255),
    IN p_area VARCHAR(255),
    IN p_instructions TEXT,
    IN p_thumb VARCHAR(500)
)
BEGIN

    INSERT INTO meals(
        id,
        name,
        category,
        area,
        instructions,
        thumbnail_url
    )
    VALUES(
        p_id,
        p_name,
        p_category,
        p_area,
        p_instructions,
        p_thumb
    );

END$$


-- =====================================
-- MEAL UPDATEN
-- =====================================

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

    SET
        name = p_name,
        category = p_category,
        area = p_area,
        instructions = p_instructions,
        thumbnail_url = p_thumb

    WHERE id = p_id;

END$$


-- =====================================
-- MEAL VERWIJDEREN
-- =====================================

CREATE PROCEDURE delete_meal(
    IN p_id INT
)
BEGIN

    DELETE
    FROM meals
    WHERE id = p_id;

END$$


-- =====================================
-- INGREDIENT TOEVOEGEN
-- =====================================

CREATE PROCEDURE add_ingredient(
    IN p_name VARCHAR(255)
)
BEGIN

    INSERT IGNORE INTO ingredients(
        name
    )
    VALUES(
        p_name
    );

END$$


-- =====================================
-- INGREDIENT KOPPELEN
-- =====================================

CREATE PROCEDURE link_meal_ingredient(
    IN p_meal_id INT,
    IN p_ingredient_name VARCHAR(255)
)
BEGIN

    CALL add_ingredient(
        p_ingredient_name
    );

    INSERT IGNORE INTO meal_ingredients(
        meal_id,
        ingredient_id
    )

    SELECT
        p_meal_id,
        id

    FROM ingredients

    WHERE name =
        p_ingredient_name;

END$$


-- =====================================
-- FAVORIET TOEVOEGEN
-- =====================================

CREATE PROCEDURE add_favorite(
    IN p_user_id INT,
    IN p_meal_id INT
)
BEGIN

    INSERT IGNORE INTO favorites(
        user_id,
        meal_id
    )
    VALUES(
        p_user_id,
        p_meal_id
    );

END$$


-- =====================================
-- FAVORIETEN VAN GEBRUIKER
-- =====================================

CREATE PROCEDURE get_user_favorites(
    IN p_user_id INT
)
BEGIN

    SELECT m.*

    FROM meals m

    INNER JOIN favorites f
        ON m.id = f.meal_id

    WHERE f.user_id =
        p_user_id

    ORDER BY m.name;

END$$

DELIMITER ;

