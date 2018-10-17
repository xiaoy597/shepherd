/*
Navicat MySQL Data Transfer

Source Server         : mysq-local
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : spider_data

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-17 14:11:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sina_image
-- ----------------------------
DROP TABLE IF EXISTS `sina_image`;
CREATE TABLE `sina_image` (
  `collect_time` datetime NOT NULL,
  `title` varchar(256) NOT NULL,
  `image_url` varchar(512) NOT NULL,
  `image_path` varchar(512) NOT NULL,
  `description` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`collect_time`,`image_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sina_news
-- ----------------------------
DROP TABLE IF EXISTS `sina_news`;
CREATE TABLE `sina_news` (
  `collect_time` datetime NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`collect_time`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for slsj_article
-- ----------------------------
DROP TABLE IF EXISTS `slsj_article`;
CREATE TABLE `slsj_article` (
  `collect_time` datetime NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`collect_time`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sse_fund_overview
-- ----------------------------
DROP TABLE IF EXISTS `sse_fund_overview`;
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

-- ----------------------------
-- Table structure for sse_stock_overview
-- ----------------------------
DROP TABLE IF EXISTS `sse_stock_overview`;
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

-- ----------------------------
-- Table structure for stock_price
-- ----------------------------
DROP TABLE IF EXISTS `stock_price`;
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

-- ----------------------------
-- Table structure for szse_market_overview
-- ----------------------------
DROP TABLE IF EXISTS `szse_market_overview`;
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

-- ----------------------------
-- Table structure for weather
-- ----------------------------
DROP TABLE IF EXISTS `weather`;
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
