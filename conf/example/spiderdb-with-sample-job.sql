/*
Navicat MySQL Data Transfer

Source Server         : mysq-local
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : spiderdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-17 14:11:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_module
-- ----------------------------
DROP TABLE IF EXISTS `app_module`;
CREATE TABLE `app_module` (
  `module_id` int(11) NOT NULL,
  `super_module_id` int(11) DEFAULT NULL,
  `module_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_module
-- ----------------------------

-- ----------------------------
-- Table structure for crawl_config
-- ----------------------------
DROP TABLE IF EXISTS `crawl_config`;
CREATE TABLE `crawl_config` (
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `param_name` varchar(40) NOT NULL,
  `param_value` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`job_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crawl_config
-- ----------------------------
INSERT INTO `crawl_config` VALUES ('1', '1', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '2', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '3', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '4', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '5', 'http_header_1', 'Host: query.sse.com.cn');
INSERT INTO `crawl_config` VALUES ('1', '5', 'http_header_2', 'Referer: http://www.sse.com.cn/market/stockdata/overview/day/');
INSERT INTO `crawl_config` VALUES ('1', '5', 'json_extract_group', '1');
INSERT INTO `crawl_config` VALUES ('1', '5', 'json_extract_pattern', 'jsonpCallback\\d+\\(([^)]+)\\)');
INSERT INTO `crawl_config` VALUES ('1', '5', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '5', 'start_url_pattern', 'http://query.sse.com.cn/marketdata/tradedata/queryTradingByProdTypeData.do?jsonCallBack=jsonpCallback46192&searchDate=${TRANS_DATE}&prodType=gp&_=1505878067773');
INSERT INTO `crawl_config` VALUES ('1', '5', 'TRANS_DATE', 'range(2017-09-01, 2017-09-25)');
INSERT INTO `crawl_config` VALUES ('1', '6', 'http_header_1', 'Host: query.sse.com.cn');
INSERT INTO `crawl_config` VALUES ('1', '6', 'http_header_2', 'Referer: http://www.sse.com.cn/market/funddata/overview/day/');
INSERT INTO `crawl_config` VALUES ('1', '6', 'json_extract_group', '1');
INSERT INTO `crawl_config` VALUES ('1', '6', 'json_extract_pattern', 'jsonpCallback\\d+\\(([^)]+)\\)');
INSERT INTO `crawl_config` VALUES ('1', '6', 'request_type', 'get');
INSERT INTO `crawl_config` VALUES ('1', '6', 'start_url_pattern', 'http://query.sse.com.cn/marketdata/tradedata/queryTradingByProdTypeData.do?jsonCallBack=jsonpCallback72606&searchDate=${TRANS_DATE}&prodType=jj&_=1506064857871');
INSERT INTO `crawl_config` VALUES ('1', '6', 'TRANS_DATE', 'range(2017-09-01, 2017-09-25)');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_1', 'ACTIONID=7');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_2', 'AJAX=AJAX-TRUE');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_3', 'CATALOGID=1804');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_4', 'txtDate=${TRANS_DATE}');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_5', 'TABKEY=tab1');
INSERT INTO `crawl_config` VALUES ('1', '7', 'form_field_6', 'REPORT_ACTION=search');
INSERT INTO `crawl_config` VALUES ('1', '7', 'http_header_1', 'Host: www.szse.cn');
INSERT INTO `crawl_config` VALUES ('1', '7', 'http_header_2', 'Referer: http://www.szse.cn/main/marketdata/tjsj/jyjg/');
INSERT INTO `crawl_config` VALUES ('1', '7', 'request_type', 'post');
INSERT INTO `crawl_config` VALUES ('1', '7', 'TRANS_DATE', 'range(2017-09-18, 2017-09-22)');
INSERT INTO `crawl_config` VALUES ('1', '8', 'request_type', 'get');

-- ----------------------------
-- Table structure for crawl_host
-- ----------------------------
DROP TABLE IF EXISTS `crawl_host`;
CREATE TABLE `crawl_host` (
  `host_id` int(11) NOT NULL,
  `host_name` varchar(20) DEFAULT NULL,
  `host_ip` varchar(20) DEFAULT NULL,
  `host_status` int(11) DEFAULT NULL,
  `user_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crawl_host
-- ----------------------------
INSERT INTO `crawl_host` VALUES ('1', '采集服务器1', '127.0.0.1', '1', '0');

-- ----------------------------
-- Table structure for crawl_job
-- ----------------------------
DROP TABLE IF EXISTS `crawl_job`;
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

-- ----------------------------
-- Records of crawl_job
-- ----------------------------
INSERT INTO `crawl_job` VALUES ('1', '1', '新浪新闻', '1', '1', '0', '0', '1', '0', '0', '0', 'http://roll.news.sina.com.cn/s/channel.php#col=97&spec=&type=&ch=&k=&offset_page=0&offset_num=0&num=60&asc=&page=1', '1', '0');
INSERT INTO `crawl_job` VALUES ('2', '1', '天气预报', '0', '1', '0', '0', '1', '0', '0', '0', 'http://www.weather.com.cn/textFC/hunan.shtml', '1', '0');
INSERT INTO `crawl_job` VALUES ('3', '1', '新浪图片', '0', '1', '0', '0', '1', '0', '0', '0', 'http://slide.sports.sina.com.cn/', '1', '0');
INSERT INTO `crawl_job` VALUES ('4', '1', '新浪股票', '0', '1', '0', '0', '1', '0', '0', '0', 'http://finance.sina.com.cn/realstock/company/sz000651/nc.shtml', '1', '0');
INSERT INTO `crawl_job` VALUES ('5', '1', '上交所股票成交量', '0', '1', '0', '0', '1', '0', '0', '0', null, '1', '0');
INSERT INTO `crawl_job` VALUES ('6', '1', '上交所基金成交量', '0', '1', '0', '0', '1', '0', '0', '0', null, '1', '0');
INSERT INTO `crawl_job` VALUES ('7', '1', '深交所证券成交量', '0', '1', '0', '0', '1', '0', '0', '0', 'http://www.szse.cn/szseWeb/FrontController.szse?randnum=0.30835385089340417', '1', '0');
INSERT INTO `crawl_job` VALUES ('8', '1', '丝路商机', '0', '1', '0', '0', '1', '0', '0', '0', 'http://www.xinhuanet.com/silkroad/slsj.htm', '1', '0');

-- ----------------------------
-- Table structure for crawl_job_category
-- ----------------------------
DROP TABLE IF EXISTS `crawl_job_category`;
CREATE TABLE `crawl_job_category` (
  `job_cat_id` int(11) NOT NULL,
  `job_cat_name` varchar(40) DEFAULT NULL,
  `super_cat_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crawl_job_category
-- ----------------------------

-- ----------------------------
-- Table structure for crawl_page
-- ----------------------------
DROP TABLE IF EXISTS `crawl_page`;
CREATE TABLE `crawl_page` (
  `page_url` varchar(128) NOT NULL,
  `download_time` date NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`page_url`,`download_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crawl_page
-- ----------------------------

-- ----------------------------
-- Table structure for crawl_page_config
-- ----------------------------
DROP TABLE IF EXISTS `crawl_page_config`;
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

-- ----------------------------
-- Records of crawl_page_config
-- ----------------------------
INSERT INTO `crawl_page_config` VALUES ('1', '1', '1', '新浪新闻列表', '1', '0', '1', '//div[@class=\"pagebox\"]/span[@class=\"pagebox_pre\"][last()]/a', '//div[@class=\"pagebox\"]', '0', '2', '0', '');
INSERT INTO `crawl_page_config` VALUES ('1', '2', '1', '省级天气预报', '0', '0', '0', '', '//div[@class=\"hanml\"]', '0', '0', '0', 'spider_data.weather');
INSERT INTO `crawl_page_config` VALUES ('1', '3', '1', '新浪图片列表', '1', '0', '1', '//span[@class=\"pagination\"]/a[@class=\"next\"]', '//span[@class=\"pagination\"]/a[@class=\"next\"]', '0', '2', '0', '');
INSERT INTO `crawl_page_config` VALUES ('1', '4', '1', '新浪股票行情', '1', '0', '1', '', '//h1[@id=\"stockName\"]', '2', '10', '0', 'spider_data.stock_price');
INSERT INTO `crawl_page_config` VALUES ('1', '5', '1', '上交所股票交易概况页面', '2', '0', '0', null, null, '0', '0', '0', 'spider_data.sse_stock_overview');
INSERT INTO `crawl_page_config` VALUES ('1', '6', '1', '上交所基金交易概况页面', '2', '0', '0', null, null, '0', '0', '0', 'spider_data.sse_fund_overview');
INSERT INTO `crawl_page_config` VALUES ('1', '7', '1', '深交所证券交易概况页面', '0', '0', '0', null, null, '0', '0', '0', 'spider_data.szse_market_overview');
INSERT INTO `crawl_page_config` VALUES ('1', '8', '1', '丝路商机首页', '0', '0', '0', null, null, '0', '0', '0', null);
INSERT INTO `crawl_page_config` VALUES ('2', '1', '1', '新浪新闻页面', '0', '0', '0', '', '//h1[@id=\"artibodyTitle\"]', '0', '0', '0', 'spider_data.sina_news');
INSERT INTO `crawl_page_config` VALUES ('2', '3', '1', '新浪图片页面', '1', '0', '0', '', '//div[@slide-type=\"title\"]/h2', '0', '0', '0', 'spider_data.sina_image');
INSERT INTO `crawl_page_config` VALUES ('2', '8', '1', '丝路商机文章', '0', '0', '0', null, null, '0', '0', '0', 'spider_data.slsj_article');

-- ----------------------------
-- Table structure for crawl_src_type
-- ----------------------------
DROP TABLE IF EXISTS `crawl_src_type`;
CREATE TABLE `crawl_src_type` (
  `crawl_src_type_id` int(11) NOT NULL,
  `crawl_src_type_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`crawl_src_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crawl_src_type
-- ----------------------------

-- ----------------------------
-- Table structure for crawl_status
-- ----------------------------
DROP TABLE IF EXISTS `crawl_status`;
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

-- ----------------------------
-- Records of crawl_status
-- ----------------------------
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:18:53', '2', '0', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:20:58', '2', '0', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:23:56', '2', '0', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:27:13', '2', '122', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:33:16', '2', '122', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 10:54:11', '2', '122', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 11:07:28', '2', '122', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 12:35:45', '2', '122', '0', '0');
INSERT INTO `crawl_status` VALUES ('1', '1', '2018-10-17 12:42:37', '2', '122', '0', '0');

-- ----------------------------
-- Table structure for data_store
-- ----------------------------
DROP TABLE IF EXISTS `data_store`;
CREATE TABLE `data_store` (
  `data_store_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `data_store_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`data_store_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_store
-- ----------------------------
INSERT INTO `data_store` VALUES ('1', '1', '0');

-- ----------------------------
-- Table structure for data_store_param
-- ----------------------------
DROP TABLE IF EXISTS `data_store_param`;
CREATE TABLE `data_store_param` (
  `data_store_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `param_name` varchar(20) NOT NULL,
  `param_value` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`data_store_id`,`user_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_store_param
-- ----------------------------
INSERT INTO `data_store_param` VALUES ('1', '1', 'host', 'localhost');
INSERT INTO `data_store_param` VALUES ('1', '1', 'passwd', 'root');
INSERT INTO `data_store_param` VALUES ('1', '1', 'port', '3306');
INSERT INTO `data_store_param` VALUES ('1', '1', 'user', 'root');

-- ----------------------------
-- Table structure for job_schedule
-- ----------------------------
DROP TABLE IF EXISTS `job_schedule`;
CREATE TABLE `job_schedule` (
  `job_schedule_id` int(11) NOT NULL,
  `job_schedule_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_schedule
-- ----------------------------
INSERT INTO `job_schedule` VALUES ('0', '0');
INSERT INTO `job_schedule` VALUES ('1', '1');
INSERT INTO `job_schedule` VALUES ('2', '2');

-- ----------------------------
-- Table structure for job_schedule_param
-- ----------------------------
DROP TABLE IF EXISTS `job_schedule_param`;
CREATE TABLE `job_schedule_param` (
  `job_schedule_id` int(11) NOT NULL,
  `param_name` varchar(20) NOT NULL,
  `param_value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`job_schedule_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_schedule_param
-- ----------------------------
INSERT INTO `job_schedule_param` VALUES ('0', 'time', '');
INSERT INTO `job_schedule_param` VALUES ('1', 'minutes', '30');
INSERT INTO `job_schedule_param` VALUES ('1', 'start_date', '2017-07-24 17:00:00');
INSERT INTO `job_schedule_param` VALUES ('2', 'second', '0');
INSERT INTO `job_schedule_param` VALUES ('2', 'start_date', '2017-07-24 17:00:00');

-- ----------------------------
-- Table structure for nstruct_ext_config
-- ----------------------------
DROP TABLE IF EXISTS `nstruct_ext_config`;
CREATE TABLE `nstruct_ext_config` (
  `nstruct_ext_rule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nstruct_ext_rule_name` varchar(40) DEFAULT NULL,
  `data_format` int(11) DEFAULT NULL,
  `data_store_type` int(11) DEFAULT NULL,
  `data_store_path` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`nstruct_ext_rule_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nstruct_ext_config
-- ----------------------------

-- ----------------------------
-- Table structure for nstruct_ext_page
-- ----------------------------
DROP TABLE IF EXISTS `nstruct_ext_page`;
CREATE TABLE `nstruct_ext_page` (
  `nstruct_ext_rule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nstruct_data_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`nstruct_ext_rule_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nstruct_ext_page
-- ----------------------------

-- ----------------------------
-- Table structure for nstruct_field
-- ----------------------------
DROP TABLE IF EXISTS `nstruct_field`;
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

-- ----------------------------
-- Records of nstruct_field
-- ----------------------------

-- ----------------------------
-- Table structure for page_field
-- ----------------------------
DROP TABLE IF EXISTS `page_field`;
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

-- ----------------------------
-- Records of page_field
-- ----------------------------
INSERT INTO `page_field` VALUES ('1', '1', '2', '1', 'city', '0', '0', '1');
INSERT INTO `page_field` VALUES ('1', '1', '4', '1', 'stock_name', '0', '0', '1');
INSERT INTO `page_field` VALUES ('1', '1', '5', '1', 'exchange_rate_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('1', '1', '6', '1', 'exchange_rate_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('1', '1', '7', '1', 'trd_date', '0', '0', '0');
INSERT INTO `page_field` VALUES ('1', '2', '1', '1', 'title', '0', '0', '1');
INSERT INTO `page_field` VALUES ('1', '2', '3', '1', 'title', '0', '0', '1');
INSERT INTO `page_field` VALUES ('1', '2', '8', '1', 'title', '0', '0', '0');
INSERT INTO `page_field` VALUES ('2', '1', '2', '1', 'district', '0', '1', '1');
INSERT INTO `page_field` VALUES ('2', '1', '4', '1', 'stock_id', '0', '0', '1');
INSERT INTO `page_field` VALUES ('2', '1', '5', '1', 'ist_vol_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('2', '1', '6', '1', 'ist_vol_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('2', '1', '7', '1', 'trd_amt_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('2', '2', '1', '1', 'content', '0', '0', '1');
INSERT INTO `page_field` VALUES ('2', '2', '3', '1', 'description', '0', '1', '0');
INSERT INTO `page_field` VALUES ('2', '2', '8', '1', 'content', '0', '0', '0');
INSERT INTO `page_field` VALUES ('3', '1', '2', '1', 'day_weather', '0', '1', '1');
INSERT INTO `page_field` VALUES ('3', '1', '4', '1', 'stock_time', '0', '0', '1');
INSERT INTO `page_field` VALUES ('3', '1', '5', '1', 'market_value_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('3', '1', '6', '1', 'market_value_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('3', '1', '7', '1', 'trd_vol_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('3', '2', '3', '1', 'image_url', '0', '1', '0');
INSERT INTO `page_field` VALUES ('4', '1', '2', '1', 'day_wind', '0', '1', '1');
INSERT INTO `page_field` VALUES ('4', '1', '4', '1', 'stock_price', '1', '0', '1');
INSERT INTO `page_field` VALUES ('4', '1', '5', '1', 'market_value1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('4', '1', '6', '1', 'market_value1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('4', '1', '7', '1', 'capital_stock_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('4', '2', '3', '1', 'image_path', '0', '1', '0');
INSERT INTO `page_field` VALUES ('5', '1', '2', '1', 'max_temp', '1', '1', '1');
INSERT INTO `page_field` VALUES ('5', '1', '4', '1', 'stock_open_price', '1', '0', '1');
INSERT INTO `page_field` VALUES ('5', '1', '5', '1', 'negotiable_value_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('5', '1', '6', '1', 'negotiable_value_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('5', '1', '7', '1', 'market_value_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('6', '1', '2', '1', 'night_weather', '0', '1', '1');
INSERT INTO `page_field` VALUES ('6', '1', '4', '1', 'stock_deal_num', '0', '0', '1');
INSERT INTO `page_field` VALUES ('6', '1', '5', '1', 'negotiable_value1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('6', '1', '6', '1', 'negotiable_value1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('6', '1', '7', '1', 'negotiable_stock_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('7', '1', '2', '1', 'night_wind', '0', '1', '1');
INSERT INTO `page_field` VALUES ('7', '1', '4', '1', 'stock_high_price', '1', '0', '1');
INSERT INTO `page_field` VALUES ('7', '1', '5', '1', 'product_type_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('7', '1', '6', '1', 'product_type_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('7', '1', '7', '1', 'negotiable_value_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('8', '1', '2', '1', 'min_temp', '1', '1', '1');
INSERT INTO `page_field` VALUES ('8', '1', '4', '1', 'stock_deal_amt', '0', '0', '1');
INSERT INTO `page_field` VALUES ('8', '1', '5', '1', 'profit_rate_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('8', '1', '6', '1', 'profit_rate_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('8', '1', '7', '1', 'trd_amt_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('9', '1', '4', '1', 'stock_exch_rate', '0', '0', '1');
INSERT INTO `page_field` VALUES ('9', '1', '5', '1', 'profit_rate1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('9', '1', '6', '1', 'profit_rate1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('9', '1', '7', '1', 'trd_vol_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('10', '1', '4', '1', 'stock_low_price', '1', '0', '1');
INSERT INTO `page_field` VALUES ('10', '1', '5', '1', 'search_date_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('10', '1', '6', '1', 'search_date_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('11', '1', '4', '1', 'stock_total_value', '0', '0', '1');
INSERT INTO `page_field` VALUES ('11', '1', '5', '1', 'trd_amt_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('11', '1', '6', '1', 'trd_amt_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('11', '1', '7', '1', 'capital_stock_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('12', '1', '4', '1', 'stock_pb', '0', '0', '1');
INSERT INTO `page_field` VALUES ('12', '1', '5', '1', 'trd_amt1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('12', '1', '6', '1', 'trd_amt1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('12', '1', '7', '1', 'market_value_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('13', '1', '4', '1', 'stock_close_price', '1', '0', '1');
INSERT INTO `page_field` VALUES ('13', '1', '5', '1', 'trd_tm_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('13', '1', '6', '1', 'trd_tm_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('13', '1', '7', '1', 'negotiable_stock_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('14', '1', '4', '1', 'stock_currency_value', '0', '0', '1');
INSERT INTO `page_field` VALUES ('14', '1', '5', '1', 'trd_tm1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('14', '1', '6', '1', 'trd_tm1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('14', '1', '7', '1', 'negotiable_value_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('15', '1', '4', '1', 'stock_pe', '0', '0', '1');
INSERT INTO `page_field` VALUES ('15', '1', '5', '1', 'trd_vol_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('15', '1', '6', '1', 'trd_vol_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('15', '1', '7', '1', 'trd_amt_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('16', '1', '5', '1', 'trd_vol1_a', '1', '0', '0');
INSERT INTO `page_field` VALUES ('16', '1', '6', '1', 'trd_vol1_cef', '1', '0', '0');
INSERT INTO `page_field` VALUES ('16', '1', '7', '1', 'trd_vol_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('17', '1', '7', '1', 'capital_stock_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('18', '1', '7', '1', 'market_value_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('19', '1', '7', '1', 'negotiable_stock_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('21', '1', '5', '1', 'exchange_rate_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('21', '1', '6', '1', 'exchange_rate_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('21', '1', '7', '1', 'negotiable_value_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('22', '1', '5', '1', 'ist_vol_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('22', '1', '6', '1', 'ist_vol_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('22', '1', '7', '1', 'trd_amt_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('23', '1', '5', '1', 'market_value_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('23', '1', '6', '1', 'market_value_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('23', '1', '7', '1', 'trd_vol_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('24', '1', '5', '1', 'market_value1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('24', '1', '6', '1', 'market_value1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('24', '1', '7', '1', 'capital_stock_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('25', '1', '5', '1', 'negotiable_value_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('25', '1', '6', '1', 'negotiable_value_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('25', '1', '7', '1', 'market_value_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('26', '1', '5', '1', 'negotiable_value1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('26', '1', '6', '1', 'negotiable_value1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('26', '1', '7', '1', 'negotiable_stock_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('27', '1', '5', '1', 'product_type_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('27', '1', '6', '1', 'product_type_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('27', '1', '7', '1', 'negotiable_value_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('28', '1', '5', '1', 'profit_rate_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('28', '1', '6', '1', 'profit_rate_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('28', '1', '7', '1', 'trd_amt_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('29', '1', '5', '1', 'profit_rate1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('29', '1', '6', '1', 'profit_rate1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('29', '1', '7', '1', 'trd_vol_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('30', '1', '5', '1', 'search_date_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('30', '1', '6', '1', 'search_date_sh', '0', '0', '0');
INSERT INTO `page_field` VALUES ('31', '1', '5', '1', 'trd_amt_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('31', '1', '6', '1', 'trd_amt_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('31', '1', '7', '1', 'capital_stock_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('32', '1', '5', '1', 'trd_amt1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('32', '1', '6', '1', 'trd_amt1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('32', '1', '7', '1', 'market_value_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('33', '1', '5', '1', 'trd_tm_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('33', '1', '6', '1', 'trd_tm_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('33', '1', '7', '1', 'negotiable_stock_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('34', '1', '5', '1', 'trd_tm1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('34', '1', '6', '1', 'trd_tm1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('34', '1', '7', '1', 'negotiable_value_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('35', '1', '5', '1', 'trd_vol_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('35', '1', '6', '1', 'trd_vol_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('35', '1', '7', '1', 'trd_amt_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('36', '1', '5', '1', 'trd_vol1_b', '1', '0', '0');
INSERT INTO `page_field` VALUES ('36', '1', '6', '1', 'trd_vol1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('36', '1', '7', '1', 'trd_vol_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('37', '1', '7', '1', 'capital_stock_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('38', '1', '7', '1', 'market_value_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('39', '1', '7', '1', 'negotiable_stock_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('41', '1', '5', '1', 'exchange_rate_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('41', '1', '6', '1', 'exchange_rate_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('41', '1', '7', '1', 'negotiable_value_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('42', '1', '5', '1', 'ist_vol_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('42', '1', '6', '1', 'ist_vol_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('42', '1', '7', '1', 'trd_amt_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('43', '1', '5', '1', 'market_value_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('43', '1', '6', '1', 'market_value_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('43', '1', '7', '1', 'trd_vol_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('44', '1', '5', '1', 'market_value1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('44', '1', '6', '1', 'market_value1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('44', '1', '7', '1', 'capital_stock_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('45', '1', '5', '1', 'negotiable_value_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('45', '1', '6', '1', 'negotiable_value_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('45', '1', '7', '1', 'market_value_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('46', '1', '5', '1', 'negotiable_value1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('46', '1', '6', '1', 'negotiable_value1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('46', '1', '7', '1', 'negotiable_stock_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('47', '1', '5', '1', 'product_type_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('47', '1', '6', '1', 'product_type_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('47', '1', '7', '1', 'negotiable_value_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('48', '1', '5', '1', 'profit_rate_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('48', '1', '6', '1', 'profit_rate_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('48', '1', '7', '1', 'trd_amt_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('49', '1', '5', '1', 'profit_rate1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('49', '1', '6', '1', 'profit_rate1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('49', '1', '7', '1', 'trd_vol_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('50', '1', '5', '1', 'search_date_sh', '0', '0', '0');
INSERT INTO `page_field` VALUES ('50', '1', '6', '1', 'search_date_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('51', '1', '5', '1', 'trd_amt_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('51', '1', '6', '1', 'trd_amt_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('51', '1', '7', '1', 'capital_stock_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('52', '1', '5', '1', 'trd_amt1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('52', '1', '6', '1', 'trd_amt1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('52', '1', '7', '1', 'market_value_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('53', '1', '5', '1', 'trd_tm_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('53', '1', '6', '1', 'trd_tm_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('53', '1', '7', '1', 'negotiable_stock_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('54', '1', '5', '1', 'trd_tm1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('54', '1', '6', '1', 'trd_tm1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('54', '1', '7', '1', 'negotiable_value_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('55', '1', '5', '1', 'trd_vol_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('55', '1', '6', '1', 'trd_vol_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('55', '1', '7', '1', 'trd_amt_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('56', '1', '5', '1', 'trd_vol1_sh', '1', '0', '0');
INSERT INTO `page_field` VALUES ('56', '1', '6', '1', 'trd_vol1_etf', '1', '0', '0');
INSERT INTO `page_field` VALUES ('56', '1', '7', '1', 'trd_vol_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('57', '1', '7', '1', 'capital_stock_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('58', '1', '7', '1', 'market_value_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('59', '1', '7', '1', 'negotiable_stock_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('61', '1', '6', '1', 'exchange_rate_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('61', '1', '7', '1', 'negotiable_value_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('62', '1', '6', '1', 'ist_vol_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('62', '1', '7', '1', 'trd_amt_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('63', '1', '6', '1', 'market_value_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('63', '1', '7', '1', 'trd_vol_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('64', '1', '6', '1', 'market_value1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('64', '1', '7', '1', 'capital_stock_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('65', '1', '6', '1', 'negotiable_value_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('65', '1', '7', '1', 'market_value_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('66', '1', '6', '1', 'negotiable_value1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('66', '1', '7', '1', 'negotiable_stock_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('67', '1', '6', '1', 'product_type_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('67', '1', '7', '1', 'negotiable_value_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('68', '1', '6', '1', 'profit_rate_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('68', '1', '7', '1', 'trd_amt_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('69', '1', '6', '1', 'profit_rate1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('69', '1', '7', '1', 'trd_vol_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('70', '1', '6', '1', 'search_date_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('71', '1', '6', '1', 'trd_amt_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('71', '1', '7', '1', 'capital_stock_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('72', '1', '6', '1', 'trd_amt1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('72', '1', '7', '1', 'market_value_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('73', '1', '6', '1', 'trd_tm_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('73', '1', '7', '1', 'negotiable_stock_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('74', '1', '6', '1', 'trd_tm1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('74', '1', '7', '1', 'negotiable_value_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('75', '1', '6', '1', 'trd_vol_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('75', '1', '7', '1', 'trd_amt_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('76', '1', '6', '1', 'trd_vol1_lof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('76', '1', '7', '1', 'trd_vol_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('77', '1', '7', '1', 'capital_stock_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('78', '1', '7', '1', 'market_value_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('79', '1', '7', '1', 'negotiable_stock_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('81', '1', '6', '1', 'exchange_rate_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('81', '1', '7', '1', 'negotiable_value_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('82', '1', '6', '1', 'ist_vol_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('82', '1', '7', '1', 'trd_amt_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('83', '1', '6', '1', 'market_value_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('83', '1', '7', '1', 'trd_vol_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('84', '1', '6', '1', 'market_value1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('84', '1', '7', '1', 'capital_stock_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('85', '1', '6', '1', 'negotiable_value_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('85', '1', '7', '1', 'market_value_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('86', '1', '6', '1', 'negotiable_value1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('86', '1', '7', '1', 'negotiable_stock_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('87', '1', '6', '1', 'product_type_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('87', '1', '7', '1', 'negotiable_value_conv_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('88', '1', '6', '1', 'profit_rate_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('88', '1', '7', '1', 'count_a', '0', '0', '0');
INSERT INTO `page_field` VALUES ('89', '1', '6', '1', 'profit_rate1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('89', '1', '7', '1', 'count_b', '0', '0', '0');
INSERT INTO `page_field` VALUES ('90', '1', '6', '1', 'search_date_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('90', '1', '7', '1', 'count_sme', '0', '0', '0');
INSERT INTO `page_field` VALUES ('91', '1', '6', '1', 'trd_amt_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('91', '1', '7', '1', 'count_gem', '0', '0', '0');
INSERT INTO `page_field` VALUES ('92', '1', '6', '1', 'trd_amt1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('92', '1', '7', '1', 'count_lof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('93', '1', '6', '1', 'trd_tm_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('93', '1', '7', '1', 'count_etf', '0', '0', '0');
INSERT INTO `page_field` VALUES ('94', '1', '6', '1', 'trd_tm1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('94', '1', '7', '1', 'count_cef', '0', '0', '0');
INSERT INTO `page_field` VALUES ('95', '1', '6', '1', 'trd_vol_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('95', '1', '7', '1', 'count_slof', '0', '0', '0');
INSERT INTO `page_field` VALUES ('96', '1', '6', '1', 'trd_vol1_slof', '1', '0', '0');
INSERT INTO `page_field` VALUES ('96', '1', '7', '1', 'count_nat_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('97', '1', '7', '1', 'count_crp_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('98', '1', '7', '1', 'count_ent_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('99', '1', '7', '1', 'count_buy_bond', '0', '0', '0');
INSERT INTO `page_field` VALUES ('100', '1', '7', '1', 'count_conv_bond', '0', '0', '0');

-- ----------------------------
-- Table structure for page_field_locate
-- ----------------------------
DROP TABLE IF EXISTS `page_field_locate`;
CREATE TABLE `page_field_locate` (
  `field_locate_id` int(11) NOT NULL,
  `field_locate_pattern` varchar(512) DEFAULT NULL,
  `field_ext_pattern` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`field_locate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of page_field_locate
-- ----------------------------
INSERT INTO `page_field_locate` VALUES ('0', '/NULL', 'text');
INSERT INTO `page_field_locate` VALUES ('101', '//h1[@id=\"artibodyTitle\"]|//h1[@class=\"main-title\"]', 'self-text');
INSERT INTO `page_field_locate` VALUES ('102', '//div[@id=\"artibody\"]//p', 'text');
INSERT INTO `page_field_locate` VALUES ('201', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[1]/td[@class=\"rowsPan\"]', 'self-text');
INSERT INTO `page_field_locate` VALUES ('202', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][1]', 'text');
INSERT INTO `page_field_locate` VALUES ('203', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][2]', 'text');
INSERT INTO `page_field_locate` VALUES ('204', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][3]', 'text');
INSERT INTO `page_field_locate` VALUES ('205', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][4]', 'text');
INSERT INTO `page_field_locate` VALUES ('206', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][5]', 'text');
INSERT INTO `page_field_locate` VALUES ('207', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][6]', 'text');
INSERT INTO `page_field_locate` VALUES ('208', '//div[@class=\"hanml\"]/div[@class=\"conMidtab\"][1]/div[@class=\"conMidtab3\"][${FIELD_LEVEL_1_INDEX}]/table/tr[${FIELD_LEVEL_2_INDEX}]/td[not(@class=\"rowsPan\")][7]', 'text');
INSERT INTO `page_field_locate` VALUES ('301', '//div[@slide-type=\"title\"]/h2', 'text');
INSERT INTO `page_field_locate` VALUES ('302', '//div[@id=\"eData\"]/dl/dd[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('303', '//li[@slide-type=\"item\"]//img', '@src');
INSERT INTO `page_field_locate` VALUES ('304', '//li[@slide-type=\"item\"]/div[@slide-type=\"bigWrap\" and @data-src!=\"\"]', '@data-src');
INSERT INTO `page_field_locate` VALUES ('401', '//h1[@id=\"stockName\"]', 'self-text');
INSERT INTO `page_field_locate` VALUES ('402', '//h1[@id=\"stockName\"]/span', 'text');
INSERT INTO `page_field_locate` VALUES ('403', '//*[@id=\"hqTime\"]', 'text');
INSERT INTO `page_field_locate` VALUES ('404', '//*[@id=\"price\"]', 'text');
INSERT INTO `page_field_locate` VALUES ('405', '//div[@id=\"hqDetails\"]/table/tbody/tr[1]/td[1]', 'text');
INSERT INTO `page_field_locate` VALUES ('406', '//div[@id=\"hqDetails\"]/table/tbody/tr[1]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('407', '//div[@id=\"hqDetails\"]/table/tbody/tr[2]/td[1]', 'text');
INSERT INTO `page_field_locate` VALUES ('408', '//div[@id=\"hqDetails\"]/table/tbody/tr[2]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('409', '//div[@id=\"hqDetails\"]/table/tbody/tr[2]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('410', '//div[@id=\"hqDetails\"]/table/tbody/tr[3]/td[1]', 'text');
INSERT INTO `page_field_locate` VALUES ('411', '//div[@id=\"hqDetails\"]/table/tbody/tr[3]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('412', '//div[@id=\"hqDetails\"]/table/tbody/tr[3]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('413', '//div[@id=\"hqDetails\"]/table/tbody/tr[4]/td[1]', 'text');
INSERT INTO `page_field_locate` VALUES ('414', '//div[@id=\"hqDetails\"]/table/tbody/tr[4]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('415', '//div[@id=\"hqDetails\"]/table/tbody/tr[4]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('501', '[\'result\'][0][\'exchangeRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('502', '[\'result\'][0][\'istVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('503', '[\'result\'][0][\'marketValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('504', '[\'result\'][0][\'marketValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('505', '[\'result\'][0][\'negotiableValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('506', '[\'result\'][0][\'negotiableValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('507', '[\'result\'][0][\'productType\']', 'text');
INSERT INTO `page_field_locate` VALUES ('508', '[\'result\'][0][\'profitRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('509', '[\'result\'][0][\'profitRate1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('510', '[\'result\'][0][\'searchDate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('511', '[\'result\'][0][\'trdAmt\']', 'text');
INSERT INTO `page_field_locate` VALUES ('512', '[\'result\'][0][\'trdAmt1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('513', '[\'result\'][0][\'trdTm\']', 'text');
INSERT INTO `page_field_locate` VALUES ('514', '[\'result\'][0][\'trdTm1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('515', '[\'result\'][0][\'trdVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('516', '[\'result\'][0][\'trdVol1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('521', '[\'result\'][1][\'exchangeRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('522', '[\'result\'][1][\'istVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('523', '[\'result\'][1][\'marketValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('524', '[\'result\'][1][\'marketValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('525', '[\'result\'][1][\'negotiableValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('526', '[\'result\'][1][\'negotiableValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('527', '[\'result\'][1][\'productType\']', 'text');
INSERT INTO `page_field_locate` VALUES ('528', '[\'result\'][1][\'profitRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('529', '[\'result\'][1][\'profitRate1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('530', '[\'result\'][1][\'searchDate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('531', '[\'result\'][1][\'trdAmt\']', 'text');
INSERT INTO `page_field_locate` VALUES ('532', '[\'result\'][1][\'trdAmt1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('533', '[\'result\'][1][\'trdTm\']', 'text');
INSERT INTO `page_field_locate` VALUES ('534', '[\'result\'][1][\'trdTm1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('535', '[\'result\'][1][\'trdVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('536', '[\'result\'][1][\'trdVol1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('541', '[\'result\'][2][\'exchangeRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('542', '[\'result\'][2][\'istVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('543', '[\'result\'][2][\'marketValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('544', '[\'result\'][2][\'marketValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('545', '[\'result\'][2][\'negotiableValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('546', '[\'result\'][2][\'negotiableValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('547', '[\'result\'][2][\'productType\']', 'text');
INSERT INTO `page_field_locate` VALUES ('548', '[\'result\'][2][\'profitRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('549', '[\'result\'][2][\'profitRate1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('550', '[\'result\'][2][\'searchDate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('551', '[\'result\'][2][\'trdAmt\']', 'text');
INSERT INTO `page_field_locate` VALUES ('552', '[\'result\'][2][\'trdAmt1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('553', '[\'result\'][2][\'trdTm\']', 'text');
INSERT INTO `page_field_locate` VALUES ('554', '[\'result\'][2][\'trdTm1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('555', '[\'result\'][2][\'trdVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('556', '[\'result\'][2][\'trdVol1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('661', '[\'result\'][3][\'exchangeRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('662', '[\'result\'][3][\'istVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('663', '[\'result\'][3][\'marketValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('664', '[\'result\'][3][\'marketValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('665', '[\'result\'][3][\'negotiableValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('666', '[\'result\'][3][\'negotiableValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('667', '[\'result\'][3][\'productType\']', 'text');
INSERT INTO `page_field_locate` VALUES ('668', '[\'result\'][3][\'profitRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('669', '[\'result\'][3][\'profitRate1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('670', '[\'result\'][3][\'searchDate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('671', '[\'result\'][3][\'trdAmt\']', 'text');
INSERT INTO `page_field_locate` VALUES ('672', '[\'result\'][3][\'trdAmt1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('673', '[\'result\'][3][\'trdTm\']', 'text');
INSERT INTO `page_field_locate` VALUES ('674', '[\'result\'][3][\'trdTm1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('675', '[\'result\'][3][\'trdVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('676', '[\'result\'][3][\'trdVol1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('681', '[\'result\'][4][\'exchangeRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('682', '[\'result\'][4][\'istVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('683', '[\'result\'][4][\'marketValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('684', '[\'result\'][4][\'marketValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('685', '[\'result\'][4][\'negotiableValue\']', 'text');
INSERT INTO `page_field_locate` VALUES ('686', '[\'result\'][4][\'negotiableValue1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('687', '[\'result\'][4][\'productType\']', 'text');
INSERT INTO `page_field_locate` VALUES ('688', '[\'result\'][4][\'profitRate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('689', '[\'result\'][4][\'profitRate1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('690', '[\'result\'][4][\'searchDate\']', 'text');
INSERT INTO `page_field_locate` VALUES ('691', '[\'result\'][4][\'trdAmt\']', 'text');
INSERT INTO `page_field_locate` VALUES ('692', '[\'result\'][4][\'trdAmt1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('693', '[\'result\'][4][\'trdTm\']', 'text');
INSERT INTO `page_field_locate` VALUES ('694', '[\'result\'][4][\'trdTm1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('695', '[\'result\'][4][\'trdVol\']', 'text');
INSERT INTO `page_field_locate` VALUES ('696', '[\'result\'][4][\'trdVol1\']', 'text');
INSERT INTO `page_field_locate` VALUES ('701', '//span[@class=\"cls-subtitle\"]', 'text');
INSERT INTO `page_field_locate` VALUES ('702', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('703', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('704', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('705', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('706', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('707', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('708', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('709', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('711', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('712', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('713', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('714', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('715', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('716', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('717', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('718', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('719', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('721', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('722', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('723', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('724', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('725', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('726', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('727', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('728', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('729', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('731', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('732', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('733', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('734', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('735', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('736', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('737', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('738', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('739', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('741', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('742', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('743', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('744', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('745', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('746', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('747', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('748', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('749', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('751', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('752', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('753', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('754', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('755', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('756', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('757', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('758', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('759', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('761', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('762', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('763', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('764', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('765', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('766', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('767', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('768', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('769', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('771', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('772', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('773', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('774', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('775', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('776', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('777', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('778', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('779', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('781', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('782', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[3]', 'text');
INSERT INTO `page_field_locate` VALUES ('783', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[4]', 'text');
INSERT INTO `page_field_locate` VALUES ('784', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[5]', 'text');
INSERT INTO `page_field_locate` VALUES ('785', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[6]', 'text');
INSERT INTO `page_field_locate` VALUES ('786', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[7]', 'text');
INSERT INTO `page_field_locate` VALUES ('787', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[8]', 'text');
INSERT INTO `page_field_locate` VALUES ('788', '//table[@id=\"REPORTID_tab1\"]/tr[3]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('789', '//table[@id=\"REPORTID_tab1\"]/tr[4]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('790', '//table[@id=\"REPORTID_tab1\"]/tr[5]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('791', '//table[@id=\"REPORTID_tab1\"]/tr[6]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('792', '//table[@id=\"REPORTID_tab1\"]/tr[8]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('793', '//table[@id=\"REPORTID_tab1\"]/tr[9]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('794', '//table[@id=\"REPORTID_tab1\"]/tr[11]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('795', '//table[@id=\"REPORTID_tab1\"]/tr[10]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('796', '//table[@id=\"REPORTID_tab1\"]/tr[13]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('797', '//table[@id=\"REPORTID_tab1\"]/tr[14]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('798', '//table[@id=\"REPORTID_tab1\"]/tr[15]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('799', '//table[@id=\"REPORTID_tab1\"]/tr[16]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('800', '//table[@id=\"REPORTID_tab1\"]/tr[17]/td[2]', 'text');
INSERT INTO `page_field_locate` VALUES ('1001', '//div[@class=\"h-title\"]|//h1[@id=\"title\"]|//span[@id=\"title\"]|//div[@id=\"title\"]|//div[@id=\"Title\"]', 'text');
INSERT INTO `page_field_locate` VALUES ('1002', '//div[@id=\"p-detail\"]|//div[@class=\"article\"]|//div[@id=\"content\"]|//div[@class=\"content\"]//div[@id=\"Content\"]', 'text');

-- ----------------------------
-- Table structure for page_field_locate_relation
-- ----------------------------
DROP TABLE IF EXISTS `page_field_locate_relation`;
CREATE TABLE `page_field_locate_relation` (
  `field_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_locate_id` int(11) NOT NULL,
  PRIMARY KEY (`field_id`,`page_id`,`job_id`,`user_id`,`field_locate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of page_field_locate_relation
-- ----------------------------
INSERT INTO `page_field_locate_relation` VALUES ('1', '1', '2', '1', '201');
INSERT INTO `page_field_locate_relation` VALUES ('1', '1', '4', '1', '401');
INSERT INTO `page_field_locate_relation` VALUES ('1', '1', '5', '1', '501');
INSERT INTO `page_field_locate_relation` VALUES ('1', '1', '6', '1', '501');
INSERT INTO `page_field_locate_relation` VALUES ('1', '1', '7', '1', '701');
INSERT INTO `page_field_locate_relation` VALUES ('1', '2', '1', '1', '101');
INSERT INTO `page_field_locate_relation` VALUES ('1', '2', '3', '1', '301');
INSERT INTO `page_field_locate_relation` VALUES ('1', '2', '8', '1', '1001');
INSERT INTO `page_field_locate_relation` VALUES ('2', '1', '2', '1', '202');
INSERT INTO `page_field_locate_relation` VALUES ('2', '1', '4', '1', '402');
INSERT INTO `page_field_locate_relation` VALUES ('2', '1', '5', '1', '502');
INSERT INTO `page_field_locate_relation` VALUES ('2', '1', '6', '1', '502');
INSERT INTO `page_field_locate_relation` VALUES ('2', '1', '7', '1', '702');
INSERT INTO `page_field_locate_relation` VALUES ('2', '2', '1', '1', '102');
INSERT INTO `page_field_locate_relation` VALUES ('2', '2', '3', '1', '302');
INSERT INTO `page_field_locate_relation` VALUES ('2', '2', '8', '1', '1002');
INSERT INTO `page_field_locate_relation` VALUES ('3', '1', '2', '1', '203');
INSERT INTO `page_field_locate_relation` VALUES ('3', '1', '4', '1', '403');
INSERT INTO `page_field_locate_relation` VALUES ('3', '1', '5', '1', '503');
INSERT INTO `page_field_locate_relation` VALUES ('3', '1', '6', '1', '503');
INSERT INTO `page_field_locate_relation` VALUES ('3', '1', '7', '1', '703');
INSERT INTO `page_field_locate_relation` VALUES ('3', '2', '3', '1', '303');
INSERT INTO `page_field_locate_relation` VALUES ('3', '2', '3', '1', '304');
INSERT INTO `page_field_locate_relation` VALUES ('4', '1', '2', '1', '204');
INSERT INTO `page_field_locate_relation` VALUES ('4', '1', '4', '1', '404');
INSERT INTO `page_field_locate_relation` VALUES ('4', '1', '5', '1', '504');
INSERT INTO `page_field_locate_relation` VALUES ('4', '1', '6', '1', '504');
INSERT INTO `page_field_locate_relation` VALUES ('4', '1', '7', '1', '704');
INSERT INTO `page_field_locate_relation` VALUES ('4', '2', '3', '1', '0');
INSERT INTO `page_field_locate_relation` VALUES ('5', '1', '2', '1', '205');
INSERT INTO `page_field_locate_relation` VALUES ('5', '1', '4', '1', '405');
INSERT INTO `page_field_locate_relation` VALUES ('5', '1', '5', '1', '505');
INSERT INTO `page_field_locate_relation` VALUES ('5', '1', '6', '1', '505');
INSERT INTO `page_field_locate_relation` VALUES ('5', '1', '7', '1', '705');
INSERT INTO `page_field_locate_relation` VALUES ('6', '1', '2', '1', '206');
INSERT INTO `page_field_locate_relation` VALUES ('6', '1', '4', '1', '406');
INSERT INTO `page_field_locate_relation` VALUES ('6', '1', '5', '1', '506');
INSERT INTO `page_field_locate_relation` VALUES ('6', '1', '6', '1', '506');
INSERT INTO `page_field_locate_relation` VALUES ('6', '1', '7', '1', '706');
INSERT INTO `page_field_locate_relation` VALUES ('7', '1', '2', '1', '207');
INSERT INTO `page_field_locate_relation` VALUES ('7', '1', '4', '1', '407');
INSERT INTO `page_field_locate_relation` VALUES ('7', '1', '5', '1', '507');
INSERT INTO `page_field_locate_relation` VALUES ('7', '1', '6', '1', '507');
INSERT INTO `page_field_locate_relation` VALUES ('7', '1', '7', '1', '707');
INSERT INTO `page_field_locate_relation` VALUES ('8', '1', '2', '1', '208');
INSERT INTO `page_field_locate_relation` VALUES ('8', '1', '4', '1', '408');
INSERT INTO `page_field_locate_relation` VALUES ('8', '1', '5', '1', '508');
INSERT INTO `page_field_locate_relation` VALUES ('8', '1', '6', '1', '508');
INSERT INTO `page_field_locate_relation` VALUES ('8', '1', '7', '1', '708');
INSERT INTO `page_field_locate_relation` VALUES ('9', '1', '4', '1', '409');
INSERT INTO `page_field_locate_relation` VALUES ('9', '1', '5', '1', '509');
INSERT INTO `page_field_locate_relation` VALUES ('9', '1', '6', '1', '509');
INSERT INTO `page_field_locate_relation` VALUES ('9', '1', '7', '1', '709');
INSERT INTO `page_field_locate_relation` VALUES ('10', '1', '4', '1', '410');
INSERT INTO `page_field_locate_relation` VALUES ('10', '1', '5', '1', '510');
INSERT INTO `page_field_locate_relation` VALUES ('10', '1', '6', '1', '510');
INSERT INTO `page_field_locate_relation` VALUES ('11', '1', '4', '1', '411');
INSERT INTO `page_field_locate_relation` VALUES ('11', '1', '5', '1', '511');
INSERT INTO `page_field_locate_relation` VALUES ('11', '1', '6', '1', '511');
INSERT INTO `page_field_locate_relation` VALUES ('11', '1', '7', '1', '711');
INSERT INTO `page_field_locate_relation` VALUES ('12', '1', '4', '1', '412');
INSERT INTO `page_field_locate_relation` VALUES ('12', '1', '5', '1', '512');
INSERT INTO `page_field_locate_relation` VALUES ('12', '1', '6', '1', '512');
INSERT INTO `page_field_locate_relation` VALUES ('12', '1', '7', '1', '712');
INSERT INTO `page_field_locate_relation` VALUES ('13', '1', '4', '1', '413');
INSERT INTO `page_field_locate_relation` VALUES ('13', '1', '5', '1', '513');
INSERT INTO `page_field_locate_relation` VALUES ('13', '1', '6', '1', '513');
INSERT INTO `page_field_locate_relation` VALUES ('13', '1', '7', '1', '713');
INSERT INTO `page_field_locate_relation` VALUES ('14', '1', '4', '1', '414');
INSERT INTO `page_field_locate_relation` VALUES ('14', '1', '5', '1', '514');
INSERT INTO `page_field_locate_relation` VALUES ('14', '1', '6', '1', '514');
INSERT INTO `page_field_locate_relation` VALUES ('14', '1', '7', '1', '714');
INSERT INTO `page_field_locate_relation` VALUES ('15', '1', '4', '1', '415');
INSERT INTO `page_field_locate_relation` VALUES ('15', '1', '5', '1', '515');
INSERT INTO `page_field_locate_relation` VALUES ('15', '1', '6', '1', '515');
INSERT INTO `page_field_locate_relation` VALUES ('15', '1', '7', '1', '715');
INSERT INTO `page_field_locate_relation` VALUES ('16', '1', '5', '1', '516');
INSERT INTO `page_field_locate_relation` VALUES ('16', '1', '6', '1', '516');
INSERT INTO `page_field_locate_relation` VALUES ('16', '1', '7', '1', '716');
INSERT INTO `page_field_locate_relation` VALUES ('17', '1', '7', '1', '717');
INSERT INTO `page_field_locate_relation` VALUES ('18', '1', '7', '1', '718');
INSERT INTO `page_field_locate_relation` VALUES ('19', '1', '7', '1', '719');
INSERT INTO `page_field_locate_relation` VALUES ('21', '1', '5', '1', '521');
INSERT INTO `page_field_locate_relation` VALUES ('21', '1', '6', '1', '521');
INSERT INTO `page_field_locate_relation` VALUES ('21', '1', '7', '1', '721');
INSERT INTO `page_field_locate_relation` VALUES ('22', '1', '5', '1', '522');
INSERT INTO `page_field_locate_relation` VALUES ('22', '1', '6', '1', '522');
INSERT INTO `page_field_locate_relation` VALUES ('22', '1', '7', '1', '722');
INSERT INTO `page_field_locate_relation` VALUES ('23', '1', '5', '1', '523');
INSERT INTO `page_field_locate_relation` VALUES ('23', '1', '6', '1', '523');
INSERT INTO `page_field_locate_relation` VALUES ('23', '1', '7', '1', '723');
INSERT INTO `page_field_locate_relation` VALUES ('24', '1', '5', '1', '524');
INSERT INTO `page_field_locate_relation` VALUES ('24', '1', '6', '1', '524');
INSERT INTO `page_field_locate_relation` VALUES ('24', '1', '7', '1', '724');
INSERT INTO `page_field_locate_relation` VALUES ('25', '1', '5', '1', '525');
INSERT INTO `page_field_locate_relation` VALUES ('25', '1', '6', '1', '525');
INSERT INTO `page_field_locate_relation` VALUES ('25', '1', '7', '1', '725');
INSERT INTO `page_field_locate_relation` VALUES ('26', '1', '5', '1', '526');
INSERT INTO `page_field_locate_relation` VALUES ('26', '1', '6', '1', '526');
INSERT INTO `page_field_locate_relation` VALUES ('26', '1', '7', '1', '726');
INSERT INTO `page_field_locate_relation` VALUES ('27', '1', '5', '1', '527');
INSERT INTO `page_field_locate_relation` VALUES ('27', '1', '6', '1', '527');
INSERT INTO `page_field_locate_relation` VALUES ('27', '1', '7', '1', '727');
INSERT INTO `page_field_locate_relation` VALUES ('28', '1', '5', '1', '528');
INSERT INTO `page_field_locate_relation` VALUES ('28', '1', '6', '1', '528');
INSERT INTO `page_field_locate_relation` VALUES ('28', '1', '7', '1', '728');
INSERT INTO `page_field_locate_relation` VALUES ('29', '1', '5', '1', '529');
INSERT INTO `page_field_locate_relation` VALUES ('29', '1', '6', '1', '529');
INSERT INTO `page_field_locate_relation` VALUES ('29', '1', '7', '1', '729');
INSERT INTO `page_field_locate_relation` VALUES ('30', '1', '5', '1', '530');
INSERT INTO `page_field_locate_relation` VALUES ('30', '1', '6', '1', '530');
INSERT INTO `page_field_locate_relation` VALUES ('31', '1', '5', '1', '531');
INSERT INTO `page_field_locate_relation` VALUES ('31', '1', '6', '1', '531');
INSERT INTO `page_field_locate_relation` VALUES ('31', '1', '7', '1', '731');
INSERT INTO `page_field_locate_relation` VALUES ('32', '1', '5', '1', '532');
INSERT INTO `page_field_locate_relation` VALUES ('32', '1', '6', '1', '532');
INSERT INTO `page_field_locate_relation` VALUES ('32', '1', '7', '1', '732');
INSERT INTO `page_field_locate_relation` VALUES ('33', '1', '5', '1', '533');
INSERT INTO `page_field_locate_relation` VALUES ('33', '1', '6', '1', '533');
INSERT INTO `page_field_locate_relation` VALUES ('33', '1', '7', '1', '733');
INSERT INTO `page_field_locate_relation` VALUES ('34', '1', '5', '1', '534');
INSERT INTO `page_field_locate_relation` VALUES ('34', '1', '6', '1', '534');
INSERT INTO `page_field_locate_relation` VALUES ('34', '1', '7', '1', '734');
INSERT INTO `page_field_locate_relation` VALUES ('35', '1', '5', '1', '535');
INSERT INTO `page_field_locate_relation` VALUES ('35', '1', '6', '1', '535');
INSERT INTO `page_field_locate_relation` VALUES ('35', '1', '7', '1', '735');
INSERT INTO `page_field_locate_relation` VALUES ('36', '1', '5', '1', '536');
INSERT INTO `page_field_locate_relation` VALUES ('36', '1', '6', '1', '536');
INSERT INTO `page_field_locate_relation` VALUES ('36', '1', '7', '1', '736');
INSERT INTO `page_field_locate_relation` VALUES ('37', '1', '7', '1', '737');
INSERT INTO `page_field_locate_relation` VALUES ('38', '1', '7', '1', '738');
INSERT INTO `page_field_locate_relation` VALUES ('39', '1', '7', '1', '739');
INSERT INTO `page_field_locate_relation` VALUES ('41', '1', '5', '1', '541');
INSERT INTO `page_field_locate_relation` VALUES ('41', '1', '6', '1', '541');
INSERT INTO `page_field_locate_relation` VALUES ('41', '1', '7', '1', '741');
INSERT INTO `page_field_locate_relation` VALUES ('42', '1', '5', '1', '542');
INSERT INTO `page_field_locate_relation` VALUES ('42', '1', '6', '1', '542');
INSERT INTO `page_field_locate_relation` VALUES ('42', '1', '7', '1', '742');
INSERT INTO `page_field_locate_relation` VALUES ('43', '1', '5', '1', '543');
INSERT INTO `page_field_locate_relation` VALUES ('43', '1', '6', '1', '543');
INSERT INTO `page_field_locate_relation` VALUES ('43', '1', '7', '1', '743');
INSERT INTO `page_field_locate_relation` VALUES ('44', '1', '5', '1', '544');
INSERT INTO `page_field_locate_relation` VALUES ('44', '1', '6', '1', '544');
INSERT INTO `page_field_locate_relation` VALUES ('44', '1', '7', '1', '744');
INSERT INTO `page_field_locate_relation` VALUES ('45', '1', '5', '1', '545');
INSERT INTO `page_field_locate_relation` VALUES ('45', '1', '6', '1', '545');
INSERT INTO `page_field_locate_relation` VALUES ('45', '1', '7', '1', '745');
INSERT INTO `page_field_locate_relation` VALUES ('46', '1', '5', '1', '546');
INSERT INTO `page_field_locate_relation` VALUES ('46', '1', '6', '1', '546');
INSERT INTO `page_field_locate_relation` VALUES ('46', '1', '7', '1', '746');
INSERT INTO `page_field_locate_relation` VALUES ('47', '1', '5', '1', '547');
INSERT INTO `page_field_locate_relation` VALUES ('47', '1', '6', '1', '547');
INSERT INTO `page_field_locate_relation` VALUES ('47', '1', '7', '1', '747');
INSERT INTO `page_field_locate_relation` VALUES ('48', '1', '5', '1', '548');
INSERT INTO `page_field_locate_relation` VALUES ('48', '1', '6', '1', '548');
INSERT INTO `page_field_locate_relation` VALUES ('48', '1', '7', '1', '748');
INSERT INTO `page_field_locate_relation` VALUES ('49', '1', '5', '1', '549');
INSERT INTO `page_field_locate_relation` VALUES ('49', '1', '6', '1', '549');
INSERT INTO `page_field_locate_relation` VALUES ('49', '1', '7', '1', '749');
INSERT INTO `page_field_locate_relation` VALUES ('50', '1', '5', '1', '550');
INSERT INTO `page_field_locate_relation` VALUES ('50', '1', '6', '1', '550');
INSERT INTO `page_field_locate_relation` VALUES ('51', '1', '5', '1', '551');
INSERT INTO `page_field_locate_relation` VALUES ('51', '1', '6', '1', '551');
INSERT INTO `page_field_locate_relation` VALUES ('51', '1', '7', '1', '751');
INSERT INTO `page_field_locate_relation` VALUES ('52', '1', '5', '1', '552');
INSERT INTO `page_field_locate_relation` VALUES ('52', '1', '6', '1', '552');
INSERT INTO `page_field_locate_relation` VALUES ('52', '1', '7', '1', '752');
INSERT INTO `page_field_locate_relation` VALUES ('53', '1', '5', '1', '553');
INSERT INTO `page_field_locate_relation` VALUES ('53', '1', '6', '1', '553');
INSERT INTO `page_field_locate_relation` VALUES ('53', '1', '7', '1', '753');
INSERT INTO `page_field_locate_relation` VALUES ('54', '1', '5', '1', '554');
INSERT INTO `page_field_locate_relation` VALUES ('54', '1', '6', '1', '554');
INSERT INTO `page_field_locate_relation` VALUES ('54', '1', '7', '1', '754');
INSERT INTO `page_field_locate_relation` VALUES ('55', '1', '5', '1', '555');
INSERT INTO `page_field_locate_relation` VALUES ('55', '1', '6', '1', '555');
INSERT INTO `page_field_locate_relation` VALUES ('55', '1', '7', '1', '755');
INSERT INTO `page_field_locate_relation` VALUES ('56', '1', '5', '1', '556');
INSERT INTO `page_field_locate_relation` VALUES ('56', '1', '6', '1', '556');
INSERT INTO `page_field_locate_relation` VALUES ('56', '1', '7', '1', '756');
INSERT INTO `page_field_locate_relation` VALUES ('57', '1', '7', '1', '757');
INSERT INTO `page_field_locate_relation` VALUES ('58', '1', '7', '1', '758');
INSERT INTO `page_field_locate_relation` VALUES ('59', '1', '7', '1', '759');
INSERT INTO `page_field_locate_relation` VALUES ('61', '1', '6', '1', '661');
INSERT INTO `page_field_locate_relation` VALUES ('61', '1', '7', '1', '761');
INSERT INTO `page_field_locate_relation` VALUES ('62', '1', '6', '1', '662');
INSERT INTO `page_field_locate_relation` VALUES ('62', '1', '7', '1', '762');
INSERT INTO `page_field_locate_relation` VALUES ('63', '1', '6', '1', '663');
INSERT INTO `page_field_locate_relation` VALUES ('63', '1', '7', '1', '763');
INSERT INTO `page_field_locate_relation` VALUES ('64', '1', '6', '1', '664');
INSERT INTO `page_field_locate_relation` VALUES ('64', '1', '7', '1', '764');
INSERT INTO `page_field_locate_relation` VALUES ('65', '1', '6', '1', '665');
INSERT INTO `page_field_locate_relation` VALUES ('65', '1', '7', '1', '765');
INSERT INTO `page_field_locate_relation` VALUES ('66', '1', '6', '1', '666');
INSERT INTO `page_field_locate_relation` VALUES ('66', '1', '7', '1', '766');
INSERT INTO `page_field_locate_relation` VALUES ('67', '1', '6', '1', '667');
INSERT INTO `page_field_locate_relation` VALUES ('67', '1', '7', '1', '767');
INSERT INTO `page_field_locate_relation` VALUES ('68', '1', '6', '1', '668');
INSERT INTO `page_field_locate_relation` VALUES ('68', '1', '7', '1', '768');
INSERT INTO `page_field_locate_relation` VALUES ('69', '1', '6', '1', '669');
INSERT INTO `page_field_locate_relation` VALUES ('69', '1', '7', '1', '769');
INSERT INTO `page_field_locate_relation` VALUES ('70', '1', '6', '1', '670');
INSERT INTO `page_field_locate_relation` VALUES ('71', '1', '6', '1', '671');
INSERT INTO `page_field_locate_relation` VALUES ('71', '1', '7', '1', '771');
INSERT INTO `page_field_locate_relation` VALUES ('72', '1', '6', '1', '672');
INSERT INTO `page_field_locate_relation` VALUES ('72', '1', '7', '1', '772');
INSERT INTO `page_field_locate_relation` VALUES ('73', '1', '6', '1', '673');
INSERT INTO `page_field_locate_relation` VALUES ('73', '1', '7', '1', '773');
INSERT INTO `page_field_locate_relation` VALUES ('74', '1', '6', '1', '674');
INSERT INTO `page_field_locate_relation` VALUES ('74', '1', '7', '1', '774');
INSERT INTO `page_field_locate_relation` VALUES ('75', '1', '6', '1', '675');
INSERT INTO `page_field_locate_relation` VALUES ('75', '1', '7', '1', '775');
INSERT INTO `page_field_locate_relation` VALUES ('76', '1', '6', '1', '676');
INSERT INTO `page_field_locate_relation` VALUES ('76', '1', '7', '1', '776');
INSERT INTO `page_field_locate_relation` VALUES ('77', '1', '7', '1', '777');
INSERT INTO `page_field_locate_relation` VALUES ('78', '1', '7', '1', '778');
INSERT INTO `page_field_locate_relation` VALUES ('79', '1', '7', '1', '779');
INSERT INTO `page_field_locate_relation` VALUES ('81', '1', '6', '1', '681');
INSERT INTO `page_field_locate_relation` VALUES ('81', '1', '7', '1', '781');
INSERT INTO `page_field_locate_relation` VALUES ('82', '1', '6', '1', '682');
INSERT INTO `page_field_locate_relation` VALUES ('82', '1', '7', '1', '782');
INSERT INTO `page_field_locate_relation` VALUES ('83', '1', '6', '1', '683');
INSERT INTO `page_field_locate_relation` VALUES ('83', '1', '7', '1', '783');
INSERT INTO `page_field_locate_relation` VALUES ('84', '1', '6', '1', '684');
INSERT INTO `page_field_locate_relation` VALUES ('84', '1', '7', '1', '784');
INSERT INTO `page_field_locate_relation` VALUES ('85', '1', '6', '1', '685');
INSERT INTO `page_field_locate_relation` VALUES ('85', '1', '7', '1', '785');
INSERT INTO `page_field_locate_relation` VALUES ('86', '1', '6', '1', '686');
INSERT INTO `page_field_locate_relation` VALUES ('86', '1', '7', '1', '786');
INSERT INTO `page_field_locate_relation` VALUES ('87', '1', '6', '1', '687');
INSERT INTO `page_field_locate_relation` VALUES ('87', '1', '7', '1', '787');
INSERT INTO `page_field_locate_relation` VALUES ('88', '1', '6', '1', '688');
INSERT INTO `page_field_locate_relation` VALUES ('88', '1', '7', '1', '788');
INSERT INTO `page_field_locate_relation` VALUES ('89', '1', '6', '1', '689');
INSERT INTO `page_field_locate_relation` VALUES ('89', '1', '7', '1', '789');
INSERT INTO `page_field_locate_relation` VALUES ('90', '1', '6', '1', '690');
INSERT INTO `page_field_locate_relation` VALUES ('90', '1', '7', '1', '790');
INSERT INTO `page_field_locate_relation` VALUES ('91', '1', '6', '1', '691');
INSERT INTO `page_field_locate_relation` VALUES ('91', '1', '7', '1', '791');
INSERT INTO `page_field_locate_relation` VALUES ('92', '1', '6', '1', '692');
INSERT INTO `page_field_locate_relation` VALUES ('92', '1', '7', '1', '792');
INSERT INTO `page_field_locate_relation` VALUES ('93', '1', '6', '1', '693');
INSERT INTO `page_field_locate_relation` VALUES ('93', '1', '7', '1', '793');
INSERT INTO `page_field_locate_relation` VALUES ('94', '1', '6', '1', '694');
INSERT INTO `page_field_locate_relation` VALUES ('94', '1', '7', '1', '794');
INSERT INTO `page_field_locate_relation` VALUES ('95', '1', '6', '1', '695');
INSERT INTO `page_field_locate_relation` VALUES ('95', '1', '7', '1', '795');
INSERT INTO `page_field_locate_relation` VALUES ('96', '1', '6', '1', '696');
INSERT INTO `page_field_locate_relation` VALUES ('96', '1', '7', '1', '796');
INSERT INTO `page_field_locate_relation` VALUES ('97', '1', '7', '1', '797');
INSERT INTO `page_field_locate_relation` VALUES ('98', '1', '7', '1', '798');
INSERT INTO `page_field_locate_relation` VALUES ('99', '1', '7', '1', '799');
INSERT INTO `page_field_locate_relation` VALUES ('100', '1', '7', '1', '800');

-- ----------------------------
-- Table structure for page_link
-- ----------------------------
DROP TABLE IF EXISTS `page_link`;
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

-- ----------------------------
-- Records of page_link
-- ----------------------------
INSERT INTO `page_link` VALUES ('1', '1', '1', '1', '//div[@id=\"d_list\"]/ul/li/span[@class=\"c_tit\"]/a', '', '2');
INSERT INTO `page_link` VALUES ('1', '1', '3', '1', '//div[@node-type=\"items\"]//div[@class=\"bd\"]//a', '', '2');
INSERT INTO `page_link` VALUES ('1', '1', '8', '1', '/RETURNED_FROM_SPIDER_HELPER', 'http://.*', '2');

-- ----------------------------
-- Table structure for poxy_assign
-- ----------------------------
DROP TABLE IF EXISTS `poxy_assign`;
CREATE TABLE `poxy_assign` (
  `proxy_server_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`proxy_server_id`,`job_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poxy_assign
-- ----------------------------

-- ----------------------------
-- Table structure for poxy_server
-- ----------------------------
DROP TABLE IF EXISTS `poxy_server`;
CREATE TABLE `poxy_server` (
  `proxy_server_id` int(11) NOT NULL,
  `proxy_server_name` varchar(40) DEFAULT NULL,
  `proxy_server_ip` varchar(20) DEFAULT NULL,
  `proxy_user_name` varchar(40) DEFAULT NULL,
  `proxy_user_password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`proxy_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poxy_server
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  `reg_date` date DEFAULT NULL,
  `user_status` int(11) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'Test user 1', '0', '2017-07-01', '0', '2017-07-02 09:00:00');

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `user_group_id` int(11) NOT NULL,
  `user_group_name` varchar(40) DEFAULT NULL,
  `super_user_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_group
-- ----------------------------

-- ----------------------------
-- Table structure for user_group_member
-- ----------------------------
DROP TABLE IF EXISTS `user_group_member`;
CREATE TABLE `user_group_member` (
  `user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_group_member
-- ----------------------------

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_role_id` int(11) NOT NULL,
  `user_role_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for user_role_assign
-- ----------------------------
DROP TABLE IF EXISTS `user_role_assign`;
CREATE TABLE `user_role_assign` (
  `user_id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role_assign
-- ----------------------------

-- ----------------------------
-- Table structure for user_role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `user_role_privilege`;
CREATE TABLE `user_role_privilege` (
  `user_role_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `access_privilege` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`user_role_id`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role_privilege
-- ----------------------------
