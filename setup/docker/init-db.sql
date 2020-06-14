create database spiderdb default character set 'utf8mb4';
create database spider_data default character set 'utf8mb4';
grant all on spiderdb.* to 'root'@'%';
grant all on spider_data.* to 'root'@'%';
flush privileges;

use spiderdb;
source /sample-data/spiderdb.sql;
use spider_data;
source /sample-data/spider_data.sql;

