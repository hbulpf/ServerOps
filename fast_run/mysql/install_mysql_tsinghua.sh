#!/bin/bash
yum -y remove mariadb* #为防止和mariadb出现冲突，卸载mariadb相关
# 使用清华大学的源
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-libs-8.0.16-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-libs-8.0.16-2.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-common-8.0.16-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-common-8.0.16-2.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-devel-8.0.16-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-devel-8.0.16-2.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-client-8.0.16-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-client-8.0.16-2.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-server-8.0.16-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql80-community-el7/mysql-community-server-8.0.16-2.el7.x86_64.rpm
systemctl start  mysqld.service
systemctl status mysqld.service
grep "password" /var/log/mysqld.log
mysql -uroot -p     # 回车后会提示输入密码上面显示的密码
# 设置数据库密码(需手动执行)
# mysql> 
# set global validate_password_policy=0;
# set global validate_password_length=1;
# ALTER USER 'root'@'localhost' IDENTIFIED BY '数据库密码';
# grant all on *.* to root@'%' identified by '数据库密码';
# grant all privileges on *.* to 'root'@'%' with grant option;  