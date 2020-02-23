# Tomcat 服务器

## 安装

### [yum 安装](./install_tomcat.sh)
1. 安装 tomcat
    ```
    yum -y install tomcat tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc
    ```
2. 启动、停止、重启tomcat
    ```
    service tomcat6 start
    service tomcat6 stop
    service tomcat5 restart
    ```

3. tomcat 常见目录
    ```
    33	/usr/share/tomcat/conf
    34	/usr/share/tomcat/lib
    35	/usr/share/tomcat/logs
    36	/usr/share/tomcat/temp
    37	/usr/share/tomcat/webapps
    38	/usr/share/tomcat/work
    ```

4. 查看全部tomcat安装目录
    ```
    rpm -ql tomcat | cat -n
    ```

### [docker 安装](./install_tomcat_docker.sh)

```
docker pull tomcat:8.5.51-jdk8-adoptopenjdk-hotspot
docker run --name=tomcat -d -p 8080:8080 \ 
    --restart=always
    -v /data/tomcat:/usr/local/tomcat  
    tomcat:8.5.51-jdk8-adoptopenjdk-hotspot
```