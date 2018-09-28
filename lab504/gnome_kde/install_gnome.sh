#!/bin/bash
yum groupinstall -y "X Window System" 
yum grouplist  #查看信息
yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools" #安装GNOME图形界面
startx #启动图形界面
 
# ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target #设置开机启动图形界面