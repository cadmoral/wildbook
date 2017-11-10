-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: wildbook
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
-- Current Database: `wildbook`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wildbook` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `wildbook`;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `id_address` int(11) NOT NULL AUTO_INCREMENT,
  `Address` varchar(50) NOT NULL,
  `Postal_code` varchar(10) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`id_address`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'11 rue de Poissy','75005','Paris','France',2.352000,48.849000),(2,'13 rue Kvnrcvd','75006','Paris','France',1.500000,48.000000),(3,'4 Rue Eugène Spuller','75003','Paris','France',2.362000,48.864000),(4,'104 Rue d\'Auberviliers','75019','Paris','France',2.368000,48.890000);
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Is_a`
--

DROP TABLE IF EXISTS `Is_a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Is_a` (
  `id_person` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  PRIMARY KEY (`id_person`,`id_role`),
  KEY `FK_Is_a_id_role` (`id_role`),
  CONSTRAINT `FK_Is_a_id_role` FOREIGN KEY (`id_role`) REFERENCES `Roles` (`id_role`),
  CONSTRAINT `FK_id` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Is_a`
--

LOCK TABLES `Is_a` WRITE;
/*!40000 ALTER TABLE `Is_a` DISABLE KEYS */;
INSERT INTO `Is_a` VALUES (2,1),(1,2),(4,3),(3,4);
/*!40000 ALTER TABLE `Is_a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Knows`
--

DROP TABLE IF EXISTS `Knows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Knows` (
  `id_person` int(11) NOT NULL,
  `id_language` int(11) NOT NULL,
  PRIMARY KEY (`id_person`,`id_language`),
  KEY `FK_id_language` (`id_language`),
  CONSTRAINT `FK_id_language` FOREIGN KEY (`id_language`) REFERENCES `Languages` (`id_language`),
  CONSTRAINT `FK_id_person` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Knows`
--

LOCK TABLES `Knows` WRITE;
/*!40000 ALTER TABLE `Knows` DISABLE KEYS */;
INSERT INTO `Knows` VALUES (1,1),(2,1),(4,1),(1,2),(3,2);
/*!40000 ALTER TABLE `Knows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Languages`
--

DROP TABLE IF EXISTS `Languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Languages` (
  `id_language` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(25) NOT NULL,
  PRIMARY KEY (`id_language`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Languages`
--

LOCK TABLES `Languages` WRITE;
/*!40000 ALTER TABLE `Languages` DISABLE KEYS */;
INSERT INTO `Languages` VALUES (1,'Javascript'),(2,'PHP');
/*!40000 ALTER TABLE `Languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Places`
--

DROP TABLE IF EXISTS `Places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Places` (
  `id_place` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `id_address` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_place`),
  KEY `fk_address_idx` (`id_address`),
  CONSTRAINT `fk_address` FOREIGN KEY (`id_address`) REFERENCES `Address` (`id_address`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Places`
--

LOCK TABLES `Places` WRITE;
/*!40000 ALTER TABLE `Places` DISABLE KEYS */;
INSERT INTO `Places` VALUES (1,'Wild',1),(2,'Kvbni',2),(3,'Lnvfei',3),(4,'Bbrbre',4);
/*!40000 ALTER TABLE `Places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'admin'),(2,'élève'),(3,'staff'),(4,'formateur');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teaches`
--

DROP TABLE IF EXISTS `Teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teaches` (
  `id_person` int(11) NOT NULL,
  `id_person_People` int(11) NOT NULL,
  PRIMARY KEY (`id_person`,`id_person_People`),
  KEY `fk_Teaches_2_idx` (`id_person_People`),
  CONSTRAINT `fk_Teaches_1` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teaches_2` FOREIGN KEY (`id_person_People`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teaches`
--

LOCK TABLES `Teaches` WRITE;
/*!40000 ALTER TABLE `Teaches` DISABLE KEYS */;
INSERT INTO `Teaches` VALUES (1,2),(1,3),(1,4);
/*!40000 ALTER TABLE `Teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `idUsers` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idUsers`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'bob','bob'),(2,'admin','admin'),(3,'tata','tata'),(4,'vdv','vdv');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `idcontact` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idcontact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'Email',NULL),(2,'Facebook',NULL),(3,'Twitter',NULL),(4,'LinkedIn','linkedin.com');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactwith`
--

DROP TABLE IF EXISTS `contactwith`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactwith` (
  `idcontact` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`idcontact`,`id`),
  KEY `fk_contactwith_id_idx` (`id`),
  CONSTRAINT `fk_contactwith_contact` FOREIGN KEY (`idcontact`) REFERENCES `contact` (`idcontact`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_contactwith_id` FOREIGN KEY (`id`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactwith`
--

LOCK TABLES `contactwith` WRITE;
/*!40000 ALTER TABLE `contactwith` DISABLE KEYS */;
INSERT INTO `contactwith` VALUES (1,1,'hbvfvcn@vferw.com'),(1,2,'nytdjnyt'),(1,3,'ghtr'),(1,4,'yntnbrt'),(2,1,'bgfbd'),(2,2,'gregre'),(3,1,'bgrege');
/*!40000 ALTER TABLE `contactwith` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `idevent` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `place` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`idevent`),
  KEY `fk_event_idplace_idx` (`place`),
  CONSTRAINT `fk_event_idplace` FOREIGN KEY (`place`) REFERENCES `Places` (`id_place`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Anniv1',1,'2017-11-11 22:23:12',120),(2,'Anniv2',2,'2017-11-11 22:23:12',180);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `is_from_session`
--

DROP TABLE IF EXISTS `is_from_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `is_from_session` (
  `id` int(11) NOT NULL,
  `id_session` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_session`),
  KEY `fk_is_from_session_idsession_idx` (`id_session`),
  CONSTRAINT `fk_is_from_session_id` FOREIGN KEY (`id`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is_from_session_idsession` FOREIGN KEY (`id_session`) REFERENCES `sessions` (`id_session`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `is_from_session`
--

LOCK TABLES `is_from_session` WRITE;
/*!40000 ALTER TABLE `is_from_session` DISABLE KEYS */;
INSERT INTO `is_from_session` VALUES (1,1),(2,1),(3,2),(4,2);
/*!40000 ALTER TABLE `is_from_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `emailAddress` varchar(250) DEFAULT NULL,
  `session` varchar(250) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `address` int(11) DEFAULT NULL,
  `username` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_address_idx` (`address`),
  KEY `fk_people_iduser_idx` (`username`),
  CONSTRAINT `fk_people_idaddress` FOREIGN KEY (`address`) REFERENCES `Address` (`id_address`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_people_iduser` FOREIGN KEY (`username`) REFERENCES `Users` (`idUsers`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,2,'Toto','Bob','2017-11-11','1','1','2017-11-09 00:00:00',1,3),(2,3,'Tata','Tvfew','2017-11-09','2','1','2017-11-09 00:00:00',2,2),(3,4,'Ffew','Febr','2017-11-11','3','1','2017-11-09 00:00:00',3,1),(4,5,'Vdv','vdv','2017-11-09','4','2','2017-11-09 00:00:00',4,4);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id_session` int(11) NOT NULL AUTO_INCREMENT,
  `location` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `name` varchar(45) NOT NULL,
  `nickname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_session`),
  KEY `fk_sessions_idlocation_idx` (`location`),
  KEY `fk_sessions_idteacher_idx` (`teacher`),
  CONSTRAINT `fk_sessions_idlocation` FOREIGN KEY (`location`) REFERENCES `Places` (`id_place`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sessions_idteacher` FOREIGN KEY (`teacher`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,1,1,'2017-09-04','2018-02-04','JS',''),(2,3,2,'2017-09-25','2018-02-25','PHP',NULL);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takespart`
--

DROP TABLE IF EXISTS `takespart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `takespart` (
  `id_person` int(11) NOT NULL,
  `id_goes_to` int(11) NOT NULL,
  PRIMARY KEY (`id_person`,`id_goes_to`),
  KEY `fk_idplace_idx` (`id_goes_to`),
  CONSTRAINT `fk_idevent` FOREIGN KEY (`id_goes_to`) REFERENCES `event` (`idevent`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_people_idperson` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takespart`
--

LOCK TABLES `takespart` WRITE;
/*!40000 ALTER TABLE `takespart` DISABLE KEYS */;
INSERT INTO `takespart` VALUES (1,1),(1,2),(2,2),(3,2);
/*!40000 ALTER TABLE `takespart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uses`
--

DROP TABLE IF EXISTS `uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uses` (
  `id_person` int(11) NOT NULL,
  `id_goes_to` int(11) NOT NULL,
  PRIMARY KEY (`id_person`,`id_goes_to`),
  KEY `fk_idplace_idx` (`id_goes_to`),
  CONSTRAINT `fk_idperson` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idplace` FOREIGN KEY (`id_goes_to`) REFERENCES `Places` (`id_place`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uses`
--

LOCK TABLES `uses` WRITE;
/*!40000 ALTER TABLE `uses` DISABLE KEYS */;
INSERT INTO `uses` VALUES (1,1),(3,1),(2,2),(4,2);
/*!40000 ALTER TABLE `uses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-10 12:11:14
