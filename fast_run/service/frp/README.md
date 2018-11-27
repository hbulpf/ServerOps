# 内网穿透
# 临时启动
1. 服务端运行

```
./frps -c frps.ini
```

如需以后台服务方式启动，运行
```
nohup ./frps -c frps.ini &
```

2. 客户端运行

```
cd /opt/frp/frp_0.21.0_linux_amd64/ && ./frpc -c frpc.ini
```

如需以后台服务方式启动，运行
```
cd /opt/frp/frp_0.21.0_linux_amd64/ && 
nohup ./frpc -c frpc.ini &
```

# 注册为系统服务永久启动
```
sh run.sh 
```

# 参考
1. CentOS7添加自定义脚本服务 . [http://www.cnblogs.com/wutao666/p/9781567.html](http://www.cnblogs.com/wutao666/p/9781567.html)

------------
@华南师范大学 计算机学院 504   实验室