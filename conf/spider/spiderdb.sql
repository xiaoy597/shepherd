/*
Navicat MySQL Data Transfer

Source Server         : mysq-local
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : spiderdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-17 14:10:31
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
-- Table structure for crawl_src_type
-- ----------------------------
DROP TABLE IF EXISTS `crawl_src_type`;
CREATE TABLE `crawl_src_type` (
  `crawl_src_type_id` int(11) NOT NULL,
  `crawl_src_type_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`crawl_src_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for job_schedule
-- ----------------------------
DROP TABLE IF EXISTS `job_schedule`;
CREATE TABLE `job_schedule` (
  `job_schedule_id` int(11) NOT NULL,
  `job_schedule_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for user_group_member
-- ----------------------------
DROP TABLE IF EXISTS `user_group_member`;
CREATE TABLE `user_group_member` (
  `user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for user_role_assign
-- ----------------------------
DROP TABLE IF EXISTS `user_role_assign`;
CREATE TABLE `user_role_assign` (
  `user_id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
