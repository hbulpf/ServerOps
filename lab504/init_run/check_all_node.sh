#!/bin/bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  # 修改时区为东8区
yum install -y ntp ntpdate ntp-doc #安装时间同步工具
# systemctl enable ntpd
# systemctl start ntpd
ntpdate -u cn.pool.ntp.org #设置系统时间与网络时间同步
hwclock --systohc #系统时间写入硬件时间
hwclock -w  #强制系统时间写入CMOS中防止重启失效

#install sshd
yum install -y openssh-server
systemctl restart sshd.service
systemctl enable sshd.service

yum install -y lrzsz