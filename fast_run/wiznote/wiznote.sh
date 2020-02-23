
docker pull wiznote/wizserver:latest
docker run --name wiz --restart=always -it -d -v  /data/wizdata:/wiz/storage -v  /etc/localtime:/etc/localtime -p 81:80  wiznote/wizserver


# 默认管理员账号： admin@wiz.cn
# 默认管理员密码： 123456

# docker stop wiz
# docker rm wiz
