#!/bin/bash
#安装 nfs 软件包
yum install nfs-utils -y

mkdir /501_raid_common   #创建挂载目录，并挂载 NFS共享目录 /501_raid_common
showmount -e 192.168.13.40
mount -t nfs 192.168.13.40:/volume1/501_common /501_raid_common
echo "192.168.13.40:/volume1/501_common /501_raid_common nfs defaults 0 0" >>/etc/fstab #开机自动将共享目录挂载到本地
ls -l /501_raid_common #测试nfs服务器

mkdir /501_data   #创建挂载目录，并挂载 NFS共享目录 /501_raid_data
showmount -e 192.168.13.40
mount -t nfs 192.168.13.40:/volume1/501_data /501_data
echo "192.168.13.40:/volume1/501_data /501_data nfs defaults 0 0" >>/etc/fstab #开机自动将共享目录挂载到本地
ls -l /501_data #测试nfs服务器
chmod -R 777 /501_data