yum install kdepim
yum groupinstall "X Window System" "KDE (K Desktop Environment)"
yum -y install vnc vnc-server firefox x11-xorg
yum -y install fonts-chinese
vncserver
pkill -9 vnc
rm -rf /tmp/.X1*


vi /root/.vnc/xstartup
# 在最后一行将twm
# KDE则改成startkde
# GNOME则改成gnome-session
vncserver