#!/bin/bash
#安装 nfs 软件包
yum install nfs-utils -y

showmount -e 52.82.8.82   #查询远程NFS 服务端中可用的共享资源
mkdir /nfs_mirrors   #创建挂载目录，并挂载 NFS共享目录 /sharedir
mount -t nfs 52.82.8.82:/nfs_share /nfs_mirrors
echo "52.82.8.82:/nfs_share /nfs_mirrors nfs defaults 0 0" >>/etc/fstab #开机自动将共享目录挂载到本地

#测试          
mkdir -p /nfs_mirrors/hello
cd /nfs_mirrors/hello
touch hello.txt
echo "Hello" >> hello.txt
cat hello.txt