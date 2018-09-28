#!/bin/bash
yum groups install "X Window System"
yum groupinstall "KDE Plasma Workspaces"
systemctl set-default graphical.target　　#graphical.target相当于level5，multi-user.target相当于level3
yum install -y tigervnc-server  #安装vncserver

#为用户 root 分配连接，对应端口5901,详细说明请查看 /lib/systemd/system/vncserver@.service
su 
vncserver :1    #临时开启vncserver的第1连接桌面
vncpasswd       #修改连接的用户的密码
cat << EOM > /etc/systemd/system/vncserver@\:1.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target
[Service]
Type=forking
ExecStartPre=-/usr/bin/vncserver -kill %i
ExecStart=/sbin/runuser -l root -c "/usr/bin/vncserver %i"
PIDFile=/root/.vnc/%H%i.pid
ExecStop=-/usr/bin/vncserver -kill %i
[Install]
WantedBy=multi-user.target
EOM
systemctl daemon-reload
systemctl start vncserver@:1.service
systemctl enable vncserver@:1.service    
# vncpasswd    #root用户实例的vnc密码 #scnu16
# firewall-cmd --zone=public --add-port=5901/tcp  #打开防火墙端口
# firewall-cmd --reload


#为用户 lipengfei 分配连接，对应端口5902
su - lipengfei
vncserver :2    #临时开启vncserver的第1连接桌面
vncpasswd       #修改连接的用户的密码,需输入设置的密码
cat << EOM > /etc/systemd/system/vncserver@\:2.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target
[Service]
Type=forking
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l lipengfei -c "/usr/bin/vncserver %i"
PIDFile=/home/lipengfei/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
[Install]
WantedBy=multi-user.target
EOM
systemctl daemon-reload
systemctl start vncserver@:2.service
systemctl enable vncserver@:2.service   

vncserver -list   #查看启用的桌面列表