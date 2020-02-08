# mysql-server 安装
 mysql-server 安装脚本见 [install_mysql.sh](./install_mysql.sh)
```
#!/bin/bash
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm  #安装 Yum Repository
yum -y remove mariadb-libs #为防止和mariadb出现冲突，卸载mariadb相关
yum -y install mysql-community-server #使用yum安装MySQL
yum -y remove mysql57-community-release-el7-10.noarch #每次yum操作都会自动更新，需要把rpm卸载掉

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
```
 
>注意: 安装脚本中分两部分
1. 先安装 mysql-server  
2. 进入mysql命令行，设置root密码 

# 使用镜像源更快安装

```
#!/bin/bash
yum -y remove mariadb-libs #为防止和mariadb出现冲突，卸载mariadb相关
# 使用清华大学的源
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/mysql-community-common-5.7.29-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/mysql-community-libs-5.7.29-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/mysql-community-client-5.7.29-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/mysql-community-devel-5.7.29-1.el7.x86_64.rpm
yum -y install https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/mysql-community-server-5.7.29-1.el7.x86_64.rpm 
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
```
# 参考
1. [MySQL安装之yum安装 . https://www.cnblogs.com/brianzhu/p/8575243.html](https://www.cnblogs.com/brianzhu/p/8575243.html)
2. [akonadi-mysql-1.9.2-4.el7.x86_64问题 . https://www.cnblogs.com/xuyatao/p/7998057.html](https://www.cnblogs.com/xuyatao/p/7998057.html)