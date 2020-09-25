# nginx 服务

## nginx 配置详解
nginx 配置文件默认路径为 `/etc/nginx/nginx.conf`

nginx 静态文件默认路径为 `/usr/share/nginx/html`

```
user root;   #nginx的启动用户
worker_processes auto;
error_log /var/log/nginx/error.log;  #错误日志地址
pid /run/nginx.pid;  #pid文件地址

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;  #nginx端口号
        listen       [::]:80 default_server;
        server_name  nfs.hnbdata.cn;  #nginx服务器地址
     #   root         /usr/share/nginx/html;  
        autoindex_exact_size off;            #关闭详细文件大小统计，让文件大小显示MB，GB单位，默认为b；  
        autoindex_localtime on;              #开启以服务器本地时区显示文件修改日期！       

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {  #nginx服务根目录
        root html;    #真实物理绝对路径,默认在 /usr/share/nginx/
        index index.html index.htm;
        }

        location /images/ {  #nginx服务虚拟目录
            root  /home/ftpuser/www/;  #真实物理绝对路径 /home/ftpuser/www/
            rewrite ^/images/(.*)$ /$1 break; #收到以 /images/ 开头的请求后转向这里
            autoindex on;  #列出目录下所有文件
        }

        location /nfs {
                root  /nfs_share/;
               rewrite ^/nfs/(.*)$ /$1 break;
                autoindex on;
        }
 
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
```

修改完 nginx 配置文件后
```
nginx -t #检查nginx配置文件是否有错误
nginx -s reload #nginx配置文件无问题，重新加载nginx配置文件
```

## nginx配置https

https://blog.csdn.net/weixin_38615720/article/details/92827012?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param

## 端口转发
在nginx.conf添加如下配置，并使用 `nginx -s reload` 重载nginx使其生效，同时注意防火墙/安全组放行对应的端口。

stream {
    #将12345端口转发到192.168.1.23的3306端口
    server {
        listen 12345;
        proxy_connect_timeout 5s;
        proxy_timeout 20s;
        proxy_pass 192.168.1.23:3306;
    }
    #将udp 53端口转发到192.168.1.23 53端口
    server {
        listen 53 udp reuseport;
        proxy_timeout 20s;
        proxy_pass 192.168.1.23:53;
    }
    #ipv4转发到ipv6
    server {
        listen 9135;
        proxy_connect_timeout 10s;
        proxy_timeout 30s;
        proxy_pass [2607:fcd0:107:3cc::1]:9135;
    }
}

* listen：后面填写源端口（也就是当前服务器端口），默认协议为TCP，可以指定为UDP协议
* proxy_connect_timeout：连接超时时间
* proxy_timeout：超时时间
* proxy_pass：填写转发目标的IP及端口号
  
注意：nginx可以将IPV4的数据包转发到IPV6，IPV6的IP需要使用[]括起来。


## 常见问题
> 遇到问题，先看访问日志 ` tail /var/log/nginx/access.log ` 和错误日志 ` tail /var/log/nginx/error.log `


### 1. Forbidden问题
  访问时总是出现 `Forbidden错误`,原因可能有多种，但常见的解决方法有
  1. 关闭Selinux 
	- 临时关闭Selinux，重启后无效
		```
		setenforce 0 #临时关闭Selinux
		sestatus -v  #查看Selinux Current mode是否为 permissive

		SELinux status:                 enabled
		SELinuxfs mount:                /sys/fs/selinux
		SELinux root directory:         /etc/selinux
		Loaded policy name:             targeted
		Current mode:                   permissive
		Mode from config file:          error (Success)
		Policy MLS status:              enabled
		Policy deny_unknown status:     allowed
		Max kernel policy version:      31
		.......
		```
	- 永久关闭Selinux,重启后也有效
		```
		sed -i "s/^SELINUX=.*/SELINUX=disable/" /etc/selinux/config  #永久关闭Selinux
		```

## 参考
1. 解决Nginx出现403 forbidden (13: Permission denied)报错的四种方法 . https://blog.csdn.net/onlysunnyboy/article/details/75270533?utm_source=blogxgwz3