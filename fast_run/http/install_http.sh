#!/bin/bash
yum install httpd -y
yum info httpd 

#将http的目录指向nfs_share
rm -rf /var/www/html && ln -s /nfs_share /var/www/html
#多数云主机的80端口被禁止访问，使用81端口
sed -i "s/^Listen.*/Listen 81/" /etc/httpd/conf/httpd.conf

systemctl restart httpd.service
systemctl enable httpd.service

systemctl restart httpd.service

#关闭Selinux
setenforce 0 #暂时关闭Selinux
sed -i "s/^SELINUX=.*/SELINUX=disable/" /etc/selinux/config  #永久关闭Selinux