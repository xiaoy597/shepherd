-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: localhost    Database: spiderdb
-- ------------------------------------------------------
-- Server version	5.7.30

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
-- Table structure for table `app_module`
--

DROP TABLE IF EXISTS `app_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_module` (
  `module_id` int(11) NOT NULL,
  `super_module_id` int(11) DEFAULT NULL,
  `module_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_module`
--

LOCK TABLES `app_module` WRITE;
/*!40000 ALTER TABLE `app_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_config`
--

DROP TABLE IF EXISTS `crawl_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_config` (
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `param_name` varchar(40) NOT NULL,
  `param_value` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`job_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_config`
--

LOCK TABLES `crawl_config` WRITE;
/*!40000 ALTER TABLE `crawl_config` DISABLE KEYS */;
INSERT INTO `crawl_config` VALUES (1,1,'request_type','get'),(1,2,'request_type','get'),(1,3,'request_type','get'),(1,4,'request_type','get'),(1,5,'http_header_1','Host: query.sse.com.cn'),(1,5,'http_header_2','Referer: http://www.sse.com.cn/market/stockdata/overview/day/'),(1,5,'json_extract_group','1'),(1,5,'json_extract_pattern','jsonpCallback\\d+\\(([^)]+)\\)'),(1,5,'request_type','get'),(1,5,'start_url_pattern','http://query.sse.com.cn/marketdata/tradedata/queryTradingByProdTypeData.do?jsonCallBack=jsonpCallback46192&searchDate=${TRANS_DATE}&prodType=gp&_=1505878067773'),(1,5,'TRANS_DATE','range(2017-09-01, 2017-09-25)'),(1,6,'http_header_1','Host: query.sse.com.cn'),(1,6,'http_header_2','Referer: http://www.sse.com.cn/market/funddata/overview/day/'),(1,6,'json_extract_group','1'),(1,6,'json_extract_pattern','jsonpCallback\\d+\\(([^)]+)\\)'),(1,6,'request_type','get'),(1,6,'start_url_pattern','http://query.sse.com.cn/marketdata/tradedata/queryTradingByProdTypeData.do?jsonCallBack=jsonpCallback72606&searchDate=${TRANS_DATE}&prodType=jj&_=1506064857871'),(1,6,'TRANS_DATE','range(2017-09-01, 2017-09-25)'),(1,7,'form_field_1','ACTIONID=7'),(1,7,'form_field_2','AJAX=AJAX-TRUE'),(1,7,'form_field_3','CATALOGID=1804'),(1,7,'form_field_4','txtDate=${TRANS_DATE}'),(1,7,'form_field_5','TABKEY=tab1'),(1,7,'form_field_6','REPORT_ACTION=search'),(1,7,'http_header_1','Host: www.szse.cn'),(1,7,'http_header_2','Referer: http://www.szse.cn/main/marketdata/tjsj/jyjg/'),(1,7,'request_type','post'),(1,7,'TRANS_DATE','range(2017-09-18, 2017-09-22)'),(1,8,'request_type','get');
/*!40000 ALTER TABLE `crawl_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_host`
--

DROP TABLE IF EXISTS `crawl_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_host` (
  `host_id` int(11) NOT NULL,
  `host_name` varchar(20) DEFAULT NULL,
  `host_ip` varchar(20) DEFAULT NULL,
  `host_status` int(11) DEFAULT NULL,
  `user_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_host`
--

LOCK TABLES `crawl_host` WRITE;
/*!40000 ALTER TABLE `crawl_host` DISABLE KEYS */;
INSERT INTO `crawl_host` VALUES (1,'采集服务器1','127.0.0.1',1,0);
/*!40000 ALTER TABLE `crawl_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_job`
--

DROP TABLE IF EXISTS `crawl_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_job` (
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `job_name` varchar(40) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  `host_id` int(11) DEFAULT NULL,
  `max_page_num` int(11) DEFAULT NULL,
  `page_life_cycle` int(11) DEFAULT NULL,
  `entry_page_id` int(11) DEFAULT NULL,
  `job_cat_id` int(11) DEFAULT NULL,
  `max_depth` int(11) DEFAULT NULL,
  `crawl_src_type_id` int(11) DEFAULT NULL,
  `start_urls` varchar(512) DEFAULT NULL,
  `data_store_id` int(11) DEFAULT NULL,
  `job_schedule_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_job`
--

LOCK TABLES `crawl_job` WRITE;
/*!40000 ALTER TABLE `crawl_job` DISABLE KEYS */;
INSERT INTO `crawl_job` VALUES (2,1,'天气预报',0,1,0,0,1,0,0,0,'http://www.weather.com.cn/textFC/hunan.shtml',1,0),(7,1,'深交所证券成交量',0,1,0,0,1,0,0,0,'http://www.szse.cn/szseWeb/FrontController.szse?randnum=0.30835385089340417',1,0),(8,1,'丝路商机',0,1,0,0,1,0,0,0,'http://www.xinhuanet.com/silkroad/slsj.htm',1,0);
/*!40000 ALTER TABLE `crawl_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_job_category`
--

DROP TABLE IF EXISTS `crawl_job_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_job_category` (
  `job_cat_id` int(11) NOT NULL,
  `job_cat_name` varchar(40) DEFAULT NULL,
  `super_cat_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_job_category`
--

LOCK TABLES `crawl_job_category` WRITE;
/*!40000 ALTER TABLE `crawl_job_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `crawl_job_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_page`
--

DROP TABLE IF EXISTS `crawl_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_page` (
  `page_url` varchar(128) NOT NULL,
  `download_time` date NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`page_url`,`download_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_page`
--

LOCK TABLES `crawl_page` WRITE;
/*!40000 ALTER TABLE `crawl_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `crawl_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_page_config`
--

DROP TABLE IF EXISTS `crawl_page_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_page_config` (
  `page_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `page_name` varchar(20) DEFAULT NULL,
  `page_type` int(11) DEFAULT NULL,
  `data_format` int(11) DEFAULT NULL,
  `is_multi_page` int(11) DEFAULT NULL,
  `paginate_element` varchar(128) DEFAULT NULL,
  `load_indicator` varchar(128) DEFAULT NULL,
  `page_interval` int(11) DEFAULT NULL,
  `max_page_num` int(11) DEFAULT NULL,
  `save_page_source` int(11) DEFAULT NULL,
  `data_file` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`page_id`,`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_page_config`
--

LOCK TABLES `crawl_page_config` WRITE;
/*!40000 ALTER TABLE `crawl_page_config` DISABLE KEYS */;
INSERT INTO `crawl_page_config` VALUES (1,1,1,'新浪新闻列表',1,0,1,'//div[@class=\"pagebox\"]/span[@class=\"pagebox_pre\"][last()]/a','//div[@class=\"pagebox\"]',0,2,0,''),(1,2,1,'省级天气预报',0,0,0,'','//div[@class=\"hanml\"]',0,0,0,'spider_data.weather'),(1,3,1,'新浪图片列表',1,0,1,'//span[@class=\"pagination\"]/a[@class=\"next\"]','//span[@class=\"pagination\"]/a[@class=\"next\"]',0,2,0,''),(1,4,1,'新浪股票行情',1,0,1,'','//h1[@id=\"stockName\"]',2,10,0,'spider_data.stock_price'),(1,5,1,'上交所股票交易概况页面',2,0,0,NULL,NULL,0,0,0,'spider_data.sse_stock_overview'),(1,6,1,'上交所基金交易概况页面',2,0,0,NULL,NULL,0,0,0,'spider_data.sse_fund_overview'),(1,7,1,'深交所证券交易概况页面',0,0,0,NULL,NULL,0,0,0,'spider_data.szse_market_overview'),(1,8,1,'丝路商机首页',0,0,0,NULL,NULL,0,0,0,NULL),(2,1,1,'新浪新闻页面',0,0,0,'','//h1[@id=\"artibodyTitle\"]',0,0,0,'spider_data.sina_news'),(2,3,1,'新浪图片页面',1,0,0,'','//div[@slide-type=\"title\"]/h2',0,0,0,'spider_data.sina_image'),(2,8,1,'丝路商机文章',0,0,0,NULL,NULL,0,0,0,'spider_data.slsj_article');
/*!40000 ALTER TABLE `crawl_page_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_src_type`
--

DROP TABLE IF EXISTS `crawl_src_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_src_type` (
  `crawl_src_type_id` int(11) NOT NULL,
  `crawl_src_type_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`crawl_src_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_src_type`
--

LOCK TABLES `crawl_src_type` WRITE;
/*!40000 ALTER TABLE `crawl_src_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `crawl_src_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawl_status`
--

DROP TABLE IF EXISTS `crawl_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawl_status` (
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `run_status` int(11) DEFAULT NULL,
  `download_page_num` int(11) DEFAULT NULL,
  `pending_page_num` int(11) DEFAULT NULL,
  `error_page_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`job_id`,`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawl_status`
--

LOCK TABLES `crawl_status` WRITE;
/*!40000 ALTER TABLE `crawl_status` DISABLE KEYS */;
INSERT INTO `crawl_status` VALUES (1,1,'2018-10-17 10:18:53',2,0,0,0),(1,1,'2018-10-17 10:20:58',2,0,0,0),(1,1,'2018-10-17 10:23:56',2,0,0,0),(1,1,'2018-10-17 10:27:13',2,122,0,0),(1,1,'2018-10-17 10:33:16',2,122,0,0),(1,1,'2018-10-17 10:54:11',2,122,0,0),(1,1,'2018-10-17 11:07:28',2,122,0,0),(1,1,'2018-10-17 12:35:45',2,122,0,0),(1,1,'2018-10-17 12:42:37',2,122,0,0),(1,2,'2020-04-30 09:51:10',2,0,0,0),(1,2,'2020-04-30 10:13:12',2,0,0,0),(1,2,'2020-04-30 10:48:18',2,1,0,0),(1,2,'2020-04-30 11:03:10',2,1,0,0),(1,2,'2020-04-30 13:40:34',2,0,0,0),(1,2,'2020-04-30 17:15:43',2,1,0,0),(1,2,'2020-04-30 17:21:05',2,1,0,0),(1,2,'2020-04-30 17:25:54',2,1,0,0),(1,2,'2020-05-22 10:49:06',2,1,0,0),(1,2,'2020-05-22 14:52:47',2,1,0,0),(1,2,'2020-05-22 14:57:26',2,1,0,0);
/*!40000 ALTER TABLE `crawl_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_store`
--

DROP TABLE IF EXISTS `data_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_store` (
  `data_store_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `data_store_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`data_store_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_store`
--

LOCK TABLES `data_store` WRITE;
/*!40000 ALTER TABLE `data_store` DISABLE KEYS */;
INSERT INTO `data_store` VALUES (1,1,0);
/*!40000 ALTER TABLE `data_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_store_param`
--

DROP TABLE IF EXISTS `data_store_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_store_param` (
  `data_store_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `param_name` varchar(20) NOT NULL,
  `param_value` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`data_store_id`,`user_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_store_param`
--

LOCK TABLES `data_store_param` WRITE;
/*!40000 ALTER TABLE `data_store_param` DISABLE KEYS */;
INSERT INTO `data_store_param` VALUES (1,1,'host','127.0.0.1'),(1,1,'passwd','root'),(1,1,'port','3306'),(1,1,'user','root');
/*!40000 ALTER TABLE `data_store_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_schedule`
--

DROP TABLE IF EXISTS `job_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_schedule` (
  `job_schedule_id` int(11) NOT NULL,
  `job_schedule_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_schedule`
--

LOCK TABLES `job_schedule` WRITE;
/*!40000 ALTER TABLE `job_schedule` DISABLE KEYS */;
INSERT INTO `job_schedule` VALUES (0,0),(1,1),(2,2);
/*!40000 ALTER TABLE `job_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_schedule_param`
--

DROP TABLE IF EXISTS `job_schedule_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_schedule_param` (
  `job_schedule_id` int(11) NOT NULL,
  `param_name` varchar(20) NOT NULL,
  `param_value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`job_schedule_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_schedule_param`
--

LOCK TABLES `job_schedule_param` WRITE;
/*!40000 ALTER TABLE `job_schedule_param` DISABLE KEYS */;
INSERT INTO `job_schedule_param` VALUES (0,'time',''),(1,'minutes','30'),(1,'start_date','2017-07-24 17:00:00'),(2,'second','0'),(2,'start_date','2017-07-24 17:00:00');
/*!40000 ALTER TABLE `job_schedule_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nstruct_ext_config`
--

DROP TABLE IF EXISTS `nstruct_ext_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nstruct_ext_config` (
  `nstruct_ext_rule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nstruct_ext_rule_name` varchar(40) DEFAULT NULL,
  `data_format` int(11) DEFAULT NULL,
  `data_store_type` int(11) DEFAULT NULL,
  `data_store_path` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`nstruct_ext_rule_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nstruct_ext_config`
--

LOCK TABLES `nstruct_ext_config` WRITE;
/*!40000 ALTER TABLE `nstruct_ext_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `nstruct_ext_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nstruct_ext_page`
--

DROP TABLE IF EXISTS `nstruct_ext_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nstruct_ext_page` (
  `nstruct_ext_rule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nstruct_data_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`nstruct_ext_rule_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nstruct_ext_page`
--

LOCK TABLES `nstruct_ext_page` WRITE;
/*!40000 ALTER TABLE `nstruct_ext_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `nstruct_ext_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nstruct_field`
--

DROP TABLE IF EXISTS `nstruct_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nstruct_field` (
  `field_id` int(11) NOT NULL,
  `nstruct_ext_rule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_name` varchar(40) DEFAULT NULL,
  `field_datatype` int(11) DEFAULT NULL,
  `parent_field_id` int(11) DEFAULT NULL,
  `field_locate_pattern` varchar(128) DEFAULT NULL,
  `field_ext_pattern` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`field_id`,`nstruct_ext_rule_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nstruct_field`
--

LOCK TABLES `nstruct_field` WRITE;
/*!40000 ALTER TABLE `nstruct_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `nstruct_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_field`
--

DROP TABLE IF EXISTS `page_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_field` (
  `field_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_name` varchar(40) DEFAULT NULL,
  `field_datatype` int(11) DEFAULT NULL,
  `parent_field_id` int(11) DEFAULT NULL,
  `combine_field_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`field_id`,`page_id`,`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_field`
--

LOCK TABLES `page_field` WRITE;
/*!40000 ALTER TABLE `page_field` DISABLE KEYS */;
INSERT INTO `page_field` VALUES (1,1,2,1,'city',0,0,1),(1,1,7,1,'trd_date',0,0,0),(1,2,8,1,'title',0,0,0),(2,1,2,1,'district',0,1,1),(2,1,7,1,'trd_amt_a',0,0,0),(2,2,8,1,'content',0,0,0),(3,1,2,1,'day_weather',0,1,1),(3,1,7,1,'trd_vol_a',0,0,0),(4,1,2,1,'day_wind',0,1,1),(4,1,7,1,'capital_stock_a',0,0,0),(5,1,2,1,'max_temp',1,1,1),(5,1,7,1,'market_value_a',0,0,0),(6,1,2,1,'night_weather',0,1,1),(6,1,7,1,'negotiable_stock_a',0,0,0),(7,1,2,1,'night_wind',0,1,1),(7,1,7,1,'negotiable_value_a',0,0,0),(8,1,2,1,'min_temp',1,1,1),(8,1,7,1,'trd_amt_b',0,0,0),(9,1,7,1,'trd_vol_b',0,0,0),(11,1,7,1,'capital_stock_b',0,0,0),(12,1,7,1,'market_value_b',0,0,0),(13,1,7,1,'negotiable_stock_b',0,0,0),(14,1,7,1,'negotiable_value_b',0,0,0),(15,1,7,1,'trd_amt_sme',0,0,0),(16,1,7,1,'trd_vol_sme',0,0,0),(17,1,7,1,'capital_stock_sme',0,0,0),(18,1,7,1,'market_value_sme',0,0,0),(19,1,7,1,'negotiable_stock_sme',0,0,0),(21,1,7,1,'negotiable_value_sme',0,0,0),(22,1,7,1,'trd_amt_gem',0,0,0),(23,1,7,1,'trd_vol_gem',0,0,0),(24,1,7,1,'capital_stock_gem',0,0,0),(25,1,7,1,'market_value_gem',0,0,0),(26,1,7,1,'negotiable_stock_gem',0,0,0),(27,1,7,1,'negotiable_value_gem',0,0,0),(28,1,7,1,'trd_amt_lof',0,0,0),(29,1,7,1,'trd_vol_lof',0,0,0),(31,1,7,1,'capital_stock_lof',0,0,0),(32,1,7,1,'market_value_lof',0,0,0),(33,1,7,1,'negotiable_stock_lof',0,0,0),(34,1,7,1,'negotiable_value_lof',0,0,0),(35,1,7,1,'trd_amt_etf',0,0,0),(36,1,7,1,'trd_vol_etf',0,0,0),(37,1,7,1,'capital_stock_etf',0,0,0),(38,1,7,1,'market_value_etf',0,0,0),(39,1,7,1,'negotiable_stock_etf',0,0,0),(41,1,7,1,'negotiable_value_etf',0,0,0),(42,1,7,1,'trd_amt_slof',0,0,0),(43,1,7,1,'trd_vol_slof',0,0,0),(44,1,7,1,'capital_stock_slof',0,0,0),(45,1,7,1,'market_value_slof',0,0,0),(46,1,7,1,'negotiable_stock_slof',0,0,0),(47,1,7,1,'negotiable_value_slof',0,0,0),(48,1,7,1,'trd_amt_cef',0,0,0),(49,1,7,1,'trd_vol_cef',0,0,0),(51,1,7,1,'capital_stock_cef',0,0,0),(52,1,7,1,'market_value_cef',0,0,0),(53,1,7,1,'negotiable_stock_cef',0,0,0),(54,1,7,1,'negotiable_value_cef',0,0,0),(55,1,7,1,'trd_amt_nat_bond',0,0,0),(56,1,7,1,'trd_vol_nat_bond',0,0,0),(57,1,7,1,'capital_stock_nat_bond',0,0,0),(58,1,7,1,'market_value_nat_bond',0,0,0),(59,1,7,1,'negotiable_stock_nat_bond',0,0,0),(61,1,7,1,'negotiable_value_nat_bond',0,0,0),(62,1,7,1,'trd_amt_crp_bond',0,0,0),(63,1,7,1,'trd_vol_crp_bond',0,0,0),(64,1,7,1,'capital_stock_crp_bond',0,0,0),(65,1,7,1,'market_value_crp_bond',0,0,0),(66,1,7,1,'negotiable_stock_crp_bond',0,0,0),(67,1,7,1,'negotiable_value_crp_bond',0,0,0),(68,1,7,1,'trd_amt_ent_bond',0,0,0),(69,1,7,1,'trd_vol_ent_bond',0,0,0),(71,1,7,1,'capital_stock_ent_bond',0,0,0),(72,1,7,1,'market_value_ent_bond',0,0,0),(73,1,7,1,'negotiable_stock_ent_bond',0,0,0),(74,1,7,1,'negotiable_value_ent_bond',0,0,0),(75,1,7,1,'trd_amt_buy_bond',0,0,0),(76,1,7,1,'trd_vol_buy_bond',0,0,0),(77,1,7,1,'capital_stock_buy_bond',0,0,0),(78,1,7,1,'market_value_buy_bond',0,0,0),(79,1,7,1,'negotiable_stock_buy_bond',0,0,0),(81,1,7,1,'negotiable_value_buy_bond',0,0,0),(82,1,7,1,'trd_amt_conv_bond',0,0,0),(83,1,7,1,'trd_vol_conv_bond',0,0,0),(84,1,7,1,'capital_stock_conv_bond',0,0,0),(85,1,7,1,'market_value_conv_bond',0,0,0),(86,1,7,1,'negotiable_stock_conv_bond',0,0,0),(87,1,7,1,'negotiable_value_conv_bond',0,0,0),(88,1,7,1,'count_a',0,0,0),(89,1,7,1,'count_b',0,0,0),(90,1,7,1,'count_sme',0,0,0),(91,1,7,1,'count_gem',0,0,0),(92,1,7,1,'count_lof',0,0,0),(93,1,7,1,'count_etf',0,0,0),(94,1,7,1,'count_cef',0,0,0),(95,1,7,1,'count_slof',0,0,0),(96,1,7,1,'count_nat_bond',0,0,0),(97,1,7,1,'count_crp_bond',0,0,0),(98,1,7,1,'count_ent_bond',0,0,0),(99,1,7,1,'count_buy_bond',0,0,0),(100,1,7,1,'count_conv_bond',0,0,0);
/*!40000 ALTER TABLE `page_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_field_locate`
--

DROP TABLE IF EXISTS `page_field_locate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_field_locate` (
  `field_locate_id` int(11) NOT NULL,
  `field_locate_pattern` varchar(512) DEFAULT NULL,
  `field_ext_pattern` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`field_locate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_field_locate`
--

LOCK TABLES `page_field_locate` WRITE;
/*!40000 ALTER TABLE `page_field_locate` DISABLE KEYS */;
INSERT INTO `page_field_locate` VALUES (201,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[1]/td[@class=\"rowsPan\"]','self-text'),(202,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][1]','text'),(203,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][2]','text'),(204,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][3]','text'),(205,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][4]','text'),(206,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][5]','text'),(207,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][6]','text'),(208,'//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][7]','text'),(701,'//span[@class=\"cls-subtitle\"]','text'),(702,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[3]','text'),(703,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[4]','text'),(704,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[5]','text'),(705,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[6]','text'),(706,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[7]','text'),(707,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[8]','text'),(708,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[3]','text'),(709,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[4]','text'),(711,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[5]','text'),(712,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[6]','text'),(713,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[7]','text'),(714,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[8]','text'),(715,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[3]','text'),(716,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[4]','text'),(717,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[5]','text'),(718,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[6]','text'),(719,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[7]','text'),(721,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[8]','text'),(722,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[3]','text'),(723,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[4]','text'),(724,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[5]','text'),(725,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[6]','text'),(726,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[7]','text'),(727,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[8]','text'),(728,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[3]','text'),(729,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[4]','text'),(731,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[5]','text'),(732,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[6]','text'),(733,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[7]','text'),(734,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[8]','text'),(735,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[3]','text'),(736,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[4]','text'),(737,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[5]','text'),(738,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[6]','text'),(739,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[7]','text'),(741,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[8]','text'),(742,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[3]','text'),(743,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[4]','text'),(744,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[5]','text'),(745,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[6]','text'),(746,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[7]','text'),(747,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[8]','text'),(748,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[3]','text'),(749,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[4]','text'),(751,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[5]','text'),(752,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[6]','text'),(753,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[7]','text'),(754,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[8]','text'),(755,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[3]','text'),(756,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[4]','text'),(757,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[5]','text'),(758,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[6]','text'),(759,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[7]','text'),(761,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[8]','text'),(762,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[3]','text'),(763,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[4]','text'),(764,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[5]','text'),(765,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[6]','text'),(766,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[7]','text'),(767,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[8]','text'),(768,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[3]','text'),(769,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[4]','text'),(771,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[5]','text'),(772,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[6]','text'),(773,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[7]','text'),(774,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[8]','text'),(775,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[3]','text'),(776,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[4]','text'),(777,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[5]','text'),(778,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[6]','text'),(779,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[7]','text'),(781,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[8]','text'),(782,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[3]','text'),(783,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[4]','text'),(784,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[5]','text'),(785,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[6]','text'),(786,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[7]','text'),(787,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[8]','text'),(788,'//table[@id=\"REPORTID_tab1\"]/tr[3]/td[2]','text'),(789,'//table[@id=\"REPORTID_tab1\"]/tr[4]/td[2]','text'),(790,'//table[@id=\"REPORTID_tab1\"]/tr[5]/td[2]','text'),(791,'//table[@id=\"REPORTID_tab1\"]/tr[6]/td[2]','text'),(792,'//table[@id=\"REPORTID_tab1\"]/tr[8]/td[2]','text'),(793,'//table[@id=\"REPORTID_tab1\"]/tr[9]/td[2]','text'),(794,'//table[@id=\"REPORTID_tab1\"]/tr[11]/td[2]','text'),(795,'//table[@id=\"REPORTID_tab1\"]/tr[10]/td[2]','text'),(796,'//table[@id=\"REPORTID_tab1\"]/tr[13]/td[2]','text'),(797,'//table[@id=\"REPORTID_tab1\"]/tr[14]/td[2]','text'),(798,'//table[@id=\"REPORTID_tab1\"]/tr[15]/td[2]','text'),(799,'//table[@id=\"REPORTID_tab1\"]/tr[16]/td[2]','text'),(800,'//table[@id=\"REPORTID_tab1\"]/tr[17]/td[2]','text'),(1001,'//div[@class=\"h-title\"]|//h1[@id=\"title\"]|//span[@id=\"title\"]|//div[@id=\"title\"]|//div[@id=\"Title\"]','text'),(1002,'//div[@id=\"p-detail\"]|//div[@class=\"article\"]|//div[@id=\"content\"]|//div[@class=\"content\"]//div[@id=\"Content\"]','text');
/*!40000 ALTER TABLE `page_field_locate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_field_locate_relation`
--

DROP TABLE IF EXISTS `page_field_locate_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_field_locate_relation` (
  `field_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_locate_id` int(11) NOT NULL,
  PRIMARY KEY (`field_id`,`page_id`,`job_id`,`user_id`,`field_locate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_field_locate_relation`
--

LOCK TABLES `page_field_locate_relation` WRITE;
/*!40000 ALTER TABLE `page_field_locate_relation` DISABLE KEYS */;
INSERT INTO `page_field_locate_relation` VALUES (1,1,2,1,201),(1,1,7,1,701),(1,2,8,1,1001),(2,1,2,1,202),(2,1,7,1,702),(2,2,8,1,1002),(3,1,2,1,203),(3,1,7,1,703),(4,1,2,1,204),(4,1,7,1,704),(5,1,2,1,205),(5,1,7,1,705),(6,1,2,1,206),(6,1,7,1,706),(7,1,2,1,207),(7,1,7,1,707),(8,1,2,1,208),(8,1,7,1,708),(9,1,7,1,709),(11,1,7,1,711),(12,1,7,1,712),(13,1,7,1,713),(14,1,7,1,714),(15,1,7,1,715),(16,1,7,1,716),(17,1,7,1,717),(18,1,7,1,718),(19,1,7,1,719),(21,1,7,1,721),(22,1,7,1,722),(23,1,7,1,723),(24,1,7,1,724),(25,1,7,1,725),(26,1,7,1,726),(27,1,7,1,727),(28,1,7,1,728),(29,1,7,1,729),(31,1,7,1,731),(32,1,7,1,732),(33,1,7,1,733),(34,1,7,1,734),(35,1,7,1,735),(36,1,7,1,736),(37,1,7,1,737),(38,1,7,1,738),(39,1,7,1,739),(41,1,7,1,741),(42,1,7,1,742),(43,1,7,1,743),(44,1,7,1,744),(45,1,7,1,745),(46,1,7,1,746),(47,1,7,1,747),(48,1,7,1,748),(49,1,7,1,749),(51,1,7,1,751),(52,1,7,1,752),(53,1,7,1,753),(54,1,7,1,754),(55,1,7,1,755),(56,1,7,1,756),(57,1,7,1,757),(58,1,7,1,758),(59,1,7,1,759),(61,1,7,1,761),(62,1,7,1,762),(63,1,7,1,763),(64,1,7,1,764),(65,1,7,1,765),(66,1,7,1,766),(67,1,7,1,767),(68,1,7,1,768),(69,1,7,1,769),(71,1,7,1,771),(72,1,7,1,772),(73,1,7,1,773),(74,1,7,1,774),(75,1,7,1,775),(76,1,7,1,776),(77,1,7,1,777),(78,1,7,1,778),(79,1,7,1,779),(81,1,7,1,781),(82,1,7,1,782),(83,1,7,1,783),(84,1,7,1,784),(85,1,7,1,785),(86,1,7,1,786),(87,1,7,1,787),(88,1,7,1,788),(89,1,7,1,789),(90,1,7,1,790),(91,1,7,1,791),(92,1,7,1,792),(93,1,7,1,793),(94,1,7,1,794),(95,1,7,1,795),(96,1,7,1,796),(97,1,7,1,797),(98,1,7,1,798),(99,1,7,1,799),(100,1,7,1,800);
/*!40000 ALTER TABLE `page_field_locate_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_link`
--

DROP TABLE IF EXISTS `page_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_link` (
  `link_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `link_locate_pattern` varchar(512) DEFAULT NULL,
  `link_ext_pattern` varchar(128) DEFAULT NULL,
  `next_page_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`link_id`,`page_id`,`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_link`
--

LOCK TABLES `page_link` WRITE;
/*!40000 ALTER TABLE `page_link` DISABLE KEYS */;
INSERT INTO `page_link` VALUES (1,1,8,1,'/RETURNED_FROM_SPIDER_HELPER','http://.*',2);
/*!40000 ALTER TABLE `page_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poxy_assign`
--

DROP TABLE IF EXISTS `poxy_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poxy_assign` (
  `proxy_server_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`proxy_server_id`,`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poxy_assign`
--

LOCK TABLES `poxy_assign` WRITE;
/*!40000 ALTER TABLE `poxy_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `poxy_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poxy_server`
--

DROP TABLE IF EXISTS `poxy_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poxy_server` (
  `proxy_server_id` int(11) NOT NULL,
  `proxy_server_name` varchar(40) DEFAULT NULL,
  `proxy_server_ip` varchar(20) DEFAULT NULL,
  `proxy_user_name` varchar(40) DEFAULT NULL,
  `proxy_user_password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`proxy_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poxy_server`
--

LOCK TABLES `poxy_server` WRITE;
/*!40000 ALTER TABLE `poxy_server` DISABLE KEYS */;
/*!40000 ALTER TABLE `poxy_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  `reg_date` date DEFAULT NULL,
  `user_status` int(11) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Test user 1',0,'2017-07-01',0,'2017-07-02 09:00:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `user_group_id` int(11) NOT NULL,
  `user_group_name` varchar(40) DEFAULT NULL,
  `super_user_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_member`
--

DROP TABLE IF EXISTS `user_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_member` (
  `user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_member`
--

LOCK TABLES `user_group_member` WRITE;
/*!40000 ALTER TABLE `user_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_role_id` int(11) NOT NULL,
  `user_role_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role_assign`
--

DROP TABLE IF EXISTS `user_role_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role_assign` (
  `user_id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_assign`
--

LOCK TABLES `user_role_assign` WRITE;
/*!40000 ALTER TABLE `user_role_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role_privilege`
--

DROP TABLE IF EXISTS `user_role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role_privilege` (
  `user_role_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `access_privilege` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`user_role_id`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_privilege`
--

LOCK TABLES `user_role_privilege` WRITE;
/*!40000 ALTER TABLE `user_role_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role_privilege` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-05 16:35:10
