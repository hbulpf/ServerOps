#!/bin/bash

yum install -y gcc

if [[ ! -d /download ]]
then
    echo "mkdir /download"
    mkdir /download
fi

if [[ -f  /download/redis-5.0.3.tar.gz ]]
then
    echo "download redis-5.0.3.tar.gz start..."
    rm  -rf /download/redis-5.0.3.tar.gz
    wget http://download.redis.io/releases/redis-5.0.3.tar.gz -O /download/redis-5.0.3.tar.gz
    echo "download redis-5.0.3.tar.gz end..."
fi

cd /download
tar -zxvf redis-5.0.3.tar.gz 
cd redis-5.0.3

#编译redis
make
make install PREFIX=/usr/local/redis

# 前台启动
cd /usr/local/redis/bin/
./redis-server

cp /download/redis-5.0.3/redis.conf /usr/local/redis/bin/

# 后台启动
./redis-server redis.conf

# 写入系统服务
echo "write redis.service..."
cat <<EOF >/etc/systemd/system/redis.service
[Unit]
Description=redis-server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/usr/local/redis/redis.pid
ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/bin/redis.conf
ExecReload=/bin/kill -s HUP $MAINPID 
ExecStop=/bin/kill -s QUIT $MAINPID 
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF


echo "start up redis.service..."
systemctl daemon-reload
systemctl start redis.service
systemctl status redis
systemctl enable redis.service

ln -s /usr/local/redis/bin/redis-cli ~/redis-cli