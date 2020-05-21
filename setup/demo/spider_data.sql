-- MySQL dump 10.16  Distrib 10.1.44-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: spider_data
-- ------------------------------------------------------
-- Server version	10.1.44-MariaDB

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
-- Table structure for table `sina_image`
--

DROP TABLE IF EXISTS `sina_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sina_image` (
  `collect_time` datetime NOT NULL,
  `title` varchar(256) NOT NULL,
  `image_url` varchar(512) NOT NULL,
  `image_path` varchar(512) NOT NULL,
  `description` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`image_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sina_image`
--

LOCK TABLES `sina_image` WRITE;
/*!40000 ALTER TABLE `sina_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `sina_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sina_news`
--

DROP TABLE IF EXISTS `sina_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sina_news` (
  `collect_time` datetime NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`collect_time`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sina_news`
--

LOCK TABLES `sina_news` WRITE;
/*!40000 ALTER TABLE `sina_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `sina_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slsj_article`
--

DROP TABLE IF EXISTS `slsj_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slsj_article` (
  `collect_time` datetime NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`collect_time`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slsj_article`
--

LOCK TABLES `slsj_article` WRITE;
/*!40000 ALTER TABLE `slsj_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `slsj_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sse_fund_overview`
--

DROP TABLE IF EXISTS `sse_fund_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sse_fund_overview` (
  `collect_time` datetime NOT NULL,
  `exchange_rate_cef` decimal(8,6) DEFAULT NULL,
  `ist_vol_cef` int(11) DEFAULT NULL,
  `market_value_cef` decimal(16,2) DEFAULT NULL,
  `market_value1_cef` decimal(24,10) DEFAULT NULL,
  `negotiable_value_cef` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_cef` decimal(24,10) DEFAULT NULL,
  `product_type_cef` int(11) DEFAULT NULL,
  `profit_rate_cef` decimal(16,2) DEFAULT NULL,
  `profit_rate1_cef` decimal(24,10) DEFAULT NULL,
  `search_date_cef` datetime NOT NULL,
  `trd_amt_cef` decimal(16,2) DEFAULT NULL,
  `trd_amt1_cef` decimal(24,10) DEFAULT NULL,
  `trd_tm_cef` decimal(16,2) DEFAULT NULL,
  `trd_tm1_cef` decimal(24,10) DEFAULT NULL,
  `trd_vol_cef` decimal(16,2) DEFAULT NULL,
  `trd_vol1_cef` decimal(24,10) DEFAULT NULL,
  `exchange_rate_sh` decimal(8,6) DEFAULT NULL,
  `ist_vol_sh` int(11) DEFAULT NULL,
  `market_value_sh` decimal(16,2) DEFAULT NULL,
  `market_value1_sh` decimal(24,10) DEFAULT NULL,
  `negotiable_value_sh` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_sh` decimal(24,10) DEFAULT NULL,
  `product_type_sh` int(11) DEFAULT NULL,
  `profit_rate_sh` decimal(16,2) DEFAULT NULL,
  `profit_rate1_sh` decimal(24,10) DEFAULT NULL,
  `search_date_sh` datetime NOT NULL,
  `trd_amt_sh` decimal(16,2) DEFAULT NULL,
  `trd_amt1_sh` decimal(24,10) DEFAULT NULL,
  `trd_tm_sh` decimal(16,2) DEFAULT NULL,
  `trd_tm1_sh` decimal(24,10) DEFAULT NULL,
  `trd_vol_sh` decimal(16,2) DEFAULT NULL,
  `trd_vol1_sh` decimal(24,10) DEFAULT NULL,
  `exchange_rate_etf` decimal(8,6) DEFAULT NULL,
  `ist_vol_etf` int(11) DEFAULT NULL,
  `market_value_etf` decimal(16,2) DEFAULT NULL,
  `market_value1_etf` decimal(24,10) DEFAULT NULL,
  `negotiable_value_etf` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_etf` decimal(24,10) DEFAULT NULL,
  `product_type_etf` int(11) DEFAULT NULL,
  `profit_rate_etf` decimal(16,2) DEFAULT NULL,
  `profit_rate1_etf` decimal(24,10) DEFAULT NULL,
  `search_date_etf` datetime NOT NULL,
  `trd_amt_etf` decimal(16,2) DEFAULT NULL,
  `trd_amt1_etf` decimal(24,10) DEFAULT NULL,
  `trd_tm_etf` decimal(16,2) DEFAULT NULL,
  `trd_tm1_etf` decimal(24,10) DEFAULT NULL,
  `trd_vol_etf` decimal(16,2) DEFAULT NULL,
  `trd_vol1_etf` decimal(24,10) DEFAULT NULL,
  `exchange_rate_lof` decimal(8,6) DEFAULT NULL,
  `ist_vol_lof` int(11) DEFAULT NULL,
  `market_value_lof` decimal(16,2) DEFAULT NULL,
  `market_value1_lof` decimal(24,10) DEFAULT NULL,
  `negotiable_value_lof` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_lof` decimal(24,10) DEFAULT NULL,
  `product_type_lof` int(11) DEFAULT NULL,
  `profit_rate_lof` decimal(16,2) DEFAULT NULL,
  `profit_rate1_lof` decimal(24,10) DEFAULT NULL,
  `search_date_lof` datetime NOT NULL,
  `trd_amt_lof` decimal(16,2) DEFAULT NULL,
  `trd_amt1_lof` decimal(24,10) DEFAULT NULL,
  `trd_tm_lof` decimal(16,2) DEFAULT NULL,
  `trd_tm1_lof` decimal(24,10) DEFAULT NULL,
  `trd_vol_lof` decimal(16,2) DEFAULT NULL,
  `trd_vol1_lof` decimal(24,10) DEFAULT NULL,
  `exchange_rate_slof` decimal(8,6) DEFAULT NULL,
  `ist_vol_slof` int(11) DEFAULT NULL,
  `market_value_slof` decimal(16,2) DEFAULT NULL,
  `market_value1_slof` decimal(24,10) DEFAULT NULL,
  `negotiable_value_slof` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_slof` decimal(24,10) DEFAULT NULL,
  `product_type_slof` int(11) DEFAULT NULL,
  `profit_rate_slof` decimal(16,2) DEFAULT NULL,
  `profit_rate1_slof` decimal(24,10) DEFAULT NULL,
  `search_date_slof` datetime NOT NULL,
  `trd_amt_slof` decimal(16,2) DEFAULT NULL,
  `trd_amt1_slof` decimal(24,10) DEFAULT NULL,
  `trd_tm_slof` decimal(16,2) DEFAULT NULL,
  `trd_tm1_slof` decimal(24,10) DEFAULT NULL,
  `trd_vol_slof` decimal(16,2) DEFAULT NULL,
  `trd_vol1_slof` decimal(24,10) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`search_date_cef`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sse_fund_overview`
--

LOCK TABLES `sse_fund_overview` WRITE;
/*!40000 ALTER TABLE `sse_fund_overview` DISABLE KEYS */;
/*!40000 ALTER TABLE `sse_fund_overview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sse_stock_overview`
--

DROP TABLE IF EXISTS `sse_stock_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sse_stock_overview` (
  `collect_time` datetime NOT NULL,
  `exchange_rate_a` decimal(8,6) DEFAULT NULL,
  `ist_vol_a` int(11) DEFAULT NULL,
  `market_value_a` decimal(16,2) DEFAULT NULL,
  `market_value1_a` decimal(24,10) DEFAULT NULL,
  `negotiable_value_a` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_a` decimal(24,10) DEFAULT NULL,
  `product_type_a` int(11) DEFAULT NULL,
  `profit_rate_a` decimal(16,2) DEFAULT NULL,
  `profit_rate1_a` decimal(24,10) DEFAULT NULL,
  `search_date_a` datetime NOT NULL,
  `trd_amt_a` decimal(16,2) DEFAULT NULL,
  `trd_amt1_a` decimal(24,10) DEFAULT NULL,
  `trd_tm_a` decimal(16,2) DEFAULT NULL,
  `trd_tm1_a` decimal(24,10) DEFAULT NULL,
  `trd_vol_a` decimal(16,2) DEFAULT NULL,
  `trd_vol1_a` decimal(24,10) DEFAULT NULL,
  `exchange_rate_b` decimal(8,6) DEFAULT NULL,
  `ist_vol_b` int(11) DEFAULT NULL,
  `market_value_b` decimal(16,2) DEFAULT NULL,
  `market_value1_b` decimal(24,10) DEFAULT NULL,
  `negotiable_value_b` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_b` decimal(24,10) DEFAULT NULL,
  `product_type_b` int(11) DEFAULT NULL,
  `profit_rate_b` decimal(16,2) DEFAULT NULL,
  `profit_rate1_b` decimal(24,10) DEFAULT NULL,
  `search_date_b` datetime NOT NULL,
  `trd_amt_b` decimal(16,2) DEFAULT NULL,
  `trd_amt1_b` decimal(24,10) DEFAULT NULL,
  `trd_tm_b` decimal(16,2) DEFAULT NULL,
  `trd_tm1_b` decimal(24,10) DEFAULT NULL,
  `trd_vol_b` decimal(16,2) DEFAULT NULL,
  `trd_vol1_b` decimal(24,10) DEFAULT NULL,
  `exchange_rate_sh` decimal(8,6) DEFAULT NULL,
  `ist_vol_sh` int(11) DEFAULT NULL,
  `market_value_sh` decimal(16,2) DEFAULT NULL,
  `market_value1_sh` decimal(24,10) DEFAULT NULL,
  `negotiable_value_sh` decimal(16,2) DEFAULT NULL,
  `negotiable_value1_sh` decimal(24,10) DEFAULT NULL,
  `product_type_sh` int(11) DEFAULT NULL,
  `profit_rate_sh` decimal(16,2) DEFAULT NULL,
  `profit_rate1_sh` decimal(24,10) DEFAULT NULL,
  `search_date_sh` datetime NOT NULL,
  `trd_amt_sh` decimal(16,2) DEFAULT NULL,
  `trd_amt1_sh` decimal(24,10) DEFAULT NULL,
  `trd_tm_sh` decimal(16,2) DEFAULT NULL,
  `trd_tm1_sh` decimal(24,10) DEFAULT NULL,
  `trd_vol_sh` decimal(16,2) DEFAULT NULL,
  `trd_vol1_sh` decimal(24,10) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`search_date_a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sse_stock_overview`
--

LOCK TABLES `sse_stock_overview` WRITE;
/*!40000 ALTER TABLE `sse_stock_overview` DISABLE KEYS */;
/*!40000 ALTER TABLE `sse_stock_overview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_price`
--

DROP TABLE IF EXISTS `stock_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_price` (
  `collect_time` datetime NOT NULL,
  `stock_name` varchar(32) DEFAULT NULL,
  `stock_id` varchar(12) NOT NULL,
  `stock_time` datetime DEFAULT NULL,
  `stock_price` decimal(18,2) DEFAULT NULL,
  `stock_open_price` decimal(18,2) DEFAULT NULL,
  `stock_deal_num` varchar(20) DEFAULT NULL,
  `stock_deal_amt` varchar(20) DEFAULT NULL,
  `stock_high_price` decimal(18,2) DEFAULT NULL,
  `stock_exch_rate` varchar(20) DEFAULT NULL,
  `stock_low_price` decimal(18,2) DEFAULT NULL,
  `stock_total_value` varchar(20) DEFAULT NULL,
  `stock_pb` decimal(16,2) DEFAULT NULL,
  `stock_close_price` decimal(18,2) DEFAULT NULL,
  `stock_currency_value` varchar(20) DEFAULT NULL,
  `stock_pe` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_price`
--

LOCK TABLES `stock_price` WRITE;
/*!40000 ALTER TABLE `stock_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `szse_market_overview`
--

DROP TABLE IF EXISTS `szse_market_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `szse_market_overview` (
  `collect_time` datetime NOT NULL,
  `trd_date` datetime NOT NULL,
  `count_a` varchar(30) DEFAULT NULL,
  `trd_amt_a` varchar(30) DEFAULT NULL,
  `trd_vol_a` varchar(30) DEFAULT NULL,
  `capital_stock_a` varchar(30) DEFAULT NULL,
  `market_value_a` varchar(30) DEFAULT NULL,
  `negotiable_stock_a` varchar(30) DEFAULT NULL,
  `negotiable_value_a` varchar(30) DEFAULT NULL,
  `count_b` varchar(30) DEFAULT NULL,
  `trd_amt_b` varchar(30) DEFAULT NULL,
  `trd_vol_b` varchar(30) DEFAULT NULL,
  `capital_stock_b` varchar(30) DEFAULT NULL,
  `market_value_b` varchar(30) DEFAULT NULL,
  `negotiable_stock_b` varchar(30) DEFAULT NULL,
  `negotiable_value_b` varchar(30) DEFAULT NULL,
  `count_sme` varchar(30) DEFAULT NULL,
  `trd_amt_sme` varchar(30) DEFAULT NULL,
  `trd_vol_sme` varchar(30) DEFAULT NULL,
  `capital_stock_sme` varchar(30) DEFAULT NULL,
  `market_value_sme` varchar(30) DEFAULT NULL,
  `negotiable_stock_sme` varchar(30) DEFAULT NULL,
  `negotiable_value_sme` varchar(30) DEFAULT NULL,
  `count_gem` varchar(30) DEFAULT NULL,
  `trd_amt_gem` varchar(30) DEFAULT NULL,
  `trd_vol_gem` varchar(30) DEFAULT NULL,
  `capital_stock_gem` varchar(30) DEFAULT NULL,
  `market_value_gem` varchar(30) DEFAULT NULL,
  `negotiable_stock_gem` varchar(30) DEFAULT NULL,
  `negotiable_value_gem` varchar(30) DEFAULT NULL,
  `count_lof` varchar(30) DEFAULT NULL,
  `trd_amt_lof` varchar(30) DEFAULT NULL,
  `trd_vol_lof` varchar(30) DEFAULT NULL,
  `capital_stock_lof` varchar(30) DEFAULT NULL,
  `market_value_lof` varchar(30) DEFAULT NULL,
  `negotiable_stock_lof` varchar(30) DEFAULT NULL,
  `negotiable_value_lof` varchar(30) DEFAULT NULL,
  `count_etf` varchar(30) DEFAULT NULL,
  `trd_amt_etf` varchar(30) DEFAULT NULL,
  `trd_vol_etf` varchar(30) DEFAULT NULL,
  `capital_stock_etf` varchar(30) DEFAULT NULL,
  `market_value_etf` varchar(30) DEFAULT NULL,
  `negotiable_stock_etf` varchar(30) DEFAULT NULL,
  `negotiable_value_etf` varchar(30) DEFAULT NULL,
  `count_slof` varchar(30) DEFAULT NULL,
  `trd_amt_slof` varchar(30) DEFAULT NULL,
  `trd_vol_slof` varchar(30) DEFAULT NULL,
  `capital_stock_slof` varchar(30) DEFAULT NULL,
  `market_value_slof` varchar(30) DEFAULT NULL,
  `negotiable_stock_slof` varchar(30) DEFAULT NULL,
  `negotiable_value_slof` varchar(30) DEFAULT NULL,
  `count_cef` varchar(30) DEFAULT NULL,
  `trd_amt_cef` varchar(30) DEFAULT NULL,
  `trd_vol_cef` varchar(30) DEFAULT NULL,
  `capital_stock_cef` varchar(30) DEFAULT NULL,
  `market_value_cef` varchar(30) DEFAULT NULL,
  `negotiable_stock_cef` varchar(30) DEFAULT NULL,
  `negotiable_value_cef` varchar(30) DEFAULT NULL,
  `count_nat_bond` varchar(30) DEFAULT NULL,
  `trd_amt_nat_bond` varchar(30) DEFAULT NULL,
  `trd_vol_nat_bond` varchar(30) DEFAULT NULL,
  `capital_stock_nat_bond` varchar(30) DEFAULT NULL,
  `market_value_nat_bond` varchar(30) DEFAULT NULL,
  `negotiable_stock_nat_bond` varchar(30) DEFAULT NULL,
  `negotiable_value_nat_bond` varchar(30) DEFAULT NULL,
  `count_crp_bond` varchar(30) DEFAULT NULL,
  `trd_amt_crp_bond` varchar(30) DEFAULT NULL,
  `trd_vol_crp_bond` varchar(30) DEFAULT NULL,
  `capital_stock_crp_bond` varchar(30) DEFAULT NULL,
  `market_value_crp_bond` varchar(30) DEFAULT NULL,
  `negotiable_stock_crp_bond` varchar(30) DEFAULT NULL,
  `negotiable_value_crp_bond` varchar(30) DEFAULT NULL,
  `count_ent_bond` varchar(30) DEFAULT NULL,
  `trd_amt_ent_bond` varchar(30) DEFAULT NULL,
  `trd_vol_ent_bond` varchar(30) DEFAULT NULL,
  `capital_stock_ent_bond` varchar(30) DEFAULT NULL,
  `market_value_ent_bond` varchar(30) DEFAULT NULL,
  `negotiable_stock_ent_bond` varchar(30) DEFAULT NULL,
  `negotiable_value_ent_bond` varchar(30) DEFAULT NULL,
  `count_buy_bond` varchar(30) DEFAULT NULL,
  `trd_amt_buy_bond` varchar(30) DEFAULT NULL,
  `trd_vol_buy_bond` varchar(30) DEFAULT NULL,
  `capital_stock_buy_bond` varchar(30) DEFAULT NULL,
  `market_value_buy_bond` varchar(30) DEFAULT NULL,
  `negotiable_stock_buy_bond` varchar(30) DEFAULT NULL,
  `negotiable_value_buy_bond` varchar(30) DEFAULT NULL,
  `count_conv_bond` varchar(30) DEFAULT NULL,
  `trd_amt_conv_bond` varchar(30) DEFAULT NULL,
  `trd_vol_conv_bond` varchar(30) DEFAULT NULL,
  `capital_stock_conv_bond` varchar(30) DEFAULT NULL,
  `market_value_conv_bond` varchar(30) DEFAULT NULL,
  `negotiable_stock_conv_bond` varchar(30) DEFAULT NULL,
  `negotiable_value_conv_bond` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`trd_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `szse_market_overview`
--

LOCK TABLES `szse_market_overview` WRITE;
/*!40000 ALTER TABLE `szse_market_overview` DISABLE KEYS */;
/*!40000 ALTER TABLE `szse_market_overview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather` (
  `collect_time` datetime NOT NULL,
  `city` varchar(16) NOT NULL,
  `district` varchar(16) NOT NULL,
  `day_weather` varchar(32) DEFAULT NULL,
  `day_wind` varchar(32) DEFAULT NULL,
  `max_temp` decimal(4,2) DEFAULT NULL,
  `night_weather` varchar(32) DEFAULT NULL,
  `night_wind` varchar(32) DEFAULT NULL,
  `min_temp` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`district`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather`
--

LOCK TABLES `weather` WRITE;
/*!40000 ALTER TABLE `weather` DISABLE KEYS */;
INSERT INTO `weather` VALUES ('2020-04-30 11:03:14','永州','东安','多云','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','怀化','中方','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','郴州','临武','多云','南风<3级',30.00,'多云','南风<3级',19.00),('2020-04-30 11:03:14','岳阳','临湘','阵雨','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','常德','临澧','多云','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 11:03:14','岳阳','云溪','阵雨','南风<3级',30.00,'阵雨','南风<3级',23.00),('2020-04-30 11:03:14','怀化','会同','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','湘西','保靖','阵雨','东北风<3级',24.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','娄底','冷水江','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','永州','冷水滩','多云','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','湘西','凤凰','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','邵阳','北塔','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','郴州','北湖','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','岳阳','华容','阵雨','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','益阳','南县','多云','北风<3级',28.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','衡阳','南岳','多云','南风3-4级',24.00,'阵雨','南风3-4级',18.00),('2020-04-30 11:03:14','娄底','双峰','多云','南风<3级',31.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','邵阳','双清','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','永州','双牌','多云','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','湘西','古丈','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','湘西','吉首','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','岳阳','君山','阵雨','南风<3级',30.00,'阵雨','南风<3级',23.00),('2020-04-30 11:03:14','郴州','嘉禾','多云','南风<3级',31.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','邵阳','城步','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','邵阳','大祥','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','株洲','天元','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','长沙','天心','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','娄底','娄底','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','娄底','娄星','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','长沙','宁乡','多云','西南风<3级',31.00,'阵雨','西南风<3级',20.00),('2020-04-30 11:03:14','永州','宁远','多云','南风<3级',29.00,'多云','南风<3级',19.00),('2020-04-30 11:03:14','常德','安乡','多云','南风<3级',29.00,'阵雨','南风<3级',19.00),('2020-04-30 11:03:14','郴州','安仁','多云','南风<3级',31.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','益阳','安化','阵雨','北风<3级',27.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','郴州','宜章','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','湘潭','岳塘','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 11:03:14','岳阳','岳阳','阵雨','南风<3级',30.00,'阵雨','南风<3级',23.00),('2020-04-30 11:03:14','岳阳','岳阳楼区','阵雨','南风<3级',30.00,'阵雨','南风<3级',23.00),('2020-04-30 11:03:14','长沙','岳麓','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','衡阳','常宁','多云','南风<3级',31.00,'多云','南风<3级',23.00),('2020-04-30 11:03:14','常德','常德','阵雨','南风<3级',29.00,'阵雨','南风<3级',17.00),('2020-04-30 11:03:14','岳阳','平江','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','长沙','开福','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','张家界','张家界','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 11:03:14','怀化','怀化','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','张家界','慈利','小雨','东北风<3级',24.00,'多云','东北风<3级',17.00),('2020-04-30 11:03:14','株洲','攸县','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','娄底','新化','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','邵阳','新宁','多云','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','怀化','新晃','多云','南风<3级',31.00,'阵雨','南风<3级',19.00),('2020-04-30 11:03:14','永州','新田','多云','南风<3级',29.00,'多云','南风<3级',19.00),('2020-04-30 11:03:14','邵阳','新邵','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','长沙','望城','多云','西南风<3级',31.00,'阵雨','西南风<3级',20.00),('2020-04-30 11:03:14','株洲','株洲','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','郴州','桂东','多云','南风<3级',28.00,'多云','南风<3级',15.00),('2020-04-30 11:03:14','郴州','桂阳','多云','南风<3级',30.00,'多云','南风<3级',23.00),('2020-04-30 11:03:14','益阳','桃江','多云','北风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','常德','桃源','多云','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 11:03:14','张家界','桑植','小雨','东北风<3级',23.00,'多云','东北风<3级',16.00),('2020-04-30 11:03:14','邵阳','武冈','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','常德','武陵','阵雨','南风<3级',29.00,'阵雨','南风<3级',17.00),('2020-04-30 11:03:14','张家界','武陵源','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 11:03:14','郴州','永兴','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','张家界','永定','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 11:03:14','永州','永州','多云','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','湘西','永顺','阵雨','东北风<3级',24.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','常德','汉寿','多云','南风<3级',30.00,'阵雨','南风<3级',19.00),('2020-04-30 11:03:14','郴州','汝城','多云','南风<3级',28.00,'多云','南风<3级',17.00),('2020-04-30 11:03:14','永州','江华','多云','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','永州','江永','多云','南风<3级',28.00,'多云','南风<3级',19.00),('2020-04-30 11:03:14','岳阳','汨罗','阵雨','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','益阳','沅江','多云','北风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','怀化','沅陵','阵雨','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','湘西','泸溪','阵雨','东北风<3级',27.00,'阴','东北风<3级',20.00),('2020-04-30 11:03:14','邵阳','洞口','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','常德','津市','多云','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 11:03:14','怀化','洪江','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','长沙','浏阳','多云','西南风<3级',32.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','娄底','涟源','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','湘潭','湘乡','多云','南风<3级',31.00,'阵雨','南风<3级',21.00),('2020-04-30 11:03:14','长沙','湘江新区','多云','西南风3-4级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','湘潭','湘潭','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 11:03:14','湘西','湘西','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 11:03:14','岳阳','湘阴','阵雨','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','怀化','溆浦','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','常德','澧县','阵雨','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 11:03:14','株洲','炎陵','多云','南风<3级',31.00,'多云','南风<3级',17.00),('2020-04-30 11:03:14','衡阳','珠晖','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','益阳','益阳','多云','北风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','株洲','石峰','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','常德','石门','阵雨','南风<3级',29.00,'阵雨','南风<3级',19.00),('2020-04-30 11:03:14','衡阳','石鼓','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','衡阳','祁东','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 11:03:14','永州','祁阳','多云','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','邵阳','绥宁','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','衡阳','耒阳','多云','南风<3级',31.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','长沙','芙蓉','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','株洲','芦淞','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','湘西','花垣','阵雨','东北风<3级',24.00,'阴','东北风<3级',19.00),('2020-04-30 11:03:14','怀化','芷江','多云','南风<3级',31.00,'阵雨','南风<3级',19.00),('2020-04-30 11:03:14','郴州','苏仙','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','株洲','茶陵','多云','南风<3级',31.00,'多云','南风<3级',19.00),('2020-04-30 11:03:14','株洲','荷塘','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','衡阳','蒸湘','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','永州','蓝山','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','衡阳','衡东','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','衡阳','衡南','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','衡阳','衡山','多云','南风3-4级',30.00,'阵雨','南风3-4级',22.00),('2020-04-30 11:03:14','衡阳','衡阳','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','衡阳','衡阳县','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','郴州','资兴','多云','南风<3级',31.00,'多云','南风<3级',23.00),('2020-04-30 11:03:14','益阳','资阳','多云','北风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','益阳','赫山区','多云','北风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','怀化','辰溪','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','怀化','通道','多云','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','永州','道县','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','邵阳','邵东','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','邵阳','邵阳','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','邵阳','邵阳县','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','郴州','郴州','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 11:03:14','株洲','醴陵','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 11:03:14','长沙','长沙','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','长沙','长沙县','多云','西南风<3级',32.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','邵阳','隆回','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 11:03:14','衡阳','雁峰','多云','南风<3级',30.00,'阵雨','南风<3级',22.00),('2020-04-30 11:03:14','湘潭','雨湖','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 11:03:14','长沙','雨花','多云','西南风<3级',31.00,'阵雨','西南风<3级',21.00),('2020-04-30 11:03:14','永州','零陵','多云','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 11:03:14','怀化','靖州','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','湘潭','韶山','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','怀化','鹤城','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','怀化','麻阳','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 11:03:14','常德','鼎城','阵雨','南风<3级',29.00,'阵雨','南风<3级',17.00),('2020-04-30 11:03:14','湘西','龙山','中雨','东北风<3级',23.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','永州','东安','阵雨','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','怀化','中方','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','郴州','临武','多云','南风<3级',30.00,'多云','南风<3级',19.00),('2020-04-30 17:25:54','岳阳','临湘','阵雨','南风<3级',30.00,'大雨','南风<3级',22.00),('2020-04-30 17:25:54','常德','临澧','阵雨','南风<3级',28.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','岳阳','云溪','阵雨','南风<3级',28.00,'中雨','南风<3级',23.00),('2020-04-30 17:25:54','怀化','会同','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','湘西','保靖','阵雨','东北风<3级',24.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','娄底','冷水江','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','永州','冷水滩','阵雨','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','湘西','凤凰','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','邵阳','北塔','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','郴州','北湖','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','岳阳','华容','阵雨','南风<3级',29.00,'中雨','南风<3级',22.00),('2020-04-30 17:25:54','益阳','南县','多云','北风<3级',28.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','衡阳','南岳','多云','南风3-4级',23.00,'阵雨','南风3-4级',18.00),('2020-04-30 17:25:54','娄底','双峰','多云','南风<3级',31.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','邵阳','双清','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','永州','双牌','阵雨','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','湘西','古丈','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','湘西','吉首','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','岳阳','君山','阵雨','南风<3级',28.00,'中雨','南风<3级',23.00),('2020-04-30 17:25:54','郴州','嘉禾','多云','南风<3级',31.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','邵阳','城步','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','邵阳','大祥','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','株洲','天元','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','长沙','天心','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','娄底','娄底','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','娄底','娄星','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','长沙','宁乡','多云','西南风<3级',30.00,'阵雨','西南风<3级',20.00),('2020-04-30 17:25:54','永州','宁远','阵雨','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','常德','安乡','多云','南风<3级',29.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','郴州','安仁','多云','南风<3级',31.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','益阳','安化','阵雨','北风<3级',27.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','郴州','宜章','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','湘潭','岳塘','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','岳阳','岳阳','阵雨','南风<3级',28.00,'中雨','南风<3级',23.00),('2020-04-30 17:25:54','岳阳','岳阳楼区','阵雨','南风<3级',28.00,'中雨','南风<3级',23.00),('2020-04-30 17:25:54','长沙','岳麓','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','衡阳','常宁','多云','南风<3级',30.00,'多云','南风<3级',23.00),('2020-04-30 17:25:54','常德','常德','阵雨','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','岳阳','平江','多云','南风<3级',30.00,'中雨','南风<3级',20.00),('2020-04-30 17:25:54','长沙','开福','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','张家界','张家界','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 17:25:54','怀化','怀化','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','张家界','慈利','小雨','东北风<3级',24.00,'多云','东北风<3级',17.00),('2020-04-30 17:25:54','株洲','攸县','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','娄底','新化','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','邵阳','新宁','多云','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','怀化','新晃','多云','南风<3级',30.00,'阵雨','南风<3级',19.00),('2020-04-30 17:25:54','永州','新田','阵雨','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','邵阳','新邵','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','长沙','望城','多云','西南风<3级',30.00,'阵雨','西南风<3级',20.00),('2020-04-30 17:25:54','株洲','株洲','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','郴州','桂东','多云','南风<3级',28.00,'多云','南风<3级',15.00),('2020-04-30 17:25:54','郴州','桂阳','多云','南风<3级',30.00,'多云','南风<3级',23.00),('2020-04-30 17:25:54','益阳','桃江','多云','北风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','常德','桃源','多云','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','张家界','桑植','小雨','东北风<3级',23.00,'多云','东北风<3级',16.00),('2020-04-30 17:25:54','邵阳','武冈','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','常德','武陵','阵雨','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','张家界','武陵源','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 17:25:54','郴州','永兴','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','张家界','永定','小雨','东北风<3级',23.00,'小雨','东北风<3级',17.00),('2020-04-30 17:25:54','永州','永州','阵雨','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','湘西','永顺','阵雨','东北风<3级',24.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','常德','汉寿','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','郴州','汝城','多云','南风<3级',28.00,'多云','南风<3级',17.00),('2020-04-30 17:25:54','永州','江华','阵雨','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','永州','江永','阵雨','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','岳阳','汨罗','多云','南风<3级',30.00,'中雨','南风<3级',22.00),('2020-04-30 17:25:54','益阳','沅江','多云','北风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','怀化','沅陵','阵雨','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','湘西','泸溪','阴','东北风<3级',27.00,'阴','东北风<3级',20.00),('2020-04-30 17:25:54','邵阳','洞口','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','常德','津市','阵雨','南风<3级',28.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','怀化','洪江','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','长沙','浏阳','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','娄底','涟源','多云','南风<3级',31.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','湘潭','湘乡','多云','南风<3级',31.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','长沙','湘江新区','多云','西南风3-4级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','湘潭','湘潭','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','湘西','湘西','阵雨','东北风<3级',26.00,'阴','东北风<3级',18.00),('2020-04-30 17:25:54','岳阳','湘阴','多云','南风<3级',30.00,'中雨','南风<3级',22.00),('2020-04-30 17:25:54','怀化','溆浦','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','常德','澧县','阵雨','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','株洲','炎陵','多云','南风<3级',31.00,'多云','南风<3级',17.00),('2020-04-30 17:25:54','衡阳','珠晖','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','益阳','益阳','多云','北风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','株洲','石峰','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','常德','石门','阵雨','南风<3级',28.00,'阵雨','南风<3级',19.00),('2020-04-30 17:25:54','衡阳','石鼓','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','衡阳','祁东','多云','南风<3级',29.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','永州','祁阳','阵雨','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','邵阳','绥宁','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','衡阳','耒阳','多云','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','长沙','芙蓉','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','株洲','芦淞','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','湘西','花垣','阵雨','东北风<3级',24.00,'阴','东北风<3级',19.00),('2020-04-30 17:25:54','怀化','芷江','多云','南风<3级',30.00,'阵雨','南风<3级',19.00),('2020-04-30 17:25:54','郴州','苏仙','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','株洲','茶陵','多云','南风<3级',31.00,'多云','南风<3级',19.00),('2020-04-30 17:25:54','株洲','荷塘','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','衡阳','蒸湘','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','永州','蓝山','阵雨','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','衡阳','衡东','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','衡阳','衡南','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','衡阳','衡山','多云','南风3-4级',29.00,'阵雨','南风3-4级',22.00),('2020-04-30 17:25:54','衡阳','衡阳','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','衡阳','衡阳县','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','郴州','资兴','多云','南风<3级',31.00,'多云','南风<3级',23.00),('2020-04-30 17:25:54','益阳','资阳','多云','北风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','益阳','赫山区','多云','北风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','怀化','辰溪','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','怀化','通道','多云','南风<3级',29.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','永州','道县','阵雨','南风<3级',30.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','邵阳','邵东','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','邵阳','邵阳','多云','南风<3级',30.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','邵阳','邵阳县','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','郴州','郴州','多云','南风<3级',29.00,'多云','南风<3级',22.00),('2020-04-30 17:25:54','株洲','醴陵','多云','南风<3级',30.00,'雷阵雨','南风<3级',20.00),('2020-04-30 17:25:54','长沙','长沙','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','长沙','长沙县','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','邵阳','隆回','多云','南风<3级',30.00,'多云','南风<3级',20.00),('2020-04-30 17:25:54','衡阳','雁峰','多云','南风<3级',29.00,'阵雨','南风<3级',22.00),('2020-04-30 17:25:54','湘潭','雨湖','多云','南风<3级',30.00,'阵雨','南风<3级',21.00),('2020-04-30 17:25:54','长沙','雨花','多云','西南风<3级',30.00,'阵雨','西南风<3级',21.00),('2020-04-30 17:25:54','永州','零陵','阵雨','南风<3级',29.00,'多云','南风<3级',21.00),('2020-04-30 17:25:54','怀化','靖州','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','湘潭','韶山','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','怀化','鹤城','多云','南风<3级',30.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','怀化','麻阳','多云','南风<3级',31.00,'阵雨','南风<3级',20.00),('2020-04-30 17:25:54','常德','鼎城','阵雨','南风<3级',29.00,'阵雨','南风<3级',18.00),('2020-04-30 17:25:54','湘西','龙山','中雨','东北风<3级',23.00,'阴','东北风<3级',18.00);
/*!40000 ALTER TABLE `weather` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-18 10:20:59
