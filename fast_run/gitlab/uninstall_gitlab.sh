#!/bin/bash
gitlab-ctl stop
yum remove -y gitlab-ce
ps aux | grep gitlab # 杀掉所有gitlab的进程，需要手工操作
rm -rf /etc/gitlab
rm -rf /var/log/gitlab
rm -rf /var/opt/gitlab
rm -rf /opt/gitlab