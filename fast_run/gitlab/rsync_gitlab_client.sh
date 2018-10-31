#!/bin/bash
#客户端 执行
echo "123456" > /etc/rsyncd/gitlab_client.pass  # 创建客户端认证文件
chmod 600 /etc/rsyncd/gitlab_client.pass 
rsync -avz  --progress  --delete --password-file=/etc/rsyncd/gitlab_client.pass  gitlab@git.hnbdata.cn::gitlab_data/ /var/opt/gitlab/