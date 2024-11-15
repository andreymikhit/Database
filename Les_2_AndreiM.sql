/*
Lesson 2
Практическое задание по теме “Управление БД”
============================================
1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин
и пароль, который указывался при установке.
2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов,
числового id и строкового name.
3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое
дампа в новую базу данных sample.
4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте
дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы
дамп содержал только первые 100 строк таблицы.
*/

/*
1.
файл .my.cnf​
user=root
password='1239'
*/

/*
2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
**/
CREATE DATABASE example;
CREATE TABLE users (id INT, name TEXT);

/*
3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
*/

mysqldump example > c:\MAILRU\example.dump 
C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe --routines --add-drop-table --disable-keys --extended-insert --host=localhost --port=3306 -u root example
Task 'MySQL dump' started at Sat Aug 08 09:32:15 YEKT 2020
Task 'MySQL dump' finished at Sat Aug 08 09:32:15 YEKT 2020
08.08.2020  09:32             1 895 dump-example-202008080932.sql
08.08.2020  09:10             1 841 example.dump

CREATE DATABASE sample;
mysql sample < c:\example.dump
mysql sample
mysql> show tables;
+------------------+
| Tables_in_sample |
+------------------+
| user             |
+------------------+
1 row in set (0.00 sec)

mysql> describe user;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.00 sec)

/*
4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал 
только первые 100 строк таблицы.
*/
mysqldump mysql --tables --where="true limit 100" help_keyword > c:\help_keyword.sql

-- ИТОГО

-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  true limit 100

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (226,'(JSON'),(227,'->'),(229,'->>'),(46,'<>'),(637,'ACCOUNT'),(439,'ACTION'),(40,'ADD'),(663,'ADMIN'),(108,'AES_DECRYPT'),(109,'AES_ENCRYPT'),(358,'AFTER'),(95,'AGAINST'),(684,'AGGREGATE'),(359,'ALGORITHM'),(502,'ALL'),(41,'ALTER'),(360,'ANALYZE'),(47,'AND'),(313,'ANY_VALUE'),(440,'ARCHIVE'),(102,'ARRAY'),(503,'AS'),(261,'ASC'),(421,'AT'),(638,'ATTRIBUTE'),(526,'AUTOCOMMIT'),(462,'AUTOEXTEND_SIZE'),(361,'AUTO_INCREMENT'),(362,'AVG_ROW_LENGTH'),(538,'BACKUP'),(552,'BEFORE'),(527,'BEGIN'),(48,'BETWEEN'),(59,'BIGINT'),(104,'BINARY'),(342,'BINLOG'),(314,'BIN_TO_UUID'),(8,'BOOL'),(9,'BOOLEAN'),(85,'BOTH'),(425,'BTREE'),(262,'BY'),(33,'BYTE'),(720,'CACHE'),(470,'CALL'),(285,'CAN_ACCESS_COLUMN'),(286,'CAN_ACCESS_DATABASE'),(287,'CAN_ACCESS_TABLE'),(288,'CAN_ACCESS_VIEW'),(441,'CASCADE'),(53,'CASE'),(617,'CATALOG_NAME'),(62,'CEIL'),(63,'CEILING'),(528,'CHAIN'),(363,'CHANGE'),(343,'CHANNEL'),(34,'CHAR'),(30,'CHARACTER'),(696,'CHARSET'),(364,'CHECK'),(365,'CHECKSUM'),(639,'CIPHER'),(618,'CLASS_ORIGIN'),(664,'CLIENT'),(692,'CLONE'),(476,'CLOSE'),(366,'COALESCE'),(715,'CODE'),(321,'COLLATE'),(698,'COLLATION'),(367,'COLUMN'),(368,'COLUMNS'),(619,'COLUMN_NAME'),(328,'COMMENT'),(529,'COMMIT'),(541,'COMMITTED'),(442,'COMPACT'),(329,'COMPLETION'),(688,'COMPONENT'),(443,'COMPRESSED'),(369,'COMPRESSION'),(489,'CONCURRENT'),(614,'CONDITION'),(370,'CONNECTION'),(530,'CONSISTENT'),(371,'CONSTRAINT'),(620,'CONSTRAINT_CATALOG'),(621,'CONSTRAINT_NAME'),(622,'CONSTRAINT_SCHEMA'),(615,'CONTINUE'),(103,'CONVERT'),(260,'COUNT'),(42,'CREATE'),(258,'CREATE_DH_PARAMETERS'),(519,'CROSS'),(444,'CSV'),(270,'CUME_DIST'),(640,'CURRENT'),(116,'CURRENT_ROLE');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-09 09:35:29

