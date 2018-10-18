#!/bin/bash
yum groupinstall -y "X Window System" 
yum grouplist  #查看信息
yum groupinstall -y "KDE Plasma Workspaces" "Graphical Administration Tools" #安装KDE图形界面
startx #启动图形界面
 
# ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target #设置开机启动图形界面