#!/bin/bash
# 修改时区为东8区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#安装时间同步工具
yum install -y ntp ntpdate ntp-doc

#install sshd
yum install -y openssh-server
systemctl restart sshd.service
systemctl enable sshd.service

yum install -y lrzsz