# Centos7安装Redis

一、安装gcc依赖

由于 redis 是用 C 语言开发，安装之前必先确认是否安装 gcc 环境（gcc -v），如果没有安装，执行以下命令进行安装

 ```[root@localhost local]# yum install -y gcc``` 

 

二、下载并解压安装包

```[root@localhost local]# wget http://download.redis.io/releases/redis-5.0.3.tar.gz```

```[root@localhost local]# tar -zxvf redis-5.0.3.tar.gz```

 

三、cd切换到redis解压目录下，执行编译

```[root@localhost local]# cd redis-5.0.3```

```[root@localhost redis-5.0.3]# make```

 

四、安装并指定安装目录

```[root@localhost redis-5.0.3]# make install PREFIX=/usr/local/redis```

 

五、启动服务

5.1前台启动

```[root@localhost redis-5.0.3]# cd /usr/local/redis/bin/```

```[root@localhost bin]# ./redis-server```

 

5.2后台启动

从 redis 的源码目录中复制 redis.conf 到 redis 的安装目录

```[root@localhost bin]# cp /usr/local/redis-5.0.3/redis.conf /usr/local/redis/bin/```

 

修改 redis.conf 文件，把 daemonize no 改为 daemonize yes

```[root@localhost bin]# vi redis.conf```

![img](https://img2018.cnblogs.com/blog/1336432/201903/1336432-20190302212509880-1874470634.png)

后台启动

```[root@localhost bin]# ./redis-server redis.conf```

![img](https://img2018.cnblogs.com/blog/1336432/201903/1336432-20190302212804992-1094141996.png)

 

六、设置开机启动

添加开机启动服务

```[root@localhost bin]# vi /etc/systemd/system/redis.service```

复制粘贴以下内容：

```
[Unit]
Description=redis-server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/bin/redis.conf
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

注意：ExecStart配置成自己的路径 

 

设置开机启动

```[root@localhost bin]# systemctl daemon-reload```

```[root@localhost bin]# systemctl start redis.service```

```[root@localhost bin]# systemctl enable redis.service```

 

创建 redis 命令软链接

```[root@localhost ~]# ln -s /usr/local/redis/bin/redis-cli /usr/bin/redis```

测试 redis

![img](https://img2018.cnblogs.com/blog/1336432/201903/1336432-20190302221347104-518199130.png)

 

服务操作命令

systemctl start redis.service  #启动redis服务

systemctl stop redis.service  #停止redis服务

systemctl restart redis.service  #重新启动服务

systemctl status redis.service  #查看服务当前状态

systemctl enable redis.service  #设置开机自启动

systemctl disable redis.service  #停止开机自启动

 



# 参考
1. [Centos7安装Redis](https://www.cnblogs.com/heqiuyong/p/10463334.html)