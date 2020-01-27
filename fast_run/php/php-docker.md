1. 启动 php 容器
```
PWD=/data/php/html  #服务器存放 php 代码的路径
docker run -d -p 82:80 --name 504-apache-php-app --restart=always -v "$PWD":/var/www/html php:7.2-apache
```

2. 官方镜像没有 php 扩展，需要额外添加
```
docker exec -ti 504-apache-php-app 
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apachectl restart
```


