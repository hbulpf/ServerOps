docker run -d --restart=always \
  --name nextcloud -p 8005:80 \
  -v /data/nextcloud:/var/www/html \
  docker.io/nextcloud

#进入容器修改可以允许访问的域名
docker exec -it nextcloud /bin/bash
sed -i "/0 => '119.29.151.225'/a\   1 => 'iot.hnbdata.cn',/" /var/www/html/config/config.php