-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: webproweek12
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `status` enum('01','02') NOT NULL DEFAULT '01',
  `pinned` tinyint(1) NOT NULL DEFAULT '0',
  `like` int NOT NULL DEFAULT '0',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (1,'What is Lorem Ipsum?','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','01',0,23,'2021-03-08 22:12:58',1),(2,'Why do we use it?','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).','02',0,5,'2021-03-08 22:13:38',2),(3,'Where does it come from?','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','01',0,3,'2021-03-08 22:14:18',1);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` float(8,2) DEFAULT '0.00',
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'2023-05-18 21:34:33',0.00,18),(7,'2023-05-19 20:24:42',0.00,NULL),(8,'2023-05-19 20:31:17',0.00,NULL),(9,'2023-05-19 20:33:28',0.00,20),(11,'2023-05-20 09:04:29',0.00,20),(12,'2023-05-20 09:09:01',0.00,20),(13,'2023-05-20 10:32:43',3470.00,20),(14,'2023-05-20 10:34:20',500.00,20),(15,'2023-05-20 10:34:28',1360.00,20),(16,'2023-05-20 11:19:27',805.00,20),(17,'2023-05-20 11:27:41',250.00,20),(49,'2023-05-21 15:32:21',805.00,20),(50,'2023-05-21 15:33:50',805.00,20),(51,'2023-05-21 15:34:26',805.00,20),(53,'2023-05-21 15:38:56',1610.00,20),(54,'2023-05-21 16:17:18',250.00,20),(55,'2023-05-21 16:17:57',805.00,20),(57,'2023-05-21 16:19:45',250.00,20),(58,'2023-05-21 16:26:57',555.00,20),(59,'2023-05-21 16:31:44',1665.00,20),(60,'2023-05-21 16:33:44',555.00,20),(61,'2023-05-21 19:33:03',1240.00,20),(62,'2023-05-21 21:57:21',840.00,20),(63,'2023-05-22 02:19:24',1090.00,20);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `item_number` int unsigned NOT NULL AUTO_INCREMENT,
  `unit_price` float(8,2) DEFAULT '0.00',
  `amount` int DEFAULT NULL,
  `total_unit_price` float(8,2) DEFAULT NULL,
  `plant_id` int NOT NULL,
  `cart_id` int NOT NULL,
  PRIMARY KEY (`item_number`,`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (1,555.00,1,555.00,20,7),(2,250.00,1,250.00,21,7),(3,250.00,2,500.00,21,8),(4,250.00,3,750.00,21,9),(5,555.00,2,1110.00,20,11),(6,250.00,3,750.00,21,11),(7,250.00,3,750.00,21,12),(8,555.00,4,2220.00,20,12),(9,250.00,5,1250.00,21,13),(10,555.00,4,2220.00,20,13),(11,250.00,2,500.00,21,14),(12,555.00,2,1110.00,20,15),(13,250.00,1,250.00,21,15),(14,250.00,1,250.00,21,16),(15,555.00,1,555.00,20,16),(16,250.00,1,250.00,21,17),(48,250.00,1,250.00,21,49),(49,555.00,1,555.00,20,49),(50,555.00,1,555.00,20,50),(51,250.00,1,250.00,21,50),(52,250.00,1,250.00,21,51),(53,555.00,1,555.00,20,51),(55,555.00,2,1110.00,20,53),(56,250.00,2,500.00,21,53),(57,250.00,1,250.00,21,54),(58,250.00,1,250.00,21,55),(59,555.00,1,555.00,20,55),(61,250.00,1,250.00,21,57),(62,555.00,1,555.00,20,58),(63,555.00,3,1665.00,20,59),(64,555.00,1,555.00,20,60),(65,590.00,1,590.00,25,61),(66,250.00,1,250.00,24,61),(67,400.00,1,400.00,23,61),(68,590.00,1,590.00,25,62),(69,250.00,1,250.00,24,62),(70,250.00,2,500.00,24,63),(71,590.00,1,590.00,25,63);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `comment` varchar(500) NOT NULL,
  `like` int NOT NULL DEFAULT '0',
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'I love your blog!',1,'2021-03-08 22:14:41',1),(2,1,'Cool :)',0,'2021-03-08 22:14:54',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `id` int NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (5,0),(10,0),(11,0),(18,0),(19,0),(20,22);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `user_id` int NOT NULL,
  `follower_id` int NOT NULL,
  `follow_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`follower_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `comment_id` int DEFAULT NULL,
  `file_path` varchar(200) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by_id` int DEFAULT NULL,
  `main` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (2,2,NULL,'/uploads/cats2.jpeg','2021-03-16 14:04:27',NULL,1),(3,2,NULL,'/uploads/cats3.jpeg','2021-03-16 14:51:56',NULL,0),(4,3,NULL,'/uploads/cats4.jpeg','2022-03-27 22:45:23',NULL,1);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'unpaid',
  `customer_id` int NOT NULL,
  `cart_id` int NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,NULL,NULL,20,53),(3,NULL,NULL,20,54),(4,NULL,NULL,20,55),(5,NULL,NULL,20,55),(6,NULL,NULL,20,57),(7,NULL,NULL,20,58),(8,NULL,NULL,20,59),(9,NULL,NULL,20,60),(24,'47 หมู่ 9 ต.จอมบึง อ.จอมบึง จ.ราชบุรี 70150','approved_bill',20,61),(25,'47 หมู่ 9 จอมบึง จองบึง ราชบุรี 70150','approved_bill',20,63);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_image`
--

DROP TABLE IF EXISTS `order_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_image` (
  `orderIM_id` int unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(250) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_id` int NOT NULL,
  PRIMARY KEY (`orderIM_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_image`
--

LOCK TABLES `order_image` WRITE;
/*!40000 ALTER TABLE `order_image` DISABLE KEYS */;
INSERT INTO `order_image` VALUES (1,'/uploads/myImage-1684701198477.jpg','2023-05-21 20:33:18',24),(2,'/uploads/myImage-1684722148239.jpg','2023-05-22 02:22:28',25);
/*!40000 ALTER TABLE `order_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plant_image`
--

DROP TABLE IF EXISTS `plant_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plant_image` (
  `pimage_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plant_id` int NOT NULL,
  `file_path` varchar(250) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `main` int DEFAULT '0',
  PRIMARY KEY (`pimage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plant_image`
--

LOCK TABLES `plant_image` WRITE;
/*!40000 ALTER TABLE `plant_image` DISABLE KEYS */;
INSERT INTO `plant_image` VALUES (3,6,'/uploads/myImage-1684271295919.jpg','2023-05-16 20:07:55',1),(4,7,'/uploads/myImage-1684271295919.jpg','2023-05-16 20:09:10',1),(20,23,'/uploads/myImage-1684695710156.jpg','2023-05-21 19:01:50',0),(21,24,'/uploads/myImage-1684695755611.jpg','2023-05-21 19:02:35',0),(22,25,'/uploads/myImage-1684695817332.jpg','2023-05-21 19:03:37',0),(24,27,'/uploads/myImage-1684705278186.jpg','2023-05-21 21:41:18',0),(25,28,'/uploads/myImage-1684721653786.jpg','2023-05-22 02:14:13',0);
/*!40000 ALTER TABLE `plant_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plants` (
  `plant_id` int unsigned NOT NULL AUTO_INCREMENT,
  `plant_name` varchar(255) NOT NULL,
  `plant_info` varchar(255) DEFAULT NULL,
  `plant_price` float(8,2) DEFAULT '0.00',
  `plant_image` varchar(255) DEFAULT NULL,
  `plant_type` enum('begonia','orchid','calathea','hoya') NOT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`plant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plants`
--

LOCK TABLES `plants` WRITE;
/*!40000 ALTER TABLE `plants` DISABLE KEYS */;
INSERT INTO `plants` VALUES (23,'Euphorbia ingens','Euphorbia ingens is a species of flowering plant in the family Euphorbiaceae. It is native to dry areas of southern Africa.',400.00,NULL,'calathea',0),(24,'Sand Rose Succulent','Adenium obesum is a poisonous species of flowering plant belonging to the tribe Nerieae of the subfamily Apocynoideae of the dogbane family',250.00,NULL,'begonia',0),(25,'Pacific Maidenhair','the maidenhair fern, is a genus of about 250 species of ferns in the subfamily Vittarioideae of the family Pteridaceae',590.00,NULL,'calathea',0),(27,'Calathea \'Misto\'','Calathea leaves are often large and colorfully patterned.The leaves are often variegated with bright colors such as pink, orange, red, and white.',130.00,NULL,'begonia',0),(28,'Big Red Bird','Huge, Showy Red Leaves. Loves a bright-filtered light and wants to be moist but not wet.',200.00,NULL,'begonia',0);
/*!40000 ALTER TABLE `plants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `seller_id` int unsigned NOT NULL AUTO_INCREMENT,
  `id` int NOT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (4,0),(8,0);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_UN` (`token`),
  KEY `token_FK` (`user_id`),
  CONSTRAINT `token_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,1,'@HvkYP-wv5Gh6vUnsHlFsDyu0STFB91Sp9TxlxrQG1yyIXPuIs!gdnql^wZBET@H2JnKFHl2K!aog@*CToRt!DF@IXUlpyNNCgz#'),(2,3,'mIi-d#WKvT60R8J3Yi/D-&YVkfB/*1cra/LlaYm7Dn2#x-=&gB-haHv#Zn4!iUYffT6cliIDuDva*R=jMXI!EYGelxqq7HwXe/MB'),(3,5,'z&IQqF9AiN$y@jW#k5oj*ZyujP=FFV=7Z5d5Yrrs^rC0iZTsB&G#KxXY-Q@27X2OmCR-jp-goPNdRyjv*@O!Rje50rLdgf&HQ2f8'),(4,18,'lN0aR0GPuXeJ3r^Xw!JTy-HofZ3802HF&rT^tzEIclW@T$eG9k1Bw=a!=frvH7ayVYMeX42mUvEcJJRU991B@*bxR67KyHe7HPAV'),(5,20,'EEu155&7Cfn!O**UbW-!Z8*YVrQqKkJUkRgkBc!!ujAhX8^4Ku3XHGwy0ZObLU7TrHkZ3O9&QJ#z2a3I^lokgv5^xhr9UxCgQChY'),(6,22,'fhVft#/IuJFo@c-M11WcAwjj6sH3I^YGM*#U$!#B=V05fqX9aGXzdUdZfX*cTQ&HApCEttxe99CE2ZiY9gWkBabIkcB#7rZ9@MB1');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(10) NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2b$05$ZuF5bL8EVjt8XgfCnWTsCeWQq0hp.UkjG3t9jf2CXC1u7RTw4zpY2','Admin','Webpro','admin@webpro.com',NULL,'0998887777','2022-04-16 07:31:40','customer'),(2,'author1','$2b$05$ZuF5bL8EVjt8XgfCnWTsCeWQq0hp.UkjG3t9jf2CXC1u7RTw4zpY2','Author','First','author1@webpro.com',NULL,NULL,'2022-04-16 07:31:40','customer'),(3,'phira111','$2b$05$YEpMj13QLYd2SNv3oMsst.pt5CJW5be1uOIsFPtnkKpotuMxWIXQq','phiraphat123','kitpromphongg','phira10@gmail.com',NULL,'0953137123','2023-05-16 08:20:27','seller'),(4,'kurogo93','$2b$05$qKcOFcRJBq.9yFss9YbrX.g8YNg4f/RhHUbMKCD8y3k3C8xGbF0Je','Ai','Kurogo','kurogo@gmail.com',NULL,'0871512757','2023-05-18 18:19:20','seller'),(5,'koga4877','$2b$05$0oRUB3i2Xh44FTmSMY3fH.tuTAOAZ1r0uNv05CKeC8aP7dgGw9KVm','sarina','Koga','Koga@gmail.com',NULL,'0953131111','2023-05-18 18:21:55','customer'),(8,'yuki1997','$2b$05$TGN3vqSjRbxEwUpNzJvE2e53.UZJxUVLy035vwsY26d4h4DmKkAum','yuki','ishii','yuki1997@gmail.com',NULL,'0626653322','2023-05-18 21:06:25','seller'),(10,'numju11','$2b$05$yYL6dqLlg7LrpRuPNn9xO.UOFJzp7STlah/F7Nwi.yLaHXCksOFhy','numju','hook','numju@gmail.com',NULL,'0888888888','2023-05-18 21:12:37','customer'),(11,'gu123','$2b$05$.GYa9omyliZ14dWHOqmmVeMDHA1FebAubxT7DWMuylYBE7LwDFEsm','ffff','fffffffff','ffffffff@gmail.com',NULL,'0999999999','2023-05-18 21:29:02','customer'),(18,'momii99','$2b$05$H9ide6wzptNSzwxYn3taae7vA4rqtLsHYmQR7nAa/451R98Va9Bai','momii','hayata','momii@gmail.com',NULL,'0999999999','2023-05-18 21:34:33','customer'),(20,'Duki125','$2b$05$PX6h64ff/tFin9LFS1qJ0eS.hdAiS7hNRoRPEZuPBU6/BdqGs8yCS','Angsana','Duki','Duki123@gmail.com',NULL,'0985524443','2023-05-19 19:15:19','customer'),(22,'phi111','$2b$05$6XLVtxvMITubDBBjXhzF4eF/eq/lor80vSDUI6GUYod/yLs15gKGm','sunthorn555','kitprom','phi@gmail.com',NULL,'0877777778','2023-05-19 19:51:26','customer');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-23 13:04:03
