#!/bin/bash
mkdir /usr/share/nginx/html/images
vi /etc/nginx/nginx.conf
#在server配置中加入下面配置
	# location /images/ {
 #   	 	root  /home/ftpuser/www/;
 #   		rewrite ^/images/(.*)$ /$1 break;
	# }
# 1)root 是将images映射到/home/ftpuser/www/images/,设定作用的根目录
# 2)rewrite ^/images/(.*)$ /$1 break;  是真正的跳转规则，设置以images为开头的请求跳转到 / 开头的根目录，后面的参数原封不动的添加过去
# 3)autoindex on 是打开浏览功能。

mkdir -p /home/ftpuser/www
chown -R ftpuser: /home/ftpuser
chmod 777 -R /home/ftpuser
systemctl start nginx
systemctl enable nginx

#https://blog.csdn.net/CSDN_LQR/article/details/53334583