docker run --name nginx81 
	-d -p 81:80 -v /data/nginx/html:/usr/share/nginx/html 
	-v /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf  
	-v /data/nginx/logs:/var/log/nginx 
	-v /data/nginx/conf.d:/etc/nginx/conf.d -d 