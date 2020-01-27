安装 Monitorix

1. 安装依赖包
    ```
    yum install -y rrdtool rrdtool-perl perl-libwww-perl perl-MailTools perl-MIME-Lite perl-CGI perl-DBI perl-XML-Simple perl-Config-General perl-HTTP-Server-Simple wget 
    ```

2. 下载安装
    ```
    yum install -y monitorix
    ```

    如果报错：
    ```
    错误：软件包：perl-DBD-MySQL-4.023-6.el7.x86_64 (base)
            需要：libmysqlclient.so.18(libmysqlclient_18)(64bit)
    ```
    安装相应的包
    ```
    wget http://www.percona.com/redir/downloads/Percona-XtraDB-Cluster/5.5.37-25.10/RPM/rhel6/x86_64/Percona-XtraDB-Cluster-shared-55-5.5.37-25.10.756.el6.x86_64.rpm
    rpm -ivh Percona-XtraDB-Cluster-shared-55-5.5.37-25.10.756.el6.x86_64.rpm 
    ```

3. 修改配置

    配置文件为: `/etc/monitorix/monitorix.conf`
    修改端口号、hostname、title
    ```
    title = pxw-50125 monitor
    hostname = pxw501-25
    port = 9000
    ```

4. 启动服务
    ```
    systemctl start monitorix.service 
    systemctl enable monitorix
    ``` 

5. 访问 ： http://localhost:9000/monitorix
