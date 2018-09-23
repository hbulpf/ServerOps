#!/bin/bash

sudo yum -y update
#stop SELinux
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
sudo systemctl stop firewalld.service && sudo systemctl disable firewalld.service

#install mysql57
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-* --skip-broken #有冲突的软件跳过

#install Apache
sudo yum -y install httpd
sudo systemctl start httpd.service #启动
sudo systemctl enable httpd.service #开机启动
netstat -an |grep 80
#install php
sudo yum -y install php

#install php extensions
sudo yum -y install php-mysqlnd \
php-gd libjpeg* php-snmp php-ldap php-odbc php-pear \
php-xml php-xmlrpc php-mbstring php-bcmath php-mhash \
php-common php-ctype php-xml php-xmlreader php-xmlwriter \
php-session php-mbstring php-gettext php-ldap php-mysqli \
--skip-broken
sudo yum -y install \
wget telnet net-tools python-paramiko gcc \
gcc-c++ dejavu-sans-fonts python-setuptools \
python-devel sendmail mailx net-snmp \
net-snmp-devel net-snmp-utils freetype-devel \
libpng-devel perl unbound libtasn1-devel \
p11-kit-devel OpenIPMI unixODBC

sudo chmod o+w /etc/my.cnf
# set php config
sudo cat <<EOM >> /etc/my.cnf
innodb_file_per_table = 1
innodb_status_file = 1
innodb_buffer_pool_size = 1600M
innodb_flush_log_at_trx_commit = 2
innodb_log_buffer_size = 16M
innodb_log_file_size = 64M
innodb_support_xa = 0
default-storage-engine = innodb
bulk_insert_buffer_size = 8M
join_buffer_size = 16M
max_heap_table_size = 32M
tmp_table_size = 32M
max_tmp_tables = 48
read_buffer_size = 32M
read_rnd_buffer_size = 16M
key_buffer_size = 32M
thread_cache_size = 32
innodb_thread_concurrency = 8
innodb_flush_method = O_DIRECT
innodb_rollback_on_timeout = 1
query_cache_size = 16M
query_cache_limit = 16M
collation_server = utf8_bin
character_set_server = utf8
EOM
sudo chmod o-w /etc/my.cnf
cat /etc/my.cnf
#注：原则上 innodb_buffer_pool_size 需要设置为主机内存的 80%，
#innodb_log_buffer_size 建议设置为 32M，
#innodb_log_file_size 建议设置为 128M，
#innodb_buffer_pool_size的值必须是整数，例如主机内存是4G，那么innodb_buffer_pool_size可以设置为3G，而不能设置为3.2G

mkdir opt
cd ~/opt
sudo systemctl enable mysqld && sudo systemctl start mysqld
mysql_secure_installation #完成后输入mysql root密码

create database zabbix character set utf8; 
create user zabbix@'%' identified by 'hnbd@2018'; #创建用户和密码
grant all privileges on zabbix.* to zabbix@'%'; #赋权
flush privileges;
exit;

#install Zabbix source: http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/
sudo rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm 
#install Zabbix 
sudo yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-java-gateway zabbix-web
#import Zabbix info
cd /usr/share/doc/zabbix-server-mysql-3.0.20
zcat create.sql.gz | mysql -uzabbix zabbix -phnbd@2018

#set Zabbix Config
sudo vim /etc/zabbix/zabbix_server.conf 

#DBPassword 配置为第 12 步第 3 行中设置的自定义密码
# CacheSize=512M
# （CacheSize在371行）
# HistoryCacheSize=128M
# （HistoryCacheSize在397行）
# HistoryIndexCacheSize=128M
# （HistoryIndexCacheSize在405行）
# TrendCacheSize=128M
# （TrendCacheSize在414行）
# ValueCacheSize=256M
# （ValueCacheSize在425行）
# Timeout=30
# （Timeout在432)
# 其它参数保持默认值即可

# 如果需要监控VMware虚拟机，则还需要设置以下选项参数：
# StartVMwareCollectors=2
# （StartVMwareCollectors在272行
# VMwareCacheSize=256M
# （VMwareCacheSize 在298行）
# VMwareTimeout=300
# （VMwareTimeout在306行）

sudo vim /etc/httpd/conf.d/zabbix.conf
php_value max_execution_time 600
php_value memory_limit 256M
php_value post_max_size 32M
php_value upload_max_filesize 32M
php_value max_input_time 600
php_value always_populate_raw_post_data -1
php_value date.timezone Asia/Shanghai


#restart httpd and check port
sudo systemctl restart httpd
netstat -an |grep 80
#start Zabbix
sudo systemctl start zabbix-server
sudo systemctl enable zabbix-server
#check log of Zabbix
tailf  /var/log/zabbix/zabbix_server.log
#check dir of Zabbix
ls /usr/share/zabbix

# 启动后需要一些配置信息，这些信息填写后存储在/etc/zabbix/web/zabbix.conf.php 
# more /etc/zabbix/web/zabbix.conf.php 
# <?php
# // Zabbix GUI configuration file.
# global $DB;

# $DB['TYPE']     = 'MYSQL';
# $DB['SERVER']   = '132.232.42.144';
# $DB['PORT']     = '0';
# $DB['DATABASE'] = 'zabbix';
# $DB['USER']     = 'zabbix';
# $DB['PASSWORD'] = 'hnbd@2018';

# // Schema name. Used for IBM DB2 and PostgreSQL.
# $DB['SCHEMA'] = '';

# $ZBX_SERVER      = '132.232.42.144';
# $ZBX_SERVER_PORT = '10051';
# $ZBX_SERVER_NAME = '132_232_42_144';

# $IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
