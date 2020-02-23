# 为知笔记

```
docker pull wiznote/wizserver:latest
# docker run --name wiz --restart=always -it -d -v  /data/wizdata:/wiz/storage -v  /etc/localtime:/etc/localtime -p 81:80 -p 9269:9269/udp  wiznote/wizserver
docker run --name wiz --restart=always -it -d -v  /data/wizdata:/wiz/storage -v  /etc/localtime:/etc/localtime -p 81:80  wiznote/wizserver
```

- 默认管理员账号： admin@wiz.cn
- 默认管理员密码： 123456


## 如果笔记日期不对

```
docker exec -it wiz /bin/bash
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
exit
```

# 参考
1. [为知笔记服务端docker镜像使用说明](https://www.wiz.cn/zh-cn/docker)