# nginx配置https

说到 [Nginx](https://www.hack520.com/topic/nginx/) 服务器，个人认为最大特点就是轻量级和高性能。通过在几台不同的服务器上进行测试，发现它的并发能力特别强，并且相对而言吃的[内存](https://www.hack520.com/topic/ram/)少很多。目前已是绝大多数站长的首选 HTTP 和反向代理服务器。站长自己的网站，包括承接企业服务器运维服务所采用的都是 Nginx。Apache 当然也可以，如果有兴趣，可以看一下 [Nginx 和 Apache 区别对比](https://www.hack520.com/470.html)。

SSL 证书主要有两个功能：**加密**和**身份证明**，通常需要购买，也有免费的，通过第三方 SSL 证书机构颁发，常见可靠的第三方 SSL 证书颁发机构有下面几个：

[StartCom](https://www.startssl.com/) 机构上的 SSL 证书有以下几种：

- 企业级别：EV(Extended Validation)、OV(Organization Validation)
- 个人级别：IV(Identity Validation)、DV（Domain Validation）

其中 EV、OV、IV 需要付费

免费的证书安全认证级别一般比较低，不显示单位名称，不能证明网站的真实身份，仅起到加密传输信息的作用，适合个人网站或非电商网站。由于此类只验证域名所有权的低端 SSL 证书已经被国外各种欺诈网站滥用，因此强烈推荐部署验证单位信息并显示单位名称的 OV SSL 证书或申请最高信任级别的、显示绿色地址栏、直接在地址栏显示单位名称的 EV SSL 证书，就好像 [StarCom](https://www.startssl.com/) 的地址栏一样：



## 使用 OpenSSL 证书

配置 HTTPS 要用到私钥 `example.key` 文件和 `example.crt` 证书文件，申请证书文件的时候要用到 `example.csr` 文件，`OpenSSL` 命令可以生成 `example.key` 文件和 `example.csr` 证书文件。

- CSR：Cerificate Signing Request，证书签署请求文件，里面包含申请者的 DN（Distinguished Name，标识名）和公钥信息，**在第三方证书颁发机构签署证书的时候需要提供**。证书颁发机构拿到 CSR 后使用其根证书私钥对证书进行加密并生成 CRT 证书文件，里面包含证书加密信息以及申请者的 DN 及公钥信息
- Key：证书申请者私钥文件，和证书里面的公钥配对使用，在 HTTPS 『握手』通讯过程需要使用私钥去解密客戶端发來的经过证书公钥加密的随机数信息，是 HTTPS 加密通讯过程非常重要的文件，**在配置 HTTPS 的時候要用到**

使用 `OpenSSl`命令可以在系统当前目录生成 `example.key` 和 `example.csr` 文件：

```
openssl req -new -newkey rsa:2048 -sha256 -nodes -out example_com.csr -keyout example_com.key -subj "/C=CN/ST=ShenZhen/L=ShenZhen/O=Example Inc./OU=Web Security/CN=example.com"
```

下面是上述命令相关字段含义：

- C：Country ，单位所在国家，为两位数的国家缩写，如： CN 就是中国
- ST 字段： State/Province ，单位所在州或省
- L 字段： Locality ，单位所在城市 / 或县区
- O 字段： Organization ，此网站的单位名称;
- OU 字段： Organization Unit，下属部门名称;也常常用于显示其他证书相关信息，如证书类型，证书产品名称或身份验证类型或验证内容等;
- CN 字段： Common Name ，网站的域名;

生成 csr 文件后，提供给 CA 机构，签署成功后，就会得到一个 **example.crt** 证书文件，SSL 证书文件获得后，就可以在 Nginx 配置文件里配置 HTTPS 了。

## Nginx 的 SSL 模块安装

查看 nginx 是否安装 http_ssl_module 模块。

```
$ /usr/local/nginx/sbin/nginx -V
```

如果出现 configure arguments: –with-http_ssl_module, 则已安装（下面的步骤可以跳过，进入 nginx.conf 配置）。

下载 Nginx 安装包，当然是要去 Nginx 官网下载。

下载安装包到 src 目录

```
$ cd /usr/local/src
$ wget http://nginx.org/download/nginx-1.15.9.tar.gz
```

解压安装包。

```
$ tar -zxvf nginx-1.15.9.tar.gz
```

配置 SSL 模块。

```
$ cd nginx-1.15.9
$ ./configure --prefix=/usr/local/nginx --with-http_ssl_module
```

使用 make 命令编译（使用make install会重新安装nginx），此时当前目录会出现 objs 文件夹。

用新的 nginx 文件覆盖当前的 nginx 文件。

```
$ cp ./objs/nginx /usr/local/nginx/sbin/
```

再次查看安装的模块（configure arguments: –with-http_ssl_module说明ssl模块已安装）。

```
$ /usr/local/nginx/sbin/nginx -V

nginx version: nginx/1.15.9
...
configure arguments: --with-http_ssl_module
```

## SSL 证书部署

这里使用的是阿里云的免费证书，期限为1年，[申请地址在此](https://www.hack520.com/go/?https://common-buy.aliyun.com/?commodityCode=cas#/buy)。也可以根据前面介绍的方法使用 OpenSSL 生成 证书.

将准备好的 ssl 证书文件压缩包解压（这里是用的 pem 与 key 文件，文件名可以更改）。

在 nginx 目录新建 cert 文件夹存放证书文件。

```
$ cd /usr/local/nginx
$ mkdir cert
```

将这两个文件上传至服务器的 cert 目录里。
这里使用 mac 终端上传至服务器的 scp 命令（这里需要新开一个终端，不要使用连接服务器的窗口）:

```
$ scp /Users/yourname/Downloads/ssl.pem root@xxx.xx.xxx.xx:/usr/local/nginx/cert/
$ scp /Users/yourname/Downloads/ssl.key root@xxx.xx.xxx.xx:/usr/local/nginx/cert/
```

```
scp [本地文件路径，可以直接拖文件至终端里面] [<服务器登录名>@<服务器IP地址>:<服务器上的路径>]
```
## Nginx.conf 配置

编辑 /usr/local/nginx/conf/nginx.conf 配置文件：

配置 https server。注释掉之前的 http server 配置，新增 https server：

```
server {
    # 服务器端口使用443，开启ssl, 这里ssl就是上面安装的ssl模块
    listen       443 ssl;
    # 域名，多个以空格分开
    server_name  hack520.com www.hack520.com;
    
    # ssl证书地址
    ssl_certificate     /usr/local/nginx/cert/ssl.pem;  # pem文件的路径
    ssl_certificate_key  /usr/local/nginx/cert/ssl.key; # key文件的路径
    
    # ssl验证相关配置
    ssl_session_timeout  5m;    #缓存有效期
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;    #加密算法
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;    #安全链接可选的加密协议
    ssl_prefer_server_ciphers on;   #使用服务器端的首选算法

    location / {
        root   html;
        index  index.html index.htm;
    }
}
```

将 http 重定向 https。

```
server {
    listen       80;
    server_name  hack520.com www.hack520.com;
    return 301 https://$server_name$request_uri;
}
```

重新加载配置

```
nginx -s reload
```

## 重启 nginx

```
$ /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```

如果 80 端口被占用，用kill [id]来结束进程：

```
# 查看端口使用
$ netstat -lntp

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      21307/nginx: master 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      3072/sshd           
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      21307/nginx: master 

# 结束 80 端口进程
$ kill 21307
```

再次重启 nginx：

```
$ /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```

或者：

```
service nginx restart
```

## 参考
1. [Nginx 安装 SSL 配置 HTTPS 超详细完整全过程](https://www.hack520.com/481.html)
2. [Nginx 配置 HTTPS 服务器](https://aotu.io/notes/2016/08/16/nginx-https/index.html)
