-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kookcompas
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `recepten`
--

DROP TABLE IF EXISTS `recepten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recepten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titel` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie` enum('Ontbijt','Lunch','Diner','Snack','Dessert') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredienten` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `instructies` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `bereidingstijd` int DEFAULT NULL,
  `personen` int DEFAULT '2',
  `notities` text COLLATE utf8mb4_unicode_ci,
  `opgeslagen_op` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_categorie` (`categorie`),
  KEY `idx_opgeslagen` (`opgeslagen_op`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recepten`
--

LOCK TABLES `recepten` WRITE;
/*!40000 ALTER TABLE `recepten` DISABLE KEYS */;
INSERT INTO `recepten` VALUES (1,'Pasta Pomodoro','Diner','- 250g pasta\n- 4 rijpe tomaten\n- 1 ui\n- 2 teentjes knoflook\n- 2 el olijfolie\n- Zout, peper, basilicum','1. Kook de pasta volgens de verpakking\n2. Fruit de ui in olijfolie\n3. Voeg knoflook toe, bak 1 minuut\n4. Tomaten in blokjes erbij\n5. 10 minuten laten sudderen\n6. Meng pasta door de saus\n7. Garneer met basilicum',25,2,'Dit is een testrecept om te laten zien hoe de data eruit ziet!','2026-03-16 20:57:29');
/*!40000 ALTER TABLE `recepten` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-01 20:48:47
