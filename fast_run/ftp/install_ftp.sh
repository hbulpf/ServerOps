#!/bin/bash
yum -y install vsftpd   #conf目录/etc/vsftpd/vsftpd.conf 

#增加用户
useradd -d /home/ftpuser -m ftpuser
echo "ftp_micros"| passwd --stdin ftpuser  #设置密码为: ftp_micros
#修改 selinux配置
getsebool -a | grep ftp
setsebool -P allow_ftpd_full_access on
setsebool -P ftp_home_dir on
#修改配置
sed -i 's/^anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf
sed -i '$a\pasv_min_port=30000' /etc/vsftpd/vsftpd.conf
sed -i '$a\pasv_max_port=30999' /etc/vsftpd/vsftpd.conf

#设置ftp的默认访问路径
echo "local_root=/nfs_share" >>/etc/vsftpd/vsftpd.conf
#设置可访问目录
mkdir -p /nfs_share
chown -R ftpuser: /nfs_share
chmod 777 -R /nfs_share

#开启 21端口
# vim /etc/sysconfig/iptables
# service iptables restart 
# chkconfig vsftpd on  #设置开机启动
systemctl start vsftpd
systemctl enable vsftpd

#https://blog.csdn.net/csdn_lqr/article/details/53333946