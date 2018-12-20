docker run -d --restart=always \
  --name nextcloud -p 80:80 \
  -v /data/nextcloud:/var/www/html/data \
  docker.io/nextcloud

#进入容器修改可以允许访问的域名
docker exec -it nextcloud /bin/bash
sed -i "/0 => '119.29.151.225'/a\   1 => 'cloud.hnbdata.cn',/" /var/www/html/config/config.php