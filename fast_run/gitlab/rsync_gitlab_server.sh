#!/bin/bash
yum install keepalived rsync xinetd inotify-tools -y 
cat <<EOF >/etc/rsyncd.conf 
uid = root
gid = root
port = 873
# use chroot = yes
max connections = 4
pid file = /var/run/rsyncd.pid
log file = /var/log/rsyncd.log
lock file = /var/run/rsyncd.lock
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
EOF   

mkdir /etc/rsyncd  # 创建存放密码认证文件目录
echo "gitlab:123456" > /etc/rsyncd/gitlab_rsyncd.pass  # 创建服务端认证文件
chmod 600 /etc/rsyncd/gitlab_rsyncd.pass 

systemctl restart rsyncd.service
systemctl enable rsyncd.service