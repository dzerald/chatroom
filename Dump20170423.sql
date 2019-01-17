-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `m_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `date` datetime DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `r_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`m_id`),
  KEY `fk_users_id` (`users_id`),
  KEY `fk_r_id` (`r_id`),
  CONSTRAINT `fk_r_id` FOREIGN KEY (`r_id`) REFERENCES `rooms` (`room_id`),
  CONSTRAINT `fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'asd','1994-01-01 23:52:51',1,1),(3,'woreno1','2017-04-23 00:23:19',332,1);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_id` int(10) NOT NULL,
  `roomname` varchar(45) NOT NULL,
  `Public` tinyint(1) NOT NULL,
  `flood` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'Room 1',1,1),(2,'Room 2',1,1),(3,'Room 3',1,1),(4,'Room 4',1,1),(5,'Room 5',1,0),(6,'Room 6',1,0);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `ip` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'woren','asd'),(2,'hej','asd'),(3,'woren','asd'),(4,'asd','asd'),(5,'asd','asd'),(6,'asd','asd'),(7,'asd','asd'),(8,'45','asd'),(9,'asd','asd'),(10,'asd','asd'),(11,'room1','asd'),(12,'room2','asd'),(13,'room 3','asd'),(14,'asd','asd'),(15,'asd','asd'),(16,'asd','asd'),(17,'ds','asd'),(18,'asd','asd'),(19,'room','asd'),(20,'asd','asd'),(21,'asd','asd'),(22,'asd','asd'),(23,'asd','asd'),(24,'d','asd'),(25,'123','asd'),(26,'123','asd'),(27,'123','asd'),(28,'5lk','asd'),(29,'654','asd'),(30,'77777','asd'),(31,'woreno','asd'),(32,'asd','asd'),(33,'asd','asd'),(34,'asd','asd'),(35,'asd','asd'),(36,'ads','asd'),(37,'jakisnick','asd'),(38,'asd','asd'),(39,'asd','asd'),(40,'asd','asd'),(41,'asd','asd'),(42,'asd','asd'),(43,'asd','asd'),(44,'asd','asd'),(45,'sad','asd'),(46,'asd','asd'),(47,'asd','asd'),(48,'woren1','asd'),(49,'woren2','asd'),(50,'woren2','asd'),(51,'hejho','asd'),(52,'sratatata','asd'),(53,'asdasd','asd'),(54,'dddddddddddddd','asd'),(55,'dddddddddd','asd'),(56,'asd','asd'),(57,'asdd23123123123','asd'),(58,'asd','asd'),(59,'asd','asd'),(60,'asd','asd'),(61,'asd','asd'),(62,'asd','asd'),(63,'asd','asd'),(64,'woren','asd'),(65,'gigsav','asd'),(66,'asd','asd'),(67,'ddd','asd'),(68,'asd','asd'),(69,'aaaa','asd'),(70,'dddd','asd'),(71,'asd','asd'),(72,'asd2','asd'),(73,'asdasd','asd'),(74,'asd','asd'),(75,'asd','asd'),(76,'asd','asd'),(77,'asdads','asd'),(78,'asdasd','asd'),(79,'sad','asd'),(80,'asdddddd213123123','asd'),(81,'woren','asd'),(82,'asd','asd'),(83,'asd','asd'),(84,'asd','asd'),(85,'asd','asd'),(86,'asd','asd'),(87,'asd','asd'),(88,'asd','asd'),(89,'asd','asd'),(90,'asd','asd'),(91,'asd','asd'),(92,'asd','asd'),(93,'asd','asd'),(94,'asd','asd'),(95,'asd','asd'),(96,'546','asd'),(97,'asd','asd'),(98,'ads','asd'),(99,'asd','asd'),(100,'asd','asd'),(101,'asd','asd'),(102,'asd','asd'),(103,'asd','asd'),(104,'465','asd'),(105,'645','asd'),(106,'654','asd'),(107,'asd','asd'),(108,'ads','asd'),(109,'asd','asd'),(110,'asdasd','asd'),(111,'asd','asd'),(112,'asd','asd'),(113,'asd','asd'),(114,'asd','asd'),(115,'asd','asd'),(116,'asd','asd'),(117,'asd','asd'),(118,'asd','asd'),(119,'asd','asd'),(120,'sdaasd','asd'),(121,'das','asd'),(122,'asd','asd'),(123,'asd','asd'),(124,'asd22','asd'),(125,'zxczxc','asd'),(126,'asd','asd'),(127,'wwww','asd'),(128,'www','asd'),(129,'aaa','asd'),(130,'asd','asd'),(131,'asd','asd'),(132,'asd','asd'),(133,'dddddd','asd'),(134,'dddddd','asd'),(135,'asd','asd'),(136,'asdaaa','asd'),(137,'asd','asd'),(138,'asd2','asd'),(139,'asd1','asd'),(140,'a','asd'),(141,'z','asd'),(142,'asd','asd'),(143,'zxc','asd'),(144,'asd','asd'),(145,'asd','asd'),(146,'asd','asd'),(147,'asd','asd'),(148,'564','asd'),(149,'asd','asd'),(150,'654','asd'),(151,'654','asd'),(152,'asd','asd'),(153,'asd','asd'),(154,'asd','asd'),(155,'ddasd','asd'),(156,'asd','asd'),(157,'asd','asd'),(158,'asd','asd'),(159,'asd','asd'),(160,'sad','asd'),(161,'asd','asd'),(162,'asd','asd'),(163,'asd','asd'),(164,'asd','asd'),(165,'ads','asd'),(166,'asd','asd'),(167,'asd','asd'),(168,'asd','asd'),(169,'asd','asd'),(170,'asd','asd'),(171,'asd','asd'),(172,'ads','asd'),(173,'asd','asd'),(174,'asd','asd'),(175,'asd','asd'),(176,'asd','asd'),(177,'asd','asd'),(178,'d','asd'),(179,'asd','asd'),(180,'asd','asd'),(181,'asd','asd'),(182,'asd','asd'),(183,'asd','asd'),(184,'asd','asd'),(185,'asd','asd'),(186,'asd','asd'),(187,'asd','asd'),(188,'f','asd'),(189,'asd','asd'),(190,'sda','asd'),(191,'asd','asd'),(192,'d','asd'),(193,'asd','asd'),(194,'asd','asd'),(195,'asd','asd'),(196,'asd','asd'),(197,'ddd','asd'),(198,'d','asd'),(199,'asd','asd'),(200,'a','asd'),(201,'d','asd'),(202,'f','asd'),(203,'asd','asd'),(204,'ads','asd'),(205,'das','asd'),(206,'das','asd'),(207,'asd','asd'),(208,'d','asd'),(209,'asd','asd'),(210,'adsssss','asd'),(211,'ddd','asd'),(212,'asdads','asd'),(213,'asd','asd'),(214,'asd','asd'),(215,'asdddddd','asd'),(216,'asd','asd'),(217,'asdads','asd'),(218,'asd','asd'),(219,'aaa','asd'),(220,'d','asd'),(221,'654','asd'),(222,'asd','asd'),(223,'asd','asd'),(224,'asddas','asd'),(225,'asd','asd'),(226,'asd','asd'),(227,'a','asd'),(228,'worenisawesome','asd'),(229,'65','asd'),(230,'asd','asd'),(231,'a231','asd'),(232,'a3123sss','asd'),(233,'asd','asd'),(234,'asd','asd'),(235,'asd','asd'),(236,'www','asd'),(237,'asd','asd'),(238,'wwwww','asd'),(239,'wwwww','asd'),(240,'waaw','asd'),(241,'wa21wa22','asd'),(242,'wwad','asd'),(243,'wwad231','asd'),(244,'wwww','asd'),(245,'waaaaaaa','asd'),(246,'ddddddddd','asd'),(247,'wwwaaaad','asd'),(248,'woren','asd'),(249,'w','asd'),(250,'woren','asd'),(251,'asd','asd'),(252,'aaaa','asd'),(253,'wwwww','asd'),(254,'aaaaaa','asd'),(255,'woren','asd'),(256,'dzerald','asd'),(257,'woren','asd'),(258,'dzerald','asd'),(259,'woren','asd'),(260,'wiktor','asd'),(261,'wiktor2','asd'),(262,'konaxo','asd'),(263,'kris','asd'),(264,'qqq','asd'),(265,'Kgzogsoysy','asd'),(266,'565656','asd'),(267,'kris','asd'),(268,'564','asd'),(269,'asd','asd'),(270,'asd','asd'),(271,'asd','asd'),(272,'woren','asd'),(273,'asd','asd'),(274,'asd','asd'),(275,'asd','asd'),(276,'sad','asd'),(277,'asd','asd'),(278,'asd','asd'),(279,'asd','asd'),(280,'d','asd'),(281,'hjk','asd'),(282,'kh','asd'),(283,'asd','asd'),(284,'asd','asd'),(285,'asd','asd'),(286,'ads','asd'),(287,'d','asd'),(288,'das','asd'),(289,'asd','asd'),(290,'asd','asd'),(291,'asd','asd'),(292,'asd','asd'),(293,'asd','asd'),(294,'asd','asd'),(295,'asd','asd'),(296,'dsa','asd'),(297,'asd','asd'),(298,'asd','asd'),(299,'asd','asd'),(300,'asd','asd'),(301,'asd','asd'),(302,'asd','asd'),(303,'asd','asd'),(304,'asd','asd'),(305,'asd','asd'),(306,'sad','asd'),(307,'asd','asd'),(308,'d','asd'),(309,'asd','asd'),(310,'asd','asd'),(311,'asd','asd'),(312,'asd','asd'),(313,'d','asd'),(314,'asd','asd'),(315,'asd','asd'),(316,'asd','asd'),(317,'sad','asd'),(318,'asd','asd'),(319,'asd','asd'),(320,'asd','asd'),(321,'asd','asd'),(322,'asd','asd'),(323,'asd','asd'),(324,'asd','asd'),(325,'asd','asd'),(326,'asd','asd'),(327,'asd3','asd'),(328,'woren','asd'),(329,'asd','asd'),(330,'sda','asd'),(331,'qwe','asd'),(332,'worenos','asd');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_has_rooms`
--

DROP TABLE IF EXISTS `users_has_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_has_rooms` (
  `Users_user_id` int(11) NOT NULL,
  `Rooms_room_id` int(10) DEFAULT NULL,
  `ur_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ur_id`),
  KEY `fk_Users_has_Rooms_Rooms1_idx` (`Rooms_room_id`),
  KEY `fk_Users_has_Rooms_Users_idx` (`Users_user_id`),
  CONSTRAINT `fk_Users_has_Rooms_Users` FOREIGN KEY (`Users_user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `users_has_rooms_ibfk_1` FOREIGN KEY (`Rooms_room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_has_rooms`
--

LOCK TABLES `users_has_rooms` WRITE;
/*!40000 ALTER TABLE `users_has_rooms` DISABLE KEYS */;
INSERT INTO `users_has_rooms` VALUES (332,1,1);
/*!40000 ALTER TABLE `users_has_rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-23  0:31:54
