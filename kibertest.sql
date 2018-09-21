-- MySQL dump 10.13  Distrib 5.7.22-22, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: kibertest
-- ------------------------------------------------------
-- Server version	5.7.22-22-log

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
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Current Database: `kibertest`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `kibertest` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `kibertest`;

--
-- Table structure for table `course_description`
--

DROP TABLE IF EXISTS `course_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_description` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_course` bigint(20) unsigned NOT NULL,
  `id_text` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fkey_courses_d` (`id_course`),
  KEY `fkey_text_d` (`id_text`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_description`
--

LOCK TABLES `course_description` WRITE;
/*!40000 ALTER TABLE `course_description` DISABLE KEYS */;
INSERT INTO `course_description` (`id`, `id_course`, `id_text`) VALUES (12,8,47);
INSERT INTO `course_description` (`id`, `id_course`, `id_text`) VALUES (13,9,258);
/*!40000 ALTER TABLE `course_description` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createTexts` BEFORE INSERT ON `course_description` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите описание курса');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteTextAfterDeleteCourseDescription` AFTER DELETE ON `course_description` FOR EACH ROW BEGIN
DELETE FROM text WHERE id_text=OLD.id_text;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL,
  `logo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` (`id`, `name`, `logo`) VALUES (8,'Введение в компьютерный дизайн',0);
INSERT INTO `courses` (`id`, `name`, `logo`) VALUES (9,'Пустой тестовый курс',0);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createCourseDescription` AFTER INSERT ON `courses` FOR EACH ROW INSERT INTO course_description(id_course) VALUES(NEW.id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteCoursesDescriptionAndLessonsAfterDeleteCourse` AFTER DELETE ON `courses` FOR EACH ROW BEGIN
	DELETE FROM course_description WHERE id_course=OLD.id;
    DELETE FROM lessons WHERE id_course=OLD.id;
    DELETE FROM curator_course WHERE id_course=OLD.id;
    DELETE FROM user_result WHERE id_course=OLD.id;
    DELETE FROM teacher_course WHERE id_course=OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `curator_course`
--

DROP TABLE IF EXISTS `curator_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curator_course` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_curator` bigint(20) unsigned NOT NULL,
  `id_course` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_course` (`id_course`),
  KEY `fkey_curators_cc` (`id_curator`),
  CONSTRAINT `fkey_courses_cc` FOREIGN KEY (`id_course`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkey_curators_cc` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curator_course`
--

LOCK TABLES `curator_course` WRITE;
/*!40000 ALTER TABLE `curator_course` DISABLE KEYS */;
INSERT INTO `curator_course` (`id`, `id_curator`, `id_course`) VALUES (5,19,8);
INSERT INTO `curator_course` (`id`, `id_curator`, `id_course`) VALUES (6,19,9);
/*!40000 ALTER TABLE `curator_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curator_student`
--

DROP TABLE IF EXISTS `curator_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curator_student` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_curator` bigint(20) unsigned NOT NULL,
  `id_student` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_student` (`id_student`),
  KEY `fkey_curators_cs` (`id_curator`),
  CONSTRAINT `fkey_curators_cs` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkey_students_cs` FOREIGN KEY (`id_student`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curator_student`
--

LOCK TABLES `curator_student` WRITE;
/*!40000 ALTER TABLE `curator_student` DISABLE KEYS */;
INSERT INTO `curator_student` (`id`, `id_curator`, `id_student`) VALUES (7,19,23);
INSERT INTO `curator_student` (`id`, `id_curator`, `id_student`) VALUES (8,19,24);
INSERT INTO `curator_student` (`id`, `id_curator`, `id_student`) VALUES (10,20,25);
/*!40000 ALTER TABLE `curator_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curator_teacher`
--

DROP TABLE IF EXISTS `curator_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curator_teacher` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_curator` bigint(20) unsigned NOT NULL,
  `id_teacher` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_teacher` (`id_teacher`),
  KEY `fkey_curators_ct` (`id_curator`),
  CONSTRAINT `fkey_curators_ct` FOREIGN KEY (`id_curator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkey_teachers_ct` FOREIGN KEY (`id_teacher`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curator_teacher`
--

LOCK TABLES `curator_teacher` WRITE;
/*!40000 ALTER TABLE `curator_teacher` DISABLE KEYS */;
INSERT INTO `curator_teacher` (`id`, `id_curator`, `id_teacher`) VALUES (3,19,21);
INSERT INTO `curator_teacher` (`id`, `id_curator`, `id_teacher`) VALUES (4,19,22);
INSERT INTO `curator_teacher` (`id`, `id_curator`, `id_teacher`) VALUES (5,20,26);
INSERT INTO `curator_teacher` (`id`, `id_curator`, `id_teacher`) VALUES (6,20,27);
/*!40000 ALTER TABLE `curator_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curator_test`
--

DROP TABLE IF EXISTS `curator_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curator_test` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_curator` bigint(20) unsigned NOT NULL,
  `id_test` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_curators_ct2` (`id_curator`),
  KEY `fkey_tests_ct2` (`id_test`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curator_test`
--

LOCK TABLES `curator_test` WRITE;
/*!40000 ALTER TABLE `curator_test` DISABLE KEYS */;
INSERT INTO `curator_test` (`id`, `id_curator`, `id_test`) VALUES (45,19,15);
INSERT INTO `curator_test` (`id`, `id_curator`, `id_test`) VALUES (47,19,14);
/*!40000 ALTER TABLE `curator_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_questions_ansver_temp`
--

DROP TABLE IF EXISTS `gen_questions_ansver_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_questions_ansver_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_gen_question` bigint(20) unsigned NOT NULL,
  `ansver` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueRecord` (`id_gen_question`,`ansver`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_questions_ansver_temp`
--

LOCK TABLES `gen_questions_ansver_temp` WRITE;
/*!40000 ALTER TABLE `gen_questions_ansver_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_questions_ansver_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_questions_temp`
--

DROP TABLE IF EXISTS `gen_questions_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_questions_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_gen_session` bigint(20) unsigned NOT NULL,
  `id_question` bigint(20) unsigned NOT NULL,
  `number` int(11) NOT NULL,
  `ansver` tinyint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkey_session_gqt` (`id_gen_session`),
  KEY `fkey_question_gqt` (`id_question`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_questions_temp`
--

LOCK TABLES `gen_questions_temp` WRITE;
/*!40000 ALTER TABLE `gen_questions_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_questions_temp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteVariants` AFTER DELETE ON `gen_questions_temp` FOR EACH ROW BEGIN
	DELETE FROM gen_variants_temp WHERE id_gen_question=OLD.id;
    DELETE FROM gen_questions_ansver_temp WHERE id_gen_question=OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gen_variants_temp`
--

DROP TABLE IF EXISTS `gen_variants_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_variants_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_gen_question` bigint(20) unsigned NOT NULL,
  `id_variant` bigint(20) unsigned NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_question_gvt` (`id_gen_question`),
  KEY `fkey_variants_gvt` (`id_variant`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_variants_temp`
--

LOCK TABLES `gen_variants_temp` WRITE;
/*!40000 ALTER TABLE `gen_variants_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_variants_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `src` text NOT NULL,
  `type` text NOT NULL,
  `formatting` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_course` bigint(20) unsigned NOT NULL,
  `number` int(11) NOT NULL,
  `id_text` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fkey_courses_l` (`id_course`),
  KEY `fkey_texts_l` (`id_text`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (17,8,0,117,'Введение');
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (18,8,1,118,'История шрифта');
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (19,8,2,119,'Упаковка');
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (20,9,0,259,'Новый урок');
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (21,9,1,260,'Новый урок');
INSERT INTO `lessons` (`id`, `id_course`, `number`, `id_text`, `name`) VALUES (22,9,2,261,'Новый урок');
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createTextL` BEFORE INSERT ON `lessons` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Новый урок');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    SET NEW.name='Новый урок';
    
    SET @count=(SELECT COUNT(*) FROM lessons WHERE 		 				id_course=NEW.id_course);
    
    IF @count=0 THEN
    	SET NEW.number=0;
    ELSE
    	SET @last=(SELECT MAX(number) FROM lessons WHERE 					id_course=NEW.id_course);
        SET NEW.number=@last+1;
    END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteTextAfterDeleteLesson` AFTER DELETE ON `lessons` FOR EACH ROW DELETE FROM text WHERE id_text=OLD.id_text */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_test` bigint(20) unsigned NOT NULL,
  `number` tinyint(4) NOT NULL,
  `name` text NOT NULL,
  `id_text` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_tests_q` (`id_test`),
  KEY `fkey_texts_q` (`id_text`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (56,14,1,'Вопрос 1',222);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (57,14,2,'Вопрос 2',223);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (58,14,3,'Вопрос 3',224);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (59,14,4,'Вопрос 4',225);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (60,14,5,'Вопрос 5',226);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (61,15,1,'Вопрос 1',263);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (62,15,2,'Вопрос 2',264);
INSERT INTO `questions` (`id`, `id_test`, `number`, `name`, `id_text`) VALUES (63,15,3,'Вопрос 3',265);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createQuestion` BEFORE INSERT ON `questions` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите текст вопроса');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    
    SET @count=(SELECT COUNT(*) FROM questions WHERE 						id_test=NEW.id_test);
    IF @count>0 THEN
    	SET @max=(SELECT MAX(number) FROM questions WHERE 							id_test=NEW.id_test);
        SET NEW.number=@max+1;
        SET NEW.name=CONCAT('Вопрос ',@max+1);
    ELSE
        SET NEW.number=1;
        SET NEW.name='Вопрос 1';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createQuestionCheckActive` AFTER INSERT ON `questions` FOR EACH ROW BEGIN
	SET @count=(SELECT COUNT(*) FROM variants WHERE id_question=NEW.id);
    IF @count>1 THEN
    	SET @i=0;
    ELSE
    	UPDATE tests SET active=0 WHERE id=NEW.id_test;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteTextQ` AFTER DELETE ON `questions` FOR EACH ROW BEGIN
	DELETE FROM text WHERE id_text=OLD.id_text;
    DELETE FROM variants WHERE id_question=OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `result_type`
--

DROP TABLE IF EXISTS `result_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `text` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result_type`
--

LOCK TABLES `result_type` WRITE;
/*!40000 ALTER TABLE `result_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `result_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_course`
--

DROP TABLE IF EXISTS `teacher_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_course` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_teacher` bigint(20) unsigned NOT NULL,
  `id_course` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_courses_tc` (`id_course`),
  KEY `fkey_teachers_tc` (`id_teacher`),
  CONSTRAINT `fkey_courses_tc` FOREIGN KEY (`id_course`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkey_teachers_tc` FOREIGN KEY (`id_teacher`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_course`
--

LOCK TABLES `teacher_course` WRITE;
/*!40000 ALTER TABLE `teacher_course` DISABLE KEYS */;
INSERT INTO `teacher_course` (`id`, `id_teacher`, `id_course`) VALUES (3,21,8);
INSERT INTO `teacher_course` (`id`, `id_teacher`, `id_course`) VALUES (4,22,8);
INSERT INTO `teacher_course` (`id`, `id_teacher`, `id_course`) VALUES (5,21,9);
/*!40000 ALTER TABLE `teacher_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_history`
--

DROP TABLE IF EXISTS `test_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `data_start` datetime NOT NULL,
  `data_end` datetime NOT NULL,
  `time_limit` int(11) NOT NULL,
  `question_count` int(11) NOT NULL,
  `threshold` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_users_th` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_history`
--

LOCK TABLES `test_history` WRITE;
/*!40000 ALTER TABLE `test_history` DISABLE KEYS */;
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (6,23,'Тест по курсу 1','2018-08-24 11:06:17','2018-08-24 11:06:32',60,5,4,4);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (7,23,'Тест по курсу 1','2018-08-24 11:41:07','2018-08-24 11:41:24',60,5,4,5);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (8,23,'заглушка','2018-08-24 13:10:14','2018-08-24 13:10:20',10,3,2,3);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (9,23,'заглушка','2018-08-24 13:10:41','2018-08-24 13:10:48',10,3,2,2);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (10,23,'заглушка','2018-08-24 13:10:52','2018-08-24 13:10:58',10,3,2,0);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (11,23,'Тест по курсу 1','2018-08-24 13:25:31','2018-08-24 13:25:41',60,5,4,5);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (12,23,'Тест по курсу 1','2018-08-24 13:26:32','2018-08-24 13:26:41',60,5,4,5);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (13,23,'заглушка','2018-08-24 13:27:44','2018-08-24 13:27:51',10,3,2,3);
INSERT INTO `test_history` (`id`, `user_id`, `name`, `data_start`, `data_end`, `time_limit`, `question_count`, `threshold`, `answers`) VALUES (14,23,'Тест по курсу 1','2018-08-24 14:16:34','2018-08-24 14:17:08',60,5,4,5);
/*!40000 ALTER TABLE `test_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteHistory` AFTER DELETE ON `test_history` FOR EACH ROW DELETE FROM test_history_questions WHERE id_history=OLD.id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test_history_questions`
--

DROP TABLE IF EXISTS `test_history_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_history_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_history` bigint(20) unsigned NOT NULL,
  `number` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkey_history_t` (`id_history`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_history_questions`
--

LOCK TABLES `test_history_questions` WRITE;
/*!40000 ALTER TABLE `test_history_questions` DISABLE KEYS */;
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (26,6,1,'<p>Какой простейший объект визуального дизайна?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (27,6,2,'<p>Где зародился предшественник современного письма?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (28,6,3,'<p>Где берет свое начало дизайн?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (29,6,4,'<p>Выберите верные утверждения:</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (30,6,5,'<p>Где была изобретена бумага</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (31,7,1,'<p>Какой простейший объект визуального дизайна?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (32,7,2,'<p>Где зародился предшественник современного письма?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (33,7,3,'<p>Где берет свое начало дизайн?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (34,7,4,'<p>Выберите верные утверждения:</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (35,7,5,'<p>Где была изобретена бумага</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (36,8,1,'<p>Введите текст вопроса 2</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (37,8,2,'<p>Введите текст вопроса 3</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (38,8,3,'<p>Введите текст вопроса 1</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (39,9,1,'<p>Введите текст вопроса 3</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (40,9,2,'<p>Введите текст вопроса 2</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (41,9,3,'<p>Введите текст вопроса 1</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (42,10,1,'<p>Введите текст вопроса 3</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (43,10,2,'<p>Введите текст вопроса 2</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (44,10,3,'<p>Введите текст вопроса 1</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (45,11,1,'<p>Какой простейший объект визуального дизайна?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (46,11,2,'<p>Где берет свое начало дизайн?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (47,11,3,'<p>Где была изобретена бумага</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (48,11,4,'<p>Где зародился предшественник современного письма?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (49,11,5,'<p>Выберите верные утверждения:</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (50,12,1,'<p>Какой простейший объект визуального дизайна?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (51,12,2,'<p>Где зародился предшественник современного письма?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (52,12,3,'<p>Где берет свое начало дизайн?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (53,12,4,'<p>Выберите верные утверждения:</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (54,12,5,'<p>Где была изобретена бумага</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (55,13,1,'<p>Введите текст вопроса 3</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (56,13,2,'<p>Введите текст вопроса 2</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (57,13,3,'<p>Введите текст вопроса 1</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (58,14,1,'<p>Какой простейший объект визуального дизайна?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (59,14,2,'<p>Где зародился предшественник современного письма?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (60,14,3,'<p>Где берет свое начало дизайн?</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (61,14,4,'<p>Выберите верные утверждения:</p>\n');
INSERT INTO `test_history_questions` (`id`, `id_history`, `number`, `text`) VALUES (62,14,5,'<p>Где была изобретена бумага</p>\n');
/*!40000 ALTER TABLE `test_history_questions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteVariantsH` AFTER DELETE ON `test_history_questions` FOR EACH ROW DELETE FROM test_history_variants WHERE id_question=OLD.id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test_history_variants`
--

DROP TABLE IF EXISTS `test_history_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_history_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_question` int(11) NOT NULL,
  `text` text NOT NULL,
  `number` int(11) NOT NULL,
  `isright` tinyint(1) NOT NULL,
  `answer` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_history_variants`
--

LOCK TABLES `test_history_variants` WRITE;
/*!40000 ALTER TABLE `test_history_variants` DISABLE KEYS */;
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (81,26,'<p>Точка</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (82,26,'<p>Линия</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (83,26,'<p>Круг</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (84,27,'<p>В Византии</p>\n',1,0,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (85,27,'<p>В Греции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (86,27,'<p>В Древнем Египте</p>\n',3,1,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (87,28,'<p>В Германии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (88,28,'<p>Во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (89,28,'<p>В Англии</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (90,29,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (91,29,'<p>Дизайн зародился во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (92,29,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (93,29,'<p>В компьютерном дизайне используется только растровая графика</p>\n',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (94,30,'<p>В Индии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (95,30,'<p>В Японии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (96,30,'<p>В Китае</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (97,31,'<p>Линия</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (98,31,'<p>Точка</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (99,31,'<p>Круг</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (100,32,'<p>В Греции</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (101,32,'<p>В Византии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (102,32,'<p>В Древнем Египте</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (103,33,'<p>В Германии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (104,33,'<p>Во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (105,33,'<p>В Англии</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (106,34,'<p>В компьютерном дизайне используется только растровая графика</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (107,34,'<p>Дизайн зародился во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (108,34,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (109,34,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n',4,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (110,35,'<p>В Индии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (111,35,'<p>В Японии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (112,35,'<p>В Китае</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (113,36,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (114,36,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (115,36,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (116,36,'<p>Введите текст варианта t</p>\n',4,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (117,37,'Введите текст варианта',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (118,37,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (119,37,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (120,37,'<p>Введите текст варианта t</p>\n',4,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (121,38,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (122,38,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (123,38,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (124,39,'Введите текст варианта',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (125,39,'Введите текст варианта',2,0,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (126,39,'<p>Введите текст варианта t</p>\n',3,1,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (127,39,'Введите текст варианта',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (128,40,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (129,40,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (130,40,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (131,40,'<p>Введите текст варианта t</p>\n',4,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (132,41,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (133,41,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (134,41,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (135,42,'Введите текст варианта',1,0,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (136,42,'<p>Введите текст варианта t</p>\n',2,1,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (137,42,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (138,42,'Введите текст варианта',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (139,43,'Введите текст варианта',1,0,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (140,43,'<p>Введите текст варианта t</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (141,43,'<p>Введите текст варианта t</p>\n',3,1,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (142,43,'Введите текст варианта',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (143,44,'Введите текст варианта',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (144,44,'Введите текст варианта',2,0,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (145,44,'<p>Введите текст варианта t</p>\n',3,1,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (146,45,'<p>Линия</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (147,45,'<p>Точка</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (148,45,'<p>Круг</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (149,46,'<p>В Германии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (150,46,'<p>Во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (151,46,'<p>В Англии</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (152,47,'<p>В Китае</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (153,47,'<p>В Индии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (154,47,'<p>В Японии</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (155,48,'<p>В Древнем Египте</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (156,48,'<p>В Греции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (157,48,'<p>В Византии</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (158,49,'<p>В компьютерном дизайне используется только растровая графика</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (159,49,'<p>Дизайн зародился во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (160,49,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (161,49,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n',4,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (162,50,'<p>Круг</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (163,50,'<p>Линия</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (164,50,'<p>Точка</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (165,51,'<p>В Византии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (166,51,'<p>В Древнем Египте</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (167,51,'<p>В Греции</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (168,52,'<p>В Германии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (169,52,'<p>В Англии</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (170,52,'<p>Во Франции</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (171,53,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (172,53,'<p>В компьютерном дизайне используется только растровая графика</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (173,53,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (174,53,'<p>Дизайн зародился во Франции</p>\n',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (175,54,'<p>В Индии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (176,54,'<p>В Японии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (177,54,'<p>В Китае</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (178,55,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (179,55,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (180,55,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (181,55,'Введите текст варианта',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (182,56,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (183,56,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (184,56,'<p>Введите текст варианта t</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (185,56,'Введите текст варианта',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (186,57,'<p>Введите текст варианта t</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (187,57,'Введите текст варианта',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (188,57,'Введите текст варианта',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (189,58,'<p>Точка</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (190,58,'<p>Линия</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (191,58,'<p>Круг</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (192,59,'<p>В Византии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (193,59,'<p>В Древнем Египте</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (194,59,'<p>В Греции</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (195,60,'<p>В Германии</p>\n',1,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (196,60,'<p>В Англии</p>\n',2,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (197,60,'<p>Во Франции</p>\n',3,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (198,61,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (199,61,'<p>Дизайн зародился во Франции</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (200,61,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n',3,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (201,61,'<p>В компьютерном дизайне используется только растровая графика</p>\n',4,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (202,62,'<p>В Китае</p>\n',1,1,1);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (203,62,'<p>В Японии</p>\n',2,0,0);
INSERT INTO `test_history_variants` (`id`, `id_question`, `text`, `number`, `isright`, `answer`) VALUES (204,62,'<p>В Индии</p>\n',3,0,0);
/*!40000 ALTER TABLE `test_history_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_session_temp`
--

DROP TABLE IF EXISTS `test_session_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_session_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `try_counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_session_temp`
--

LOCK TABLES `test_session_temp` WRITE;
/*!40000 ALTER TABLE `test_session_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_session_temp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteSession` AFTER DELETE ON `test_session_temp` FOR EACH ROW BEGIN
	DELETE FROM gen_questions_temp WHERE id_gen_session=OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `id_text` bigint(20) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `mix_q` tinyint(1) NOT NULL DEFAULT '0',
  `mix_var` tinyint(1) NOT NULL DEFAULT '0',
  `for_course_id` bigint(20) unsigned DEFAULT NULL,
  `reload` tinyint(1) NOT NULL DEFAULT '0',
  `reload_try` int(11) NOT NULL DEFAULT '0',
  `can_pass` tinyint(1) NOT NULL DEFAULT '1',
  `display_q` int(11) DEFAULT '1',
  `threshold` int(11) NOT NULL DEFAULT '1',
  `minute_on_pass` int(11) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `fkey_courses_t` (`for_course_id`),
  KEY `fkey_texts_t` (`id_text`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` (`id`, `name`, `id_text`, `active`, `mix_q`, `mix_var`, `for_course_id`, `reload`, `reload_try`, `can_pass`, `display_q`, `threshold`, `minute_on_pass`) VALUES (14,'Тест по курсу 1',0,1,0,0,8,0,0,1,5,4,60);
INSERT INTO `tests` (`id`, `name`, `id_text`, `active`, `mix_q`, `mix_var`, `for_course_id`, `reload`, `reload_try`, `can_pass`, `display_q`, `threshold`, `minute_on_pass`) VALUES (15,'заглушка',0,1,1,1,9,0,0,1,3,2,10);
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteCuratorTest` AFTER DELETE ON `tests` FOR EACH ROW BEGIN
	DELETE FROM curator_test WHERE id_test=OLD.id;
    DELETE FROM questions WHERE id_test=OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `id_text` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `text` mediumtext,
  `formatting` text NOT NULL,
  PRIMARY KEY (`id_text`),
  UNIQUE KEY `id_text` (`id_text`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (47,'<p>Компьюетный дизайн позволяет проводить дизайнерские проекты на качественном новом этапе. Построение чертежа, пространственной модели, наглядного изображения, схемы, любые расчеты &ndash; любой из этих этапов может быть произведен компьютерной программой.</p>\n\n<p>При создании архитектурных проектов, не обойтись без программ &ndash; AutoCAD, 3D Studio Max, ArchiCAD, Architectural Desktop.</p>\n\n<p>Механики будут использовать &ndash; Desctop, Inventor, Solidworcs.</p>\n\n<p>Любое полиграфическое издание не обойдет версии программы InDesign.</p>\n\n<p>Какой художник, или фотограф, работающий в самых разных сферах, от создания заставки для телеканала, до отрисовки фирменного логотипа или визитки нефтяной компании, обойдется без Adobe Photoshop или CorelDraw.</p>\n\n<p>Могли ли мечтать пионеры-дизайнеры начала 20в, что любой чертеж можно будет:<br />\nмгновенно редактировать;<br />\nперенести;<br />\nсканировать;<br />\nудалить, и тут же вновь возобновить;<br />\nизменить или заменить формат;<br />\nстроить изображения в истинных размерах;<br />\nхранить чертежи, модели, проекты в электронных библиотеках, умещающихся на компьютерном столе;</p>\n\n<p>Компьютерный дизайн открыл совершенно новые перспективы при моделировании самых разных объектов от автомобиля до картины или кинокартины.</p>\n\n<p>С появлением 3D технологий любая модель может быть создана в 3-х мерном пространстве и затем наглядно, с фотореалистичной достоверностью, визуализирована, причем с воспроизведением:<br />\nматериалов;<br />\nтекстуры;<br />\nфона и ландшафта;<br />\nсвета и тени;</p>\n\n<p>Компьютерный дизайн сформируют:<br />\nперспективу;<br />\nкомпозицию;<br />\nпрезентацию&hellip;</p>\n\n<p>На основе созданной модели, компьютерные программы выстроят: проекции, разрезы, сечения, линии контура, другие необходимые чертежи.</p>\n\n<p>Фотореалистичная визуализация дает возможность показать клиенту виртуально готовый объект, открывая поле для корректировки проекта на подготовительной стадии, и тем самым снимает многие головные боли как у заказчика, так и у исполнителя.</p>\n\n<p>Естественно, что для того чтобы применять компьютерный дизайн на практике, современный дизайнер должен научиться пользоваться данными компьютерными программами, или дизайн-студия должна уметь организовать свой производственный цикл таким образом, чтобы в штате были компьютерные специалисты, позволяющие воплотить дизайн-проект. Например, как вариант, дизайнерские тройки &ndash; дизайнер-рисовальщик, создатель модели в 3D, создатель чертежей.</p>\n\n<p>Сегодня компьютерному дизайну подвластно многое, от монтировки Web-страниц и сайтов до создания проектов интерьеров, ландшафтного дизайна или новой модели кофемолки.</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (117,'<div class=\"ng-binding\">\n<p>Дизайн &ndash; берет свое начало в Италии. Уже позднее похожее понятие &quot;design&quot;, формируется в Англии, которое уже прижилось и данный термин используется по настоящее время. На русский язык термин &quot;design&quot;, переводится как: узор, чертеж или проектировать и конструировать.</p>\n\n<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования. Дизайн развивается не только на проектировании, но и захватывает особенности социума и эстетические качества. То есть проектирует и создает объекты комфортные для предметной среды человека, например, социально культурной, общественной, производственной и жилой.</p>\n\n<p>В настоящее время дизайн &ndash; это совокупность нескольких проектных деятельностей, объединяя в себе как технические, так и гуманитарные знания, закрепляя все художественным мышлением, далее формируя на производстве объект размышления.</p>\n\n<p>Главная задача дизайна и дизайнерской мысли &ndash; это, быть в одной плоскости с техническими и естественными знаниями. Все знания в этих сферах сливать воедино и брать за основу художественное, обзорное мышление.</p>\n\n<p><strong>1. Определение и сущность дизайна</strong></p>\n\n<p>Дизайн - это знание, объединяющее в себе проектное мышление и творчество, мыслью которого является определение оптимальных характеристик промышленных объектов. Проектирование предметов, в которых форма соответствует их назначению, функциональна, экономична, удобна и при этом еще и красива.</p>\n\n<p>Характерная черта дизайна заключается в том что, каждый объект рассматривается не только со стороны пользы, а должно пройти критику во всех сферах. То есть пройти путь, от формирования идеи и заканчивая производством.</p>\n\n<p>Дизайнер ищет наилучшую форму каждого элемента, учитывая, как она зависит от рабочего назначения изделия и связей с человеком. Слаженность и контрастность как универсальные единые средства искусства являются образующими и в дизайне.</p>\n\n<p>Художественное проектирование среды - не просто создание вещей, конструируя определенные функциональные и эстетические свойства, особенности вещам и предметной среде, художник &laquo;создает&raquo; человека, который будет пользоваться этими вещами, и жить в этой среде. Отсюда следует, важная значимость проектировщика, установить наиболее важные аспекты с целью производства этого предмета.</p>\n\n<p>Дизайн открывает нам свободные возможности эстетических идей, новые красоты, значимость, величину и глубину человека, его воображение. Дизайн - самобытный по своей природе, выявил и объединил множество сред воедино. Внес корректировку в создание предметного мира человека.</p>\n\n<p>Профессионализм дизайнера и дизайнерской мысли имеет огромную часть в конструировании, а не только инженера &ndash; проектировщика, в идеале специалист все эти профессии должен совместить для получения идеального состояния и дальнейшей успешной работы в проектировании.</p>\n\n<p>Дизайнерская мысль проявляет положительное влияние на социальную атмосферу, формирует эстетический вкус, творческое мышление, возможна, вдохновить на положительные действия, проявляет работоспособность, формирует комфортность, повышает жизненный тонус, проявление уважение к среде существования, дает более понятный вид для восприимчивости человека.</p>\n\n<p>Дизайн, не так уж прост, как кажется на первый взгляд, дизайн это совокупность декоративной и графической деятельности. Так же в сферах управления можно встретить, например, где ведутся научно-исследовательские исследования, инженеры, проектировщики, технологи - практически всегда сталкиваются с необходимостью рисовать, так нагляднее можно изобразить, для восприимчивости. Данное действие - рисование, не ограничивает человека, тем самым дает свободу мышления, способность чувствовать гармонию мира раскрывают новые возможности восприятия мира и применения получаемых результатов в различных областях деятельности.</p>\n\n<p><strong>2. Развитие дизайна</strong></p>\n\n<p>В наше время общество испытывает период вмешательства рыночных отношений, при которых эстетическое качество предмета обязано соответствовать его значению и вытекать из него. Современные формы взаимодействия архитектуры и дизайна возникают из общих задач архитектурного проектирования и из условий строительного и промышленного производства. История дизайна неразрывно связана с эволюцией предметного окружения человека, историей развития техники и технологии.</p>\n\n<p>Технический прогресс все больше входит в жизнь людей и начинает влиять на формирование их мировоззрение. К концу 18 века стало ясно, что без освоения новых технических форм и созданных промышленным способом вещей невозможен дальнейший прогресс. Однако стало заметное снижение качества индустриальных форм по сравнению с изделиями традиционного ремесленного производства, а также их инородность в окружающей среде. В середине 19 века понятия &laquo;искусство&raquo; и &laquo;художественное творчество&raquo; начинают употребляться по отношению к проектированию рядовых сооружений, созданию бытовых вещей и одежды.</p>\n\n<p>Задача дизайна - план соответствия прелести и выгоды, фактор - сокращение эстетического степени в ходе многочисленного изготовления и пользования, модель &ndash; стилизация эстетического, основа - своеобразие элемента, отвечающая общепризнанным меркам и условиям стилизации.</p>\n\n<p>Развитие нашего государства основало нам колоссальное число креативного наследства и креативных мыслей с целью осуществления. Однако с целью процветания нашей страны нужно совершенствовать общественно-цивилизованную область. В данной взаимосвязи отечественный дизайн содержит более немаловажное роль, несмотря на то в настоящее время уступает западным.</p>\n\n<p><strong>3. Компьютерный дизайн</strong></p>\n\n<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды. Компьютерный (графический) дизайн вносит инновационный вклад в развитие социально-экономической и культурной сфер жизни, способствуя созданию визуального ландшафта современности.</p>\n\n<p><strong>Современный компьютерный дизайн</strong> позволяет проводить дизайнерские проекты на качественном новом этапе. Построение чертежа, пространственной модели, наглядного изображения, схемы, любые расчеты &ndash; любой из этих этапов может быть произведен компьютерной программой.</p>\n\n<p>Общепринятое использование компьютерного дизайна включает в себя журналы, реклама, упаковка и веб-дизайн.</p>\n\n<p>Композиция &mdash; одно из важнейших свойств компьютерного дизайна, в особенности при использовании предварительных материалов или иных элементов.</p>\n\n<ol>\n	<li>\n	<p>книжные макеты и иллюстрации;</p>\n	</li>\n	<li>\n	<p>рекламные и информационные плакаты;</p>\n	</li>\n	<li>\n	<p>графическое решение открыток и почтовых марок;</p>\n	</li>\n	<li>\n	<p>корпоративный стиль компании и его основной элемент &mdash; логотип;</p>\n	</li>\n	<li>\n	<p>рекламная полиграфическая продукция;</p>\n	</li>\n	<li>\n	<p>сувенирная продукция;</p>\n	</li>\n	<li>\n	<p>интернет-сайты.</p>\n	</li>\n</ol>\n\n<p>Графический дизайн можно разделить на два типа дизайна &mdash; компьютерный дизайн предметного мира и компьютерный виртуальный дизайн.</p>\n\n<p><strong>4 Точка как объект дизайна.</strong></p>\n\n<p>Точка служит в качестве фокуса изображения, выделяя важную информацию или привлекая к ней внимание. Точка &ndash; самый простейший объект визуального дизайна.</p>\n\n<p>Возьмем, простейшую ситуацию, когда на листе бумаги изображена только одна единственная точка. На подсознательном уровне, наш мозг пытается привязать ее к чему- то. Когда же мы видим две и более точки на том же самом листе бумаги мы пытаемся их объединить и создать что-то более объемное, чем есть на самом деле. Это невольное соединение точек на подсознательном уровне, называется группировкой или гештальтом (gestalt).</p>\n\n<p>Несколько точек в сочетании могут создавать более сложные объекты или идеи. В пример возьмем звездное небо, мы мысленно уже объединяем звезды, что бы сформировать какую-то фигуру для более точного восприятия.</p>\n\n<p>Гештальт - основной инструмент дизайнера или художника, который он использует для построения связанной композиции.</p>\n\n<p><strong>5. Линия как объект дизайна.</strong></p>\n\n<p>Линия - это черта, создаваемая при помощи передвижения точки в сторону, и соответственно она имеет определенное психологическое значение в зависимости от ее направления, толщины и изменения ее направлений и толщины. Линии можно объединять с другими линиями тем, самым создавая текстуры и узоры. Это очень часто используется в гравюрах, а также в рисунках тушью или карандашами, использование комбинаций линий позволяет создавать формы и фигуры, которые являются последующими элементами дизайна.</p>\n\n<p>Сочетание горизонтальных и вертикальных линий передает ощущение уверенности, прочности. Прямоугольные формы кажутся стабильными. Эта стабильность создает чувство постоянности, надежности и безопасности.</p>\n\n<p>Глубокие, острые кривые, с другой стороны, предполагают смятение, волнение, и даже безумие. Мы их можем встретить, например, в хаотично разбросанных вещах, смятого листа бумаги.</p>\n\n<p>Кривые линии могут иметь другие значения. Мягкие, неглубокие кривые предполагают комфорт, безопасность, понятность для нашего мышления, следовательно - расслабление.</p>\n\n<p><strong>6. Объем и форма. </strong></p>\n\n<p>Формы и фигуры - это области или массы, которые определяют объекты в пространстве. Форма или фигура подразумевают пространство объединенное контуром.</p>\n\n<p>Существует два способа классификации форм и фигур. Формы и фигуры бывают двухмерными, либо трехмерными. Двухмерная форма должна иметь ширину и длину. Она также может служить иллюзорным изображением трехмерных объектов. Каждая фигура имеет высоту и толщину.</p>\n\n<p>Формы и фигуры могут иметь органический и геометрический вид. Органические формы, такие например, как холмы, покрытые снегом ассиметричны, следовательно, имеют не правильную форму. Органические формы встречаются в природе, где нет идеальных форм.</p>\n\n<p>Геометрические же формы - это формы, которые соответствуют геометрическим фигурам, это например: треугольники, квадраты, сферы и так далее, фигуры которые имеют правильные формы.</p>\n\n<p>Двухмерная форма - основа организации рисунка или композиции в изобразительном искусстве, фотографии и проч. Форма создается несколькими способами. Она может быть определена линией. Линия, либо нарисованная явно, либо только угадываемая, создает контуры формы.</p>\n\n<p>Значительная яркость объекта тоже можно реализовать в форму. Сильная концентрация изображения может повлиять на восприимчивость и послужить для создания иллюзии контура. Изменение яркости, появление тени, тоже создает иллюзию объема и формы.</p>\n\n<p>Фигуры и формы можно классифицировать: отрицательные и положительные. Следовательно, для двумерной графики объекты будут являться положительными формами, а фон будет отрицательный. Для начинающих художников и дизайнеров очень важным является умение эффективно использовать отрицательное пространство.</p>\n\n<p><strong>7. Пространство и объем</strong></p>\n\n<p>Пространство можно определить как место или площадь на которой происходит действие, где непосредственно находится для картина. Пространство разделяется на трехмерное пространство и двумерное пространство. Пространство трехмерное уже определяет объект на арене, имеет объем и глубину.</p>\n\n<p>В дизайне существует термин как наложение. Данный эффект наложение одного объекта на другой менее значимый для нас. Тем самым создавая вид, что объекты расположены на разных планах и, соответственно, мы воспринимаем одни объекты более близкими к себе, а другие - удаленными.</p>\n\n<p>Кроме своеобразной &laquo;игры&raquo; света и теней можно выделить не менее важный параметр как, расположение объекта в композиции. Это задается введением двух плоскостей, ближней и дальней.</p>\n\n<p><strong>Заключение</strong></p>\n\n<p>Дизайн - гуманитарная дисциплина, объединяющая в себе все знания эстетических и технических сферах, совокупность изменения внешности изделия для создания гармонии как в эстетическом так и техническом равенстве.</p>\n\n<p>История &laquo;российского&raquo; дизайна начинается с XX века, и имеет богатую историю, хотя современный дизайн во многом уступает западному и есть к чему и куда стремиться. Необходимо сейчас уделять данной дисциплине должное внимание и развивать данную сферу.</p>\n\n<p>В свою очередь, хочется заметить, что дизайн, играет весомую значимость в компьютерной графике, в работе было приведено, огромное количество примеров формирования и применения дизайна на уровне производства. Однако, можно заметить, что современный мир, автоматизируется и компьютерная графика становится все популярнее и все больше интересует умы. Где дизайн просто необходим. Именно от дизайна и дизайнерской мысли зависит успех проектов.</p>\n</div>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (118,'<div class=\"ng-binding\">\n<div class=\"entry-content\">\n<p><em>Письменность</em> &mdash; важнейший этап в истории культуры, результат тысячелетних творческих устремлений человеческого общества.<br />\nДва понятия &mdash; рисование и письмо &mdash; тысячелетиями остаются близкими. Греческое слово &laquo;графо&raquo; означает и письмо, и рисование. Картинное письмо &mdash; пиктография &mdash; было начальным этапом в развитии письменности всех народов мира.<br />\n<em>Шрифт</em> &mdash; это совокупность знаков всего алфавита, визуально различных, но единообразно спроектированных. Те шрифты, которые используются сейчас, создавались и совершенствовались в течение тысяч лет, их форма сложилась под влиянием разных факторов. Среди современных компьютерных гарнитур можно встретить стилизации под шрифты всех времен и стилей. Чтобы понять, почему в искусстве шрифта сложились те или иные традиции и правила, рассмотрим происхождение самых популярных видов шрифтов.<br />\nПредшественником нашего современного письма считают письмо Древнего Египта. Египетское иероглифическое письмо восходит к XIV в. до н.э. Из-за необходимости писать быстро из иероглифов образовалось курсивное иероглифическое письмо для обыденных надобностей. Курсив (нем. Kursiv, от средневекового лат. cursivus, буквально &mdash; бегущий) &mdash; бегущее, быстрое письмо. Принято считать египетское иероглифическое письмо (рис. 4.1) родоначальником буквенных алфавитов.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-1.jpg\"><img alt=\"img239-1\" class=\"alignnone size-full wp-image-174\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-1.jpg\" style=\"height:231px; width:717px\" /></a><br />\nУпрощенное начертание иероглифических знаков получило название иератического, или жреческого, письма (рис. 4.2). Из иератического письма постепенно образовалась более простая форма &mdash; демотическое (народное) письмо.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-2.jpg\"><img alt=\"img239-2\" class=\"alignnone size-full wp-image-175\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-2.jpg\" style=\"height:1002px; width:1105px\" /></a><br />\nТак называемое алфавитное письмо (т. е. такой способ записи речи, при котором каждый знак соответствует одному определенному звуку) появилось на Ближнем Востоке около середины II тысячелетия до нашей эры. О его происхождении мало что известно, сохранилось очень мало древнейших алфавитных надписей. Достоверно известно только, что через финикийцев алфавитное письмо перешло к грекам. Финикийский алфавит состоял из 22 согласных и полугласных знаков (рис. 4.3).<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-3.jpg\"><img alt=\"img239-3\" class=\"alignnone size-full wp-image-176\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img239-3.jpg\" style=\"height:520px; width:1118px\" /></a><br />\nГреки преобразовали его в соответствии с требованиями своего языка. Шрифт древнегреческих надписей сильно отличается от современного письма, все линии в нем одинаковой толщины, но при этом надписи не выглядят монотонными благодаря различной высоте букв. Буквы выравнивались не по двум строкам, как сейчас, а по средней линии, а чередование треугольных и округлых элементов делает древнегреческий шрифт энергичным и подвижным. Этот шрифт необычайно прост, построен скупыми четкими линиями равной толщины, которые образуют простые геометрические формы: круг, прямоугольник, дуги, отрезки прямой, соединяемые в различных вариантах. Древнейшие памятники греческих капитальных букв (состоящих из прописных букв) восходят к VIII&mdash;VII вв. до н.э. Только в IV в. до н.э. стало общепринятым греческое капитальное (монументальное) письмо (рис. 4.4). Греческий алфавит явился главным источником алфавита латинского, бытового в Древнем Риме.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img240-1.jpg\"><img alt=\"img240-1\" class=\"alignnone size-full wp-image-177\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img240-1.jpg\" style=\"height:609px; width:997px\" /></a><br />\nОт греческого алфавита (возможно, через посредство этрусского) произошел латинский алфавит.<br />\nВ I &mdash; II вв. н.э. достигает своего совершенства римское капитальное письмо (лат. capitalis &mdash; большой, главный, солидный). Другое название &mdash; маюскул (лат. &mdash; несколько больший). Надпись, выполненная маюскулом, укладывается строго между двумя горизонталями, ни единой черточкой не выходя за пределы образованной им строки. Маюскул &mdash; это шрифт торжественных надписей, высекавшийся на колоннах, триумфальных арках, стенах. Его технология исполнения не является повторением технологии скольжения тростниковой палочки, а является медленным высеканием в каменной плите по заранее намеченному контуру (как правило, кистью, чем объясняется некоторая сложность построения овальных букв).Постепенно буквы стали более правильными и вычерченными, а не написанными. Затем сформировалась совсем новая деталь &mdash; засечка (сериф), а также впервые определились различия в толщине между разными штрихами.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img240-2.jpg\"><img alt=\"img240-2\" class=\"alignnone size-full wp-image-178\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img240-2.jpg\" style=\"height:1180px; width:640px\" /></a><br />\nНаибольшую законченность и совершенство шрифт надписей приобрел к II в. н.э., например шрифт надписи на колонне Трояна (114 г. н. э.). Этот шрифт построен и вырисован, а не свободно написан. В Древнем Риме существовали и рукописные шрифты: это шрифт рустика с его характерными узкими пропорциями, со-хранившийся до XI в. Характерными чертами рустики являются тонкие вертикальные штрихи, причем горизонтальные штрихи выполнялись с сильным нажимом. В целом получается картина сжатого, узкого и высокого письма (рис. 4.6).<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img241-1.jpg\"><img alt=\"img241-1\" class=\"alignnone size-full wp-image-180\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img241-1.jpg\" style=\"height:1915px; width:1152px\" /></a><br />\nДругим вариантом рукописного латинского шрифта был курсив. В курсиве буквы упрощались, соединялись друг с другом, утрачивали некоторые детали. Курсивом&nbsp;писали, например, на покрытых воском деревянных дощечках.<br />\nВ конце I в. под влиянием Востока в римскую архитектуру стал все более проникать стиль круглых сводов, этот принцип округления стал все более проникать в письмо. Появился новый стиль &mdash; унциальное письмо. Удобство и быстрота начертания достигались в нем тем, что штрих принимал дугообразную форму, а углы округлялись. Полного своего развития шрифт достиг в IV в. и применялся до VIII в. (рис. 4.7).&nbsp;Он интересен тем, что под влиянием курсива в некоторых знаках унциала появились выносные, т. е. выходящие за линию строки, элементы. Еще не очень активные, они тем не менее придают этому письму более богатый и сложный ритм. В ранних греческих рукописях на папирусе, а затем и на пергаменте, тоже сложился стиль письма с четко разделенными пластичными знаками. Это так называемый греческий унциал, или устав, просуществовавший в Византии вплоть до IX в. Именно во второй половине IX в. монахи Кирилл и Мефодий создают на основе греческой (что неудивительно, ведь они получили образование в греческом монастыре) славянскую азбуку, которая распространилась на Руси в X в. и вытеснила древнерусскую письменность &mdash; глаголицу. Вместе с кириллицей в древнерусскую письменность пришел греческий устав.<br />\nПолуунциал &mdash; переход от прописных букв к строчным. Появляются связи между буквами. Полуунциал &mdash; новый шаг в усвоении беглости курсива при сохранении ясности письма (рис. 4.8).</p>\n\n<p>В VIII &mdash; IX вв. сложился новый тип латинского письма, в нем слова разделены хорошо заметными пробелами (а не точкой, как в древнеримских надписях), а многочисленные выносные элементы облегчают чтение. Шрифт такого типа, с выносными элементами, выходящими за край строки, называется минускулом (лат. minusculus &mdash; очень маленький, строчный). Первый минускул появился во время правления французской королевской династии Каролингов, поэтому его называют каролингским минускулом. От каролингского минускула ведут происхождение строчные буквы современного латинского алфавита.&nbsp;(рис. 4.9). В позднем королевском минускуле (XI в.) появляются изменения: усиливается вертикальный штрих, уплотняется написание букв, округления как бы надламываются. Эти изменения означают переход к готическому шрифту, распространившемуся по всей Европе. На протяжении своего существования в различных странах готическое письмо приобрело особые местные черты и названия (рис. 4.10): к крайней готике относятся текстура и ротунда (круглоготическое итальянское письмо), к поздней готике &mdash; швабский шрифт (XV в.) и фрактура (XVII в.).<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img241-2.jpg\"><img alt=\"img241-2\" class=\"alignnone size-full wp-image-181\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img241-2.jpg\" style=\"height:1579px; width:1163px\" /></a><br />\nВ готическом письме буквы сближены и сильно вытянуты вверх. Вероятно, первоначально сужение букв было вызвано стремлением экономить место (пергамент был очень дорогим материалом), но оказалось, что такой стиль шрифта отражает вкусы позднего средневековья и прекрасно сочетается с готическим стилем в архитектуре. Готический шрифт господствовал в европейской рукописной книге вплоть до XV в., перешел из нее в первые печатные издания, а в Германии поздний вариант этого шрифта &mdash; фрактура &mdash; широко употреблялся вплоть до первой половины XX в. Сейчас также популярны готические шрифты, особенно в молодежной среде, но эти шрифты в основном &mdash; стилизации под итальянский стиль готического шрифта, так называемую ротунду, и, разумеется, являются только стилизациями, в их основе лежит современное начертание букв алфавита.<br />\nСтрожайший стиль готического письма разработали в XV в. испанцы. В качестве пера употребляли колем &mdash; ширококонечно очищенный тростник, замененный в 624 г. птичьим пером. Оба вида пера соответствуют металлическому ширококонечному перу нашего времени, но эластичнее его.<br />\nВ русской рукописной книге с конца XIV в. устав сменяется более легким и подвижным полууставом. Вероятно его выработали профессиональные переписчики, работавшие на заказ, чтобы ускорить процесс и сделать текст более компактным. В полууставе много надстрочных знаков, обозначающих сокращения, а также ударения и придыхания. При этом каждая буква в полууставе пишется отдельно, текст легко читается. Примерно в это же время в русских книгах появляется особый вид декоративного письма &mdash; вязь. Особое распространение вязь получает в XVI&mdash;XVIII вв. Вязь служила только для украшения рукописи и применялась в заголовках, первой строке текста или его раздела. Современные стилизации используют некоторые элементы полуустава и вязи в рисунке букв.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img229-1.jpg\"><img alt=\"img229-1\" class=\"alignnone size-full wp-image-188\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img229-1.jpg\" style=\"height:908px; width:1311px\" /></a><br />\nВосточные шрифты и орнаменты выполнялись кистями. В качестве карандаша употреблялись свинцовые и серебряные палочки. Графитный карандаш впервые изготовил француз Конте в 1790 г. Железное перо начал использовать Нюрнбергский каллиграф Нойдерфер в 1544 г. Широкое применение металлических перьев началось только в середине XVII в. после изобретения стального пера.<br />\nВ эпоху Возрождения (XV&mdash;XVI вв.) возрос интерес к античной культуре во всех ее проявлениях. Переписывая античные тексты, писцы старались копировать и сам шрифт этих текстов, связывая его с античностью, и даже называли его антиква. Но копируемые рукописи были, как правило, более позднего времени, их переписывали не в античности, а в эпоху Каролингов, и входящий в употребление шрифт следовало бы называть новокаролингским, или гуманистическим (XV в.). Новое письмо &mdash; антиква (лат. antiquus &mdash; старый, древний), называемое также латинским письмом, переняло все новшества и положительные качества, достоинства. Местами изготовления зрелых в художественном отношении рукописей, выполненных антиквой в период расцвета Ренессанса, считаются города верхней Италии во главе с Флоренцией и Болоньей.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img242-11.jpg\"><img alt=\"img242-1\" class=\"alignnone size-full wp-image-192\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img242-11.jpg\" style=\"width:600px\" /></a><a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img230-1.jpg\"><img alt=\"img230-1\" class=\"alignnone size-large wp-image-194\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img230-1-1024x943.jpg\" style=\"height:829px; width:900px\" /></a><br />\nОбратите внимание, рисунок заглавных букв отличается от строчных &mdash; заглавные буквы в латинских шрифтах такого типа происходят от древнеримских надписей, а строчные &mdash; потомки каролингского минускула. Вслед за книжным вариантом гуманистической антиквы появляется ее слитный, слегка наклонный вариант, употреблявшийся в письмах и документах, так называемый гуманистический курсив. Впоследствии именно это письмо стало основой как европейской каллиграфии, так и книжного курсива.<br />\nВ середине XV в. наступает новая эпоха в развитии шрифта. Около 1440 г. Иоганн Гуттенберг изобрел книгопечатание. Для своих книг он использовал один из вариантов распространенного тогда в Германии готического шрифта. Примечательно, что изобретатель книгопечатания добивался, чтобы его книги выглядели как рукописные: он использовал несколько вариантов написания каждой буквы на странице, применял так называемые лигатуры (слитное написание соседних букв), а для нарядных инициалов оставлял свободное место &mdash; их потом рисовали от руки. Книги, напечатанные Гуттенбергом, отличаются совершенством печати и красотой.<br />\nВозрос интерес к теоретическим проблемам шрифта. Римский капитальный шрифт был в эпоху Возрождения одним из прекрас&shy;ных проявлений античности. Шел поиск в пропорциях, в зако&shy;номерностях соотношения отдельных частей, в точности постро&shy;ения шрифтов. Появляются трактаты о построении шрифта. Лука&nbsp;Возрос интерес к теоретическим проблемам шрифта. Римский капитальный шрифт был в эпоху Возрождения одним из прекрас&shy;ных проявлений античности. Шел поиск в пропорциях, в зако&shy;номерностях соотношения отдельных частей, в точности постро&shy;ения шрифтов. Появляются трактаты о построении шрифта. Лука Пачоли в 1509 г. предложил построение буквы на основе квадрата, его диагоналей и вписанной в него окружности. Все дуги образованы точным движением циркуля. Альберт Дюрер использовал квадрат, разделенный на 10 час-тей. Он отказался от использования окружности и диагоналей. Некоторые детали он предлагал рисовать от руки (книга Дюрера &laquo;Наставление к измерению циркулем и угольником&hellip;&raquo;, 1525 г.). Дюрер сконструировал свой шрифт для архитекторов.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img242-2.jpg\"><img alt=\"img242-2\" class=\"alignnone size-large wp-image-195\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img242-2-660x1024.jpg\" style=\"height:1024px; width:660px\" /></a><br />\nВ начале XVI в. в Италии, а затем и в других странах появляются учебники каллиграфии. Каллиграфия быстро стала самостоятельным видом искусства, ее появление совпало со сменой стиля в архитектуре и изобразительном искусстве: на смену стилю эпохи Возрождения пришел стиль барокко. Именно в каллиграфии проявился стиль барокко в шрифтах, книги по-прежнему набирались антиквой. Современным стилизациям под рукописные, каллиграфические шрифты XVI &mdash; XVIII вв. (рис. 2.3) далеко до оригинала, ведь кажущаяся легкость и свобода в украшении букв артистическими росчерками достигалась годами обучения, а также использованием специальным образом заточенных гусиных перьев.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img231-1.jpg\"><img alt=\"img231-1\" class=\"alignnone size-large wp-image-197\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img231-1-1024x492.jpg\" style=\"height:432px; width:900px\" /></a><br />\nИзвестный типограф Альд Мануций разработал первый типографский курсив. Раньше курсив применялся как основной шрифт, сегодня только для выделений в тексте.<br />\nТип гуманистической антиквы долго оставался господствующим и цельным. В начале XVIII в. антиква становится контра-стнее, плотнее, наклонные оси в округлых формах сменяются вер-тикальными. Шрифт отрешается от свободного начертания, буквы становятся выше и уже, рисунок &mdash; геометричнее. Вырастает контрастность соединительных штрихов. Засечки переходят в шрифт.<br />\nНаиболее характерные формы классической антиквы сложились во второй половине XVIII &mdash; начале XIX вв. в шрифтах Дидо (Франция) и Бодони (Италия). Антиква Дидо представляет собой самый строгий, чистый и торжественный тип классической антиквы.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img243-1.jpg\"><img alt=\"img243-1\" class=\"alignnone size-full wp-image-198\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img243-1.jpg\" style=\"height:800px; width:601px\" /></a><br />\nЖивописная графика XVIII в. и стиль рококо, вычурный, тяготеющий к криволинейности, способствовали возникновению так называемых живописных шрифтов.<br />\nОгромное количество шрифтов было создано в XIX в. Родился контрастный жирный шрифт Торна. Были созданы такие шрифты, как египетский и его модификации, итальянский. Создавались декоративные, или украшенные, шрифты, которые нередко так орнаментировались, что затруднялось их чтение.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img243-2.jpg\"><img alt=\"img243-2\" class=\"alignnone size-large wp-image-199\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img243-2-661x1024.jpg\" style=\"height:1024px; width:661px\" /></a><br />\nСоздателями славянской азбуки были монахи-проповедники братья Кирилл и Мефодий. С именем Кирилла связана азбука древнерусского письма, получившая название &laquo;кириллицы&raquo;. Впервые была создана азбука с четкой и ясной графикой знаков. В основу было положено греческое унциальное письмо. Новая азбука была распространена по всему государству.<br />\nСтарославянская письменность известна с X в. в двух различных начертаниях: глаголицы и кириллицы. Вначале оба начертания существовали параллельно, но со временем за основу русской письменности была взята кириллица. Древнейшие русские рукописи XI в. были написаны кириллицей, почерком, который получил наименование устав. Одним из лучших образцов уставного письма является &laquo;Остромирово Евангелие&raquo;. Позже устав сменился полууставным письмом.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img244-1.jpg\"><img alt=\"img244-1\" class=\"alignnone size-full wp-image-201\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img244-1.jpg\" style=\"height:800px; width:536px\" /></a><br />\nДостоинство полуустава состояло в скорости написания текста. Уставы и полууставы выполнялись по строго определенному правилу &mdash; уставу, от которого и произошло их название. Постепенно появляется скорописный шрифт &mdash; скоропись, которая использовалась при переписывании книг, составлении деловых бумаг, актов.<br />\nНачиная с XV в. в написании заглавий применялось особое письмо &mdash; вязь. Она представляла собой декоративное письмо, с помощью которого выделялись заглавия в виде непрерывного равномерного орнамента. Лучшие образцы русской вязи сложились в середине XVI в. в Москве при Иване Грозном, а также в Новгороде. Первые книги, напечатанные Иваном Федоровым, славились красиво выполненной вязью, гравированной на дереве. Начиная с XVIII в. искусство оформления книг вязью постепенно стало приходить в упадок.<br />\nВ 1708 г. Петр I ввел в обязательное употребление новый русский гражданский шрифт, представляющий собой синтез традиционных русских и родственных им форм латинского шрифта того времени. По форме, пропорциям и начертанию гражданский шрифт близок к западноевропейской антикве. Главным достоинством нового шрифта являлась удобочитаемость, простота и ясность конструкций букв. Были введены арабские цифры вместо обозначения цифр буквами. Проведенная реформа способствовала распространению грамотности на Руси. Первой книгой гражданской азбуки была книга под названием &laquo;Геометрия славенски землемерие&raquo;, выпущенная Печатным двором в Москве в 1708 г.<br />\nНа протяжении XVIII в. русский шрифт был усовершенствован. Выносные линии укорочены, некоторые ненужные элементы букв убраны. Шрифт стал единым и более строгим по рисунку.</p>\n\n<p>На рубеже 1820 &mdash;1830-х гг. произошла резкая перемена вкуса, в архитектуре главенствует эклектика. В шрифтах на смену конструктивным, ясным, хорошо читабельным шрифтам строгого классицизма пришло разнообразие форм и начертаний. Кроме изменения пропорций и декоративного оформления существовавшей новой антиквы, появляется новый вид шрифта &mdash; брусковый, или египетский. Для этого типа шрифта характерен незначительный контраст между вертикальными и горизонтальными штрихами и такой же толщины засечки, иногда чуть скругленные (рис. а). Брусковый шрифт всячески отделывался и украшался. Разновидностью брускового шрифта принято считать итальянский (Italian, не путайте с английским названием курсива &mdash; Italic), для него характерны маленькая разница между толщиной вертикальных и горизонтальных штрихов и гораздо более широкие засечки, иногда скругленные (рис. б).<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img231-3.jpg\"><img alt=\"img231-3\" class=\"alignnone size-large wp-image-203\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img231-3-1024x629.jpg\" style=\"height:553px; width:900px\" /></a><br />\nРазумеется, фигурные шрифты предназначались не для набора текста, а для заголовков и рекламных объявлений, причем часто каждая строка набиралась шрифтом своего рисунка. Такое разнообразие декоративных форм продолжало развиваться как в западноевропейской, так и в российской культуре вплоть до начала XX в. Характерная для того времени эклектика, т. е. свободное заимствование и произвольное сочетание элементов разных стилей, сказывается и в рисунках шрифтов. В это время начинает бурно развиваться реклама, и она также накладывает отпечаток на шрифты середины XIX в.: складывается характерный стиль газетных и журнальных объявлений, набранных исключительно с целью привлечения внимания, шрифтами разных рисунков и размеров; фасады домов скрыты спорящими друг с другом вывесками.<br />\nВ самом конце XIX в. в архитектуре и изобразительном искусстве появляется новый стиль &mdash; модерн. Этот стиль также проявляется и в шрифтах, они так и называются по названию архитектурного стиля. Для этих шрифтов характерно использование &laquo;текучих&raquo;, плавных линий и необычных начертаний отдельных букв. Часто шрифты составляли единую композицию с графическими орнаментами. Современные версии шрифтов этого стиля представлены на рис.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img232-1.jpg\"><img alt=\"img232-1\" class=\"alignnone size-large wp-image-204\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img232-1-1024x771.jpg\" style=\"height:678px; width:900px\" /></a><br />\nВ это же время (на рубеже XIX&mdash;XX вв.) возникает и противоположное стремление: вернуться в строгие рамки классических традиций и возродить утраченную цельность и красоту старинной книги. В Англии Уильям Моррис, известный художник-декоратор и крупный специалист по средневековому искусству, в 1891 г. основал типографию, для которой сам разработал шрифты и украшения по образцам ранней итальянской книги. Его шрифты близки к гуманистической антикве XV&mdash;XVI вв. и отличаются от большинства современных ему наборных шрифтов подчеркнутой пластичностью. В России к образцам классической книги обратились художники из группы &laquo;Мир искусства&raquo;. На обложках и титульных листах, оформленных такими художниками, как М.Добужинский, Е.Лансере, К. Сомов, Г. Нарбут, свободно варьировались книжные и рукописные шрифты эпохи барокко и классицизма.<br />\nВ 1920-е гг. с возникновением нового архитектурного стиля &mdash; конструктивизма &mdash; появляется новый вид шрифтов. Буквы в этих шрифтах предельно упрощены, утолщения и засечки исчезли. Криволинейные элементы по возможности сводились к прямоугольным. Конструктивисты избегали курсивных начертаний, их композиции часто сами по себе динамичны, строятся по диагонали или вертикали, но сами буквы &mdash; статичны. Такой тип шрифта назвали рубленным, или гротеском. Впоследствии гротески приобрели некоторое разнообразие, появились округленные элементы и даже шрифты, скругленные элементы которых имеют четкую форму круга (рис. а). Для гротесков характерно отсутствие курсивных начертаний, для них обычно используются так называемые наклонные начертания (рис. б).<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img232-2.jpg\"><img alt=\"img232-2\" class=\"alignnone size-large wp-image-205\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img232-2-1024x926.jpg\" style=\"height:814px; width:900px\" /></a><br />\nВ 1930&mdash; 1950-е гг. в европейском (а затем и мировом) искусстве появляется новый стиль &mdash; арт деко. Существенного влияния на шрифтовое искусство он не оказал, но стилизации под характерные шрифты той эпохи встречаются, в том числе среди компьютерных гарнитур.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img233-1.jpg\"><img alt=\"img233-1\" class=\"alignnone size-large wp-image-206\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img233-1-1024x555.jpg\" style=\"height:488px; width:900px\" /></a><br />\nВ советском искусстве, начиная с 1930-х гг., наблюдается определенный возврат к шрифтам типа &laquo;антиква&raquo;. Количество гарнитур, применяемых в это время, ограничивается ГОСТом. В конце 1950-х &mdash; начале 1960-х гг. в советском искусстве вновь начинаются поиски более свободных форм, отражающих личность художника. Художники стремятся передать живое ощущение быстрой, легкой работы, не боясь даже некоторой небрежности.<br />\nНаряду с новыми вариантами привычных шрифтов, начиная с 1960-х гг., создаются шрифты непривычных начертаний. Появление световых табло, а также низкое разрешение первых мониторов и печатных устройств потребовало создания шрифтов, основанных на модулях или использовании стандартных элементов. Быстрое развитие устройств вывода устранило техническую необходимость в создании таких шрифтов, но оказалось, что они обладают определенными эстетическими достоинствами и активно влияют на стиль современного шрифта.<br />\n<a href=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img233-2.jpg\"><img alt=\"img233-2\" class=\"alignnone size-full wp-image-207\" src=\"http://learn.bdfoto.ru/wp-content/uploads/2015/09/img233-2.jpg\" style=\"height:801px; width:1000px\" /></a></p>\n</div>\n</div>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (119,'<div class=\"ng-binding\">\n<div class=\"news-in-text\">\n<p>Основная функция упаковки сохранять и оберегать содержимое от влияния внешней среды. Во все времена товары нуждались в определенной форме, в которой их можно переносить, хранить. Посмотрим, как эволюционировала упаковка с глубокой древности до наших времен, какие новые функции она на себя приняла.</p>\n</div>\n\n<div class=\"news-in-text news-in-text-poz\">\n<h3>Бочка, бурдюк, флакон</h3>\nПервая тара делалась из подручных предметов &ndash; кожи животных, древесины, растений. С архаичных времен до наших дней дошли некоторые формы хранения продуктов, которые активно используются и сейчас. Во-первых, бурдюк. Обычно его используют для жидкостей, преимущественно спиртных напитков. Особенно распространен в странах Востока для содержания кумыса, вина, воды. В остальном мире его используют гораздо реже. Еще один мастодонт доживший до наших дней &ndash; деревянная бочка. Она использовалась людьми много тысяч лет назад, и исправно служит и до сих пор.<br />\n<br />\n<img src=\"https://informupack.ru/img_con/article/eda-napitki-pivo-bochonok-kruzhka-pivo-hmel-butylki-9_1.jpeg\" style=\"height:434px; width:650px\" /><br />\n<br />\nОдними из наиболее популярных материалов древности помимо древесины и кожи животных были стекло и керамика. В Египте, Греции, Индии находят сосуды, которые были созданы еще в первом тысячелетии до нашей эры! В древности в них хранили благовония, масла, вино, ароматические вещества.<br />\n&nbsp;\n<h3>Бумага</h3>\n<br />\nПосле древесины, керамики и стекла следующим революционным шагом в упаковке стало применение бумаги. Бумагу для писания изобрели еще до нашей эры в Китае, но заворачивать в нее продукты додумались только в XVII веке. И это неудивительно, в те времена бумага была дорогим удовольствием, и использовать ее в качестве упаковки никому не приходило в голову. Первая бумага для упаковки товаров была сделана специально для более качественного хранения товара. Немецкие умельцы придумали плотную бумагу с бирюзовым оттенком, в которую заворачивали рафинад. В XIX веке, когда стали появляться зачатки маркетинга на упаковочной бумаге стали печатать различные изображения, чтобы привлечь покупателя. Параллельное развитие полиграфии весьма этому поспособствовало.<br />\n<br />\n<img src=\"https://informupack.ru/img_con/article/20141210141723-10-wierdest-office-holiday-gifts.jpeg\" style=\"height:434px; width:650px\" title=\"Бумага\" /><br />\n<br />\nЧуть позже, во Франции изготовили дешевую бумагу, которую впоследствии стали называть вощанкой. Она была чуть плотнее обычной и покрыта тонким слоем олифы. В то же время англичане открыли непромокаемую бумагу, используя для ее производства пергамин. Впереди всех в техническом прогрессе, как всегда, были Соединенные штаты. Уже в середине XIX века здесь создали машины, которые умели производить бумажные пакеты и мешки.<br />\n<br />\nЕще один важный материал для упаковки на основе бумаги был разработан в XVIII веке, а затем усовершенствован в XIX. Речь идет о картоне. Еще в XVII столетии его использовали в медицине для упаковки украшений. До XIX века все делалось вручную, пока американец Роберт Гейр не додумался до технологии конвейерного производства картонных коробок. Использовав подержанный пресс, он умудрялся выпускать до 1000 единиц товара в день.<br />\n&nbsp;\n<h3>Консервы</h3>\n<br />\nXIX век стал веком научно-технического прогресса, и массовых открытий. Рынок потребления стремительно расширялся, появлялись новые товары, а значит появлялась потребность в более современной упаковке. Революцию, которая определила пути развития индустрии, совершили Николя Аиперт, Томас Саддингтон и Луи Пастер. Француз Николя Аиперт стал одним из первооткрывателей принципов консервации продуктов. Он понял, что нужно сделать для того, чтобы еду можно было хранить дольше обычного в стеклянных банках. В то время это был огромный прорыв, так как для нужд армии не портящиеся продукты был на вес золота.<br />\n<br />\n<img src=\"https://informupack.ru/img_con/article/karp8.jpg\" style=\"height:422px; width:634px\" /><br />\n<br />\nПравда, права на консервацию, запатентовал англичанин Томас Саддингтон. Он усовершенствовал банку и сделал ее металлической. Благодаря открытию Луи Пастера, в мире появилась первая асептическая упаковка. Тару и продукт стерилизовали по отдельности, а затем помещали товар в упаковку и герметично запаивали. Последним революционным шагом в области упаковки XIX века стало изобретения тюбика. Он совмещал две функции, чего никогда не было раньше &ndash; защищал товар и выступал в качестве дозатора.<br />\n&nbsp;\n<h3>XX век</h3>\n<br />\nВ XX веке развитие пошло еще более стремительно. Как известно, одной из главных проблем прошлого столетия века стало загрязнение окружающей среды, что, в свою очередь, непосредственно связанно с открытием полимеров и применением их для упаковки. Именно полимеры стали главным трендом в упаковке прошлого века. Впервые такая тара была использована в армии США для хранения аэрозолей против насекомых. Впоследствии она вышла за пределы армии и приобрела широкое применение во всем мире. Ее стали использовать в косметологии, медицине, пищевой отрасли.<br />\n<br />\nПримерно в то же время появилась пивная банка, которую мы знаем сейчас. Изначально консервы из металла покрывались оловом &ndash; они были громоздки и неудобны. В середине прошлого столетия в США появилась пивная банка из облегченного металла с удобной открывалкой, которой все пользуются до сих пор. XX век стал не только веком открытия новых материалов для хранения товаров. Он постепенно поменял саму суть упаковки. Она стала приобретать дополнительные функции и переходить из утилитарной категории в эстетическую. Возникновение таких явлений, как дизайн, маркетинг, появление телевидения, рекламы сообщило ей совершенно новые функции.<br />\n<br />\nУпаковка стала теперь не только сохранять продукт, но и продавать его. Развитие полиграфии и индустрии развлечений требовало хитрых подходов к потребителю. Для того чтобы остаться на рынке и привлечь большее количество покупателей, производители исхитрялись как могли, тем самым активно продвигая идеи потребления, что, в свою очередь, стало частью культурной эпохи XX века. В это время века упаковка буквально становится частью искусства. Для начала искусства китча &ndash; знаменитые банки супа Энди Уорхоллла стали символом середины 20 века и зарождения эпохи потребления. А затем и сама по себе, так как именно в это время начали появляться конкурсы дизайнеров, которые сейчас считаются культовыми &ndash; Cannes Lions International, Designand Art Direction, Clio Awards.<br />\n<br />\nК концу века упаковка стала обрастать различными технологичными подробностями. Теперь она уже не только защищала и продавала продукт. Она стала еще и полезной. В конце XX века в массовый обиход вошла упаковка, которую можно также использовать в качестве посуды или в других целях. Кроме того, на упаковках появились специальные идентификаторы, защитные коды, которые оберегали товар от копирования. Этот шаг, призванный уберечь товар от подделки стал мостом в следующую эпоху, которой еще только предстоит наступить.<br />\n<br />\nВ XXI веке мы все чаще сталкиваемся с таким понятием как интернет вещей, &laquo;эпоха умных вещей&raquo;. Эта эпоха, безусловно, нашла отклик и в упаковочной индустрии. Умная упаковка уже сейчас активно применяется в наиболее технологически развитых странах, в основном в области медицины. Так, например, благодаря встроенным микросхемам в умных упаковках перевозят кровь, органы, различные медикаменты. Такая упаковка теперь не только сохраняет содержимое, но еще и управляет им. Умная упаковка регулирует температуру, реагируя на влияние факторов внешней среды.<br />\n&nbsp;\n<h3>Отечественная упаковка</h3>\n<br />\nВ Советском Союзе упаковочной отрасли как отдельной категории не было. Как помнят многие из нас, продукты (которые не отличались разнообразием) заворачивали в лучшем случае в серую бумагу, которую использовали для обвешивания покупателей. Самой же популярной упаковкой была газета.<br />\nПосле распада СССР в России упаковочная отрасль поначалу также пребывала в упадке. Стремительное развитие началось в начале двухтысячных годов. К 2017 году она стала одной из наиболее перспективных отраслей экономики, которая затрагивает почти все сферы жизни: переработку мусора и отходов, сбор макулатуры и металлолома, развитие лесопромышленного комплекса, использование органических материалов и многое другое. Упаковочная отрасль, даже несмотря на санкции, продолжила развиваться. В XXI веке требования к упаковке выросли. Сейчас она должна быть прочная, удобная, привлекательная, нетоксичная и, желательно, пригодная для переработки или вторичного использования.<br />\n<br />\nПочти три четверти отечественного рынка потребляет пищевая промышленность. Она включает стеклотару, ПЭТ, картон, пакеты, контейнеры и многое другое. Среди материалов для изготовления лидером рынка являются полимеры. По состоянию на 2016 год объем упаковочного пластика составил около 540 тысяч тонн, при запросе потребительского рынка на 560 тысяч тонн. Несмотря на ограничения на продажу алкогольной продукции в ПЭТ, полимерная упаковка осваивает другие сегменты рынка. Стеклянная тара в последнее время уменьшила свои объемы за счет введения регуляций на потребления алкогольной продукции, а также снижения доходов населения. Стеклянная тара также перепрофилируется с алкогольной продукции на пищевую. Рынок увеличивается за счет увеличения продажи консервов.<br />\n<br />\nПо мнению многих специалистов, рынок упаковки в России является одним из наиболее перспективных. Главная проблема, что, впрочем, актуально для всей экономики &ndash; устарелость оборудования. Еще один важный вопрос препятствующий более интенсивному развитию &ndash; отсутствия эффективной нормативно-правовой базы.<br />\nРазвитие упаковки можно охарактеризовать как эволюционное. До наших дней дошла тара, которая использовалась несколько тысячелетий назад. С каждым новым веком усовершенствовалась технология предыдущего века, и только в XX столетии упаковка радикально изменила свою суть &ndash; она стала не только защищать, но и продавать. Согласно прогнозам, в XXI веке упаковка приобретет новые функции, а именно она станет не только сохранять содержимое, но и управлять им.</div>\n</div>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (120,'Вы еще не создали текст урока!','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (222,'<p>Какой простейший объект визуального дизайна?</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (223,'<p>Где зародился предшественник современного письма?</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (224,'<p>Где берет свое начало дизайн?</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (225,'<p>Выберите верные утверждения:</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (226,'<p>Где была изобретена бумага</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (227,'<p>Точка</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (228,'<p>Линия</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (229,'<p>Круг</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (230,'<p>В Византии</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (231,'<p>В Древнем Египте</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (232,'<p>В Греции</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (233,'<p>В Германии</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (234,'<p>В Англии</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (235,'<p>Во Франции</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (236,'<p>Дизайн складывается в процессе развития художественных программ, а так же инженерного проектирования.</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (237,'<p>Дизайн зародился во Франции</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (238,'<p>Компьютерный дизайн &mdash; художественно-проектная деятельность по созданию гармоничной и эффективной визуально-коммуникативной среды</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (239,'<p>В компьютерном дизайне используется только растровая графика</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (240,'<p>В Китае</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (241,'<p>В Японии</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (242,'<p>В Индии</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (258,'Введите описание курса','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (259,'Новый урок','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (260,'Новый урок','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (261,'Новый урок','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (263,'<p>Введите текст вопроса 1</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (264,'<p>Введите текст вопроса 2</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (265,'<p>Введите текст вопроса 3</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (266,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (267,'<p>Введите текст варианта t</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (268,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (269,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (270,'<p>Введите текст варианта t</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (271,'<p>Введите текст варианта t</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (272,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (273,'<p>Введите текст варианта t</p>\n','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (274,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (275,'Введите текст варианта','');
INSERT INTO `text` (`id_text`, `text`, `formatting`) VALUES (276,'Введите текст варианта','');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_access`
--

DROP TABLE IF EXISTS `user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `table` varchar(40) NOT NULL,
  `g_select` tinyint(1) NOT NULL,
  `g_insert` tinyint(1) NOT NULL,
  `g_update` tinyint(1) NOT NULL,
  `g_delete` tinyint(1) NOT NULL,
  `rls` tinyint(1) NOT NULL,
  `target_id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_access`
--

LOCK TABLES `user_access` WRITE;
/*!40000 ALTER TABLE `user_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_result`
--

DROP TABLE IF EXISTS `user_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `id_course` bigint(20) unsigned NOT NULL,
  `lessons_learned` smallint(6) NOT NULL DEFAULT '0',
  `test_result` tinyint(4) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `test_id` bigint(20) unsigned DEFAULT NULL,
  `test_active` tinyint(1) DEFAULT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `fkey_courses` (`id_course`),
  KEY `fkey_tests_ur` (`test_id`),
  KEY `fkey_session_ur` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_result`
--

LOCK TABLES `user_result` WRITE;
/*!40000 ALTER TABLE `user_result` DISABLE KEYS */;
INSERT INTO `user_result` (`id`, `user_id`, `id_course`, `lessons_learned`, `test_result`, `active`, `test_id`, `test_active`, `session_id`) VALUES (16,23,8,2,5,1,14,0,7);
INSERT INTO `user_result` (`id`, `user_id`, `id_course`, `lessons_learned`, `test_result`, `active`, `test_id`, `test_active`, `session_id`) VALUES (17,24,8,0,NULL,1,NULL,NULL,NULL);
INSERT INTO `user_result` (`id`, `user_id`, `id_course`, `lessons_learned`, `test_result`, `active`, `test_id`, `test_active`, `session_id`) VALUES (21,23,9,0,3,1,15,0,6);
/*!40000 ALTER TABLE `user_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login` char(20) NOT NULL,
  `password` char(255) NOT NULL,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `email` text NOT NULL,
  `administrator` tinyint(1) NOT NULL DEFAULT '0',
  `curator` tinyint(1) NOT NULL DEFAULT '0',
  `teacher` tinyint(1) NOT NULL DEFAULT '0',
  `student` tinyint(1) NOT NULL DEFAULT '0',
  `last_visit` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (3,'admin','$2y$12$wqnRH5H5amGXLK7bkAMOP.8MoP3r1yXmdMwDOROUl7SXppz2YBDzi','Админ','Админ','admin@admin.com',1,0,0,0,'2018-09-22 00:04:39');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (19,'curator','$2y$10$rO/PIqm8jLNixtxC2Fw9pesz3hRvAAApIDnOs/m.I.Hh7lRj4Qm9S','Сергей','Сергеев','c',0,1,0,0,'2018-08-24 11:03:16');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (20,'curator2','$2y$10$/4ufycEzNUP4FNCT9UJKS.LAhiWpobjwW0HIB26BFdvy5IBQf7ySi','Иван','Иванов','c2',0,1,0,0,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (21,'teacher1','$2y$10$hXf4LuJ5aC2TlrCZSYmKKubbEr27wh6pu.QGYqYCipFquglss634C','Василий','Орлов','teacher1',0,0,1,0,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (22,'teacher2','$2y$10$kQOgHx88mftnZDRKO4vbD.OcMY0B26UM3ZtX.viUt2xiIs86LjPKq','Алексей','Алексеев','teacher2',0,0,1,0,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (23,'student1','$2y$10$G5mhalaWcaNd7qHQvD7p9OQJl9krryLEK5aCECRYK6XwC10vj9Rw.','Валентин','Петров','st1',0,0,0,1,'2018-08-24 14:52:27');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (24,'student2','$2y$10$ztBDpVs8GAiqA2eSPJfXAuiY98kC4jTJAb/7kQJZh/CtXQtbp0lju','Александр','Сидоров','st2',0,0,0,1,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (25,'student3','$2y$10$s3Qstpuqwljv56z0CVQ/beoH/mSNeUZTxQVRQ3iQbuicTVC9l5/XC','Сергей','Жуков','st3',0,0,0,1,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (26,'teacher3','$2y$10$td/e3OQ10Zk03jo54J.kcueb9ZMkyPjzUNDXBNmEVnfALpt5/sOpi','Геннадий','Онуфриев','t3',0,0,1,0,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (27,'teacher4','$2y$10$VrwyhyJ9kMh5tYNAEjhGA.FZozSb8zXDGEL/yAu/7xoI6I.oeTrve','Андрей','Орлов','andrey@andrey.ru',0,0,1,0,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (28,'student4','$2y$10$JkcS.50QX1Epf4Fzqn0Shu9Od3THYYrH596G23rIoG76L9yrtbV0i','Вася','Пупкин','vasya@vasya.ru',0,0,0,1,'0000-00-00 00:00:00');
INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `email`, `administrator`, `curator`, `teacher`, `student`, `last_visit`) VALUES (29,'student5','$2y$10$YLmfhq2JAmEKDkrW3fNlKuw7chFy25RkF7CRp.P25aNe9fzsAWDOm','Вася','Васильев','vasya@yandex.ru',0,0,0,1,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createUserResult` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF NEW.student=1 THEN
		INSERT INTO user_result(user_id)
        VALUES(NEW.id);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteUser` AFTER DELETE ON `users` FOR EACH ROW DELETE FROM user_access WHERE user_id=OLD.id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `variants`
--

DROP TABLE IF EXISTS `variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_question` bigint(20) unsigned NOT NULL,
  `number` tinyint(4) NOT NULL,
  `id_text` bigint(20) unsigned NOT NULL,
  `isright` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variants`
--

LOCK TABLES `variants` WRITE;
/*!40000 ALTER TABLE `variants` DISABLE KEYS */;
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (81,56,1,227,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (82,56,2,228,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (83,56,3,229,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (84,57,1,230,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (85,57,2,231,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (86,57,3,232,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (87,58,1,233,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (88,58,2,234,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (89,58,3,235,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (90,59,1,236,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (91,59,2,237,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (92,59,3,238,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (93,59,4,239,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (94,60,1,240,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (95,60,2,241,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (96,60,3,242,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (97,61,1,266,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (98,61,2,267,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (99,61,3,268,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (100,62,1,269,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (101,62,2,270,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (102,62,3,271,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (103,62,4,272,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (104,63,1,273,1);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (105,63,2,274,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (106,63,3,275,0);
INSERT INTO `variants` (`id`, `id_question`, `number`, `id_text`, `isright`) VALUES (107,63,4,276,0);
/*!40000 ALTER TABLE `variants` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createVariant` BEFORE INSERT ON `variants` FOR EACH ROW BEGIN
	INSERT INTO text(text) VALUES('Введите текст варианта');
    SET NEW.id_text=(SELECT LAST_INSERT_ID());
    
    SET @count=(SELECT COUNT(*) FROM variants WHERE 						id_question=NEW.id_question);
    IF @count>0 THEN
    	SET @max=(SELECT MAX(number) FROM variants WHERE 							id_question=NEW.id_question);
        SET NEW.number=@max+1;
    ELSE
        SET NEW.number=1;
    END IF;       
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `createVariantCheckActive` AFTER INSERT ON `variants` FOR EACH ROW BEGIN
	SET @vcount=(SELECT COUNT(*) FROM variants WHERE id_question=NEW.id_question);
    IF @vcount<2 THEN
    	UPDATE tests SET active=0 WHERE id IN (SELECT id_test FROM questions WHERE id=NEW.id_question);
    ELSE
    	SET @right=(SELECT COUNT(*) FROM variants WHERE id_question=NEW.id_question AND isright=1);
        IF @right=0 THEN
        	UPDATE tests SET active=0 WHERE id IN (SELECT id_test FROM questions WHERE id=NEW.id_question);
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteTextV` AFTER DELETE ON `variants` FOR EACH ROW BEGIN
	DELETE FROM text WHERE id_text=OLD.id_text;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-22  0:16:00
