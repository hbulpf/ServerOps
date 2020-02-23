docker run --name=nginx81 -d -p 81:80 --restart=always -v /data/nginx/html:/usr/share/nginx/html -v /data/nginx/logs:/var/log/nginx -v /data/nginx/conf:/etc/nginx/conf  nginx

docker run --name nginx80 -d -p  --rm 8080:80 nginx