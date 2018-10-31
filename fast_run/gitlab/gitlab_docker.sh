#!/bin/bash
#清理环境
docker stop gitlab && docker rm gitlab 
rm -rf /srv/gitlab/


#安装gitlab:11.3.0-ce.0
docker pull gitlab/gitlab-ce:11.3.0-ce.0
docker run --detach \
    --hostname git.hnbdata.cn \
    --publish 444:443 --publish 81:80 --publish 23:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:11.3.0-ce.0