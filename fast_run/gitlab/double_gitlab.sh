#!/bin/bash
yum install keepalived rsync xinetd inotify-tools -y 
vi /etc/rsyncd.conf 

uid = root
gid = root
port = 8730
# use chroot = yes
max connections = 4
pid file = /var/run/rsyncd.pid
exclude = lost+found/
# transfer logging = yes
# timeout = 900
# ignore nonreadable = yes
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2

[gitlab_data]
    path = /var/opt/gitlab
    comment = Gitlab Data Directory.
    read only = no
    auth users = gitlab
    secrets file = /etc/rsyncd/gitlab_rsyncd.pass

# [ftp]
#        path = /home/ftp
#        comment = ftp export area

[hnbd_nfs_data]
    path = /nfs_share
    comment = Gitlab Data Directory.
    read only = no
    auth users = hnbdnfs
    secrets file = /etc/rsyncd/hnbd_nfs_rsyncd.pass

mkdir /etc/rsyncd  # 创建存放密码认证文件目录
echo "gitlab:123456" > /etc/rsyncd/gitlab_rsyncd.pass  # 创建服务端认证文件
echo "123456" > /etc/rsyncd/gitlab_client.pass  # 创建客户端认证文件


mkdir /etc/rsyncd  # 创建存放密码认证文件目录
echo "hnbdnfs:hnbd123456" > /etc/rsyncd/hnbd_nfs_rsyncd.pass  # 创建服务端认证文件

echo "hnbd123456" > /etc/rsyncd/hnbd_nfs_rsyncd_client.pass  # 创建客户端认证文件


systemctl restart rsyncd.service
systemctl enable rsyncd.service

#客户端
rsync -avz  --delete --password-file=/etc/rsyncd/hnbd_nfs_rsyncd_client.pass  hnbdnfs@nfs.hnbdata.cn::hnbd_nfs_data/ /501_data/bak/hnbd_nfs