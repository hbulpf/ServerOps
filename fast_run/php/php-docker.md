1. 启动 php 容器
```
PWD=/data/php/html  #服务器存放 php 代码的路径
docker run -d -p 82:80 --name 504-apache-php-app --restart=always -v "$PWD":/var/www/html php:5.4-fpm
```

2. 官方镜像没有 php 扩展，需要额外添加
```
docker exec -ti 504-apache-php-app 
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apachectl restart
```


# 参考
1. [Docker 安装 PHP](https://www.runoob.com/docker/docker-install-php.html)
2. [DockerHub PHP仓库](https://hub.docker.com/_/php?tab=tags&page=1&name=5.4)