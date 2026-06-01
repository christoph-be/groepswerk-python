-- Voor dbdiagram.io: paste this in Import > From MySQL

CREATE TABLE `allergens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meal_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_fav_meal` (`meal_id`),
  CONSTRAINT `fk_fav_meal` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6395 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `meal_allergens` (
  `meal_id` int(11) NOT NULL,
  `allergen_id` int(11) NOT NULL,
  PRIMARY KEY (`meal_id`,`allergen_id`),
  KEY `fk_ma_allergen` (`allergen_id`),
  CONSTRAINT `fk_ma_allergen` FOREIGN KEY (`allergen_id`) REFERENCES `allergens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ma_meal` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `meal_ingredients` (
  `meal_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`meal_id`,`ingredient_id`),
  KEY `fk_mi_ingredient` (`ingredient_id`),
  CONSTRAINT `fk_mi_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mi_meal` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `meals` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `instructions` text DEFAULT NULL,
  `thumbnail_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

