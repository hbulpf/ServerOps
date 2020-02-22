PWD=/data/sci_php/www  #服务器存放 php 代码的路径
docker run -d -p 81:80 --name sci_php --restart=always -v "$PWD":/var/www php:5.4.45-apache


docker exec -ti sci_php
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apachectl restart