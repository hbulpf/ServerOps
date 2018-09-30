#!/bin/bash
#安装 nfs 软件包
yum install nfs-utils -y
mkdir /501_raid_common   #创建挂载目录，并挂载 NFS共享目录 /sharedir
mount -t nfs 192.168.13.40:/volume1/501_common /501_raid_common
echo "192.168.13.40:/volume1/501_common /501_raid_common nfs defaults 0 0" >>/etc/fstab #开机自动将共享目录挂载到本地
ls -l /501_raid_common #测试nfs服务器