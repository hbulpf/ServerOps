#!/bin/bash
gitlab-ctl stop
yum remove -y gitlab-ce
ps -ef|grep gitlab |grep -v grep|cut -c 9-15|xargs kill -9
ps -aux |grep gitlab
rm -rf /var/log/gitlab
rm -rf /var/opt/gitlab
rm -rf /opt/gitlab