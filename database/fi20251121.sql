-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: billing.chz1invwpykd.us-east-1.rds.amazonaws.com    Database: cloud
-- ------------------------------------------------------
-- Server version	8.0.43

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_user_id_60cbbbe3_fk_users_id` (`user_id`),
  CONSTRAINT `activity_logs_user_id_60cbbbe3_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add custom user',6,'add_customuser'),(22,'Can change custom user',6,'change_customuser'),(23,'Can delete custom user',6,'delete_customuser'),(24,'Can view custom user',6,'view_customuser'),(25,'Can add activity logs',7,'add_activitylogs'),(26,'Can change activity logs',7,'change_activitylogs'),(27,'Can delete activity logs',7,'delete_activitylogs'),(28,'Can view activity logs',7,'view_activitylogs'),(29,'Can add invoices',8,'add_invoices'),(30,'Can change invoices',8,'change_invoices'),(31,'Can delete invoices',8,'delete_invoices'),(32,'Can view invoices',8,'view_invoices'),(33,'Can add payments',9,'add_payments'),(34,'Can change payments',9,'change_payments'),(35,'Can delete payments',9,'delete_payments'),(36,'Can view payments',9,'view_payments'),(37,'Can add plans',10,'add_plans'),(38,'Can change plans',10,'change_plans'),(39,'Can delete plans',10,'delete_plans'),(40,'Can view plans',10,'view_plans'),(41,'Can add subscriptions',11,'add_subscriptions'),(42,'Can change subscriptions',11,'change_subscriptions'),(43,'Can delete subscriptions',11,'delete_subscriptions'),(44,'Can view subscriptions',11,'view_subscriptions'),(45,'Can add notifications',12,'add_notifications'),(46,'Can change notifications',12,'change_notifications'),(47,'Can delete notifications',12,'delete_notifications'),(48,'Can view notifications',12,'view_notifications');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(8,'billing','invoices'),(9,'billing','payments'),(10,'billing','plans'),(11,'billing','subscriptions'),(4,'contenttypes','contenttype'),(12,'notifications','notifications'),(5,'sessions','session'),(7,'users','activitylogs'),(6,'users','customuser');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-11-04 15:43:35.646541'),(2,'contenttypes','0002_remove_content_type_name','2025-11-04 15:43:35.677157'),(3,'auth','0001_initial','2025-11-04 15:43:35.756305'),(4,'auth','0002_alter_permission_name_max_length','2025-11-04 15:43:35.774589'),(5,'auth','0003_alter_user_email_max_length','2025-11-04 15:43:35.777539'),(6,'auth','0004_alter_user_username_opts','2025-11-04 15:43:35.780263'),(7,'auth','0005_alter_user_last_login_null','2025-11-04 15:43:35.783421'),(8,'auth','0006_require_contenttypes_0002','2025-11-04 15:43:35.784619'),(9,'auth','0007_alter_validators_add_error_messages','2025-11-04 15:43:35.787441'),(10,'auth','0008_alter_user_username_max_length','2025-11-04 15:43:35.790595'),(11,'auth','0009_alter_user_last_name_max_length','2025-11-04 15:43:35.793071'),(12,'auth','0010_alter_group_name_max_length','2025-11-04 15:43:35.800803'),(13,'auth','0011_update_proxy_permissions','2025-11-04 15:43:35.804160'),(14,'auth','0012_alter_user_first_name_max_length','2025-11-04 15:43:35.807297'),(15,'users','0001_initial','2025-11-04 15:43:35.916872'),(16,'admin','0001_initial','2025-11-04 15:43:35.966217'),(17,'admin','0002_logentry_remove_auto_add','2025-11-04 15:43:35.971280'),(18,'admin','0003_logentry_add_action_flag_choices','2025-11-04 15:43:35.975926'),(19,'billing','0001_initial','2025-11-04 15:43:36.007934'),(20,'billing','0002_initial','2025-11-04 15:43:36.124207'),(21,'notifications','0001_initial','2025-11-04 15:43:36.131175'),(22,'notifications','0002_initial','2025-11-04 15:43:36.156100'),(23,'sessions','0001_initial','2025-11-04 15:43:36.171433'),(24,'users','0002_customuser_used_storage','2025-11-21 11:11:28.280801');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3nqqtzox5m3snxzc6d96ysc7chq00gok','.eJxVjEEOgjAQRe_StWlg6LTUpXvP0ExnpoIaSCisjHdXEha6_e-9_zKJtnVIW9UljWLOpjWn3y0TP3Tagdxpus2W52ldxmx3xR602uss-rwc7t_BQHX41qgNMgtF8uha7qT4oDFnz9ADQoO5oIsg4tAxaggMjsQXgJ5930Xz_gDxQzfg:1vMPaG:M-sM31xyhXYXN4J-JiYkl0-WCKzzsHY2kRX5UOPWmYY','2025-12-05 11:45:48.617333'),('ffv89ako4o0muayj61r29lmc9lgfh3ew','.eJxVjDsOwjAQBe_iGlnYWf8o6XMGa71r4wBypDipEHeHSCmgfTPzXiLitta49bzEicVFgDj9bgnpkdsO-I7tNkua27pMSe6KPGiX48z5eT3cv4OKvX5rVwySRa80cnLasgqFkwroChEBcAnZnmnI3oCDwWqtjDUFvLchJY3i_QEAZTgU:1vMO3T:FGmw1xdWiM-My5z8urmB0Rn-ZaNnXSP9WIsjH0WbN04','2025-12-05 10:07:51.693078');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(50) NOT NULL,
  `issue_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `payment_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice_number` (`invoice_number`),
  KEY `invoices_payment_id_d20b1255_fk_payments_id` (`payment_id`),
  CONSTRAINT `invoices_payment_id_d20b1255_fk_payments_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (4,'INV-1762272288','2025-11-04','2025-11-04',10.00,'paid',5),(5,'INV-1762275994','2025-11-04','2025-11-04',10.00,'paid',11),(6,'INV-1762276101','2025-11-04','2025-11-04',90.00,'paid',12),(7,'INV-1763712428','2025-11-21','2025-11-21',10.00,'paid',17),(8,'INV-1763716416','2025-11-21','2025-11-21',10.00,'paid',18),(9,'INV-1763724710','2025-11-21','2025-11-21',90.00,'paid',19),(10,'INV-1763725613','2025-11-21','2025-11-21',10.00,'paid',20);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message` longtext,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_468e288d_fk_users_id` (`user_id`),
  CONSTRAINT `notifications_user_id_468e288d_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `plan_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_user_id_189b9948_fk_users_id` (`user_id`),
  KEY `payments_plan_id_90836eea_fk_plans_id` (`plan_id`),
  CONSTRAINT `payments_plan_id_90836eea_fk_plans_id` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  CONSTRAINT `payments_user_id_189b9948_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (5,10.00,'vnpay','success','15238250','2025-11-04 16:04:03.695877',1,2),(6,100.00,'vnpay','pending','1_3_1762272315','2025-11-04 16:05:15.264941',1,3),(7,100.00,'vnpay','pending','1_3_1762272564','2025-11-04 16:09:24.606665',1,3),(8,10.00,'vnpay','pending','1_2_1762275873','2025-11-04 17:04:33.779236',1,2),(9,10.00,'vnpay','pending','1_2_1762275894','2025-11-04 17:04:54.262816',1,2),(10,100.00,'vnpay','pending','1_3_1762275898','2025-11-04 17:04:58.512229',1,3),(11,10.00,'vnpay','success','15238373','2025-11-04 17:05:33.785373',1,2),(12,90.00,'vnpay','success','15238380','2025-11-04 17:07:51.797412',1,3),(13,100.00,'vnpay','pending','1_3_1762762804','2025-11-10 08:20:04.588812',1,3),(14,10.00,'vnpay','pending','1_2_1762763140','2025-11-10 08:25:40.228299',1,2),(15,10.00,'vnpay','pending','1_2_1763712321','2025-11-21 08:05:21.914117',1,2),(16,10.00,'vnpay','pending','1_2_1763712329','2025-11-21 08:05:29.653383',1,2),(17,10.00,'vnpay','success','15276484','2025-11-21 08:06:30.388150',1,2),(18,10.00,'vnpay','success','15276751','2025-11-21 09:13:10.574568',4,2),(19,90.00,'vnpay','success','15279062','2025-11-21 11:31:16.024186',1,3),(20,10.00,'vnpay','success','15279088','2025-11-21 11:46:24.865862',1,2);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `price` decimal(10,2) NOT NULL,
  `storage_limit` bigint NOT NULL,
  `duration_days` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Free','Gói 1GB',0.00,1073741824,0,'2025-11-04 15:47:24.364987'),(2,'Plus','Gói 2GB',10.00,2147483648,30,'2025-11-04 15:48:30.775823'),(3,'Premium','Gói 50GB',100.00,53687091200,30,'2025-11-04 15:49:14.473023');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `plan_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_plan_id_b857580e_fk_plans_id` (`plan_id`),
  KEY `subscriptions_user_id_599297d4_fk_users_id` (`user_id`),
  CONSTRAINT `subscriptions_plan_id_b857580e_fk_plans_id` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  CONSTRAINT `subscriptions_user_id_599297d4_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (17,'2025-11-21','2025-12-21','active',2,4),(20,'2025-11-21','2025-12-21','active',2,1);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` varchar(5) DEFAULT NULL,
  `used_storage` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pbkdf2_sha256$1000000$EbqumTCkEwpZFEbUOGNAB9$3lzYUsCvf2iZIdWv6+T6g6k4e0leDjn4JLMdDPVBB2M=','2025-11-21 11:45:48.351202',0,'giahuy','','','huyphan2792005@gmail.com',0,1,'2025-11-04 15:45:57.572142','','','user',107374182),(3,'pbkdf2_sha256$1000000$9uQf47kLke9DaNdSR5hdkt$yCzg1YmAG9t4KpVuyDf6kM75qyu0teIPK9FweinQ1Go=','2025-11-10 08:26:02.496140',0,'huy','','','phanrinh279@gmail.com',0,1,'2025-11-10 08:26:02.490000','','','user',0),(4,'pbkdf2_sha256$1000000$manVNsixCLjnmDwn5aE3yE$C5CPNbJ6uoViPwLO/uaeWAD/0cdD3qbsd2mD7RbSvjY=','2025-11-21 10:48:28.619410',0,'thanhhuy','','','huy@gmail.com',0,1,'2025-11-21 08:43:48.260460','','','user',0),(5,'pbkdf2_sha256$1000000$PWOZ5Dw2rBjNw8x4bO80MZ$gZy4PvX7gOYTc6xfR+7dgIdFRFXbiOd6X7+nKVLQMJ0=','2025-11-21 10:07:58.793705',0,'thanh','','','phanrinh279@gmail.com',0,1,'2025-11-21 10:07:57.085393','','','user',0),(6,'pbkdf2_sha256$1000000$erLJ2jjjb8eOUaaG0g9aWE$846unzAj0mBg3KL9Vydih3bcfP5rXjGWnHwaC48rHVA=',NULL,0,'huy123','','','huy@example.com',0,1,'2025-11-21 10:31:16.577874','','','user',0),(7,'pbkdf2_sha256$1000000$4Qj2tvR0Qu8zAXvByuR3Fp$vHFK6Gd68jGDLaaniKmJekRAftn4R+v/cTW9buQbn10=','2025-11-21 11:38:44.189800',1,'admin','','','admin@gmail.com',1,1,'2025-11-21 10:49:35.740695',NULL,NULL,'admin',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_customuser_id_group_id_927de924_uniq` (`customuser_id`,`group_id`),
  KEY `users_groups_group_id_2f3517aa_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_groups_customuser_id_4bd991a9_fk_users_id` FOREIGN KEY (`customuser_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_permissions`
--

DROP TABLE IF EXISTS `users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_permissions_customuser_id_permission_id_2b4e4e39_uniq` (`customuser_id`,`permission_id`),
  KEY `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_permissions_customuser_id_efdb305c_fk_users_id` FOREIGN KEY (`customuser_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_permissions`
--

LOCK TABLES `users_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-21 18:53:16
