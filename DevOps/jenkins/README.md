# Jenkins

> 配置文件默认路径 : /etc/sysconfig/jenkins 
> 初始密码默认路径 :/var/lib/jenkins/secrets/initialAdminPassword
> 工作目录默认路径 :/var/lib/jenkins/

# 安装

## [yum 方式](./install_jenkins.sh)

## war 方式

1. 将[最新的稳定Jenkins WAR包](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) 下载到您计算机上的相应目录。
1. 在下载的目录内打开一个终端/命令提示符窗口到。
2. 运行命令java -jar jenkins.war
3. 浏览http://localhost:8080并等到*Unlock Jenkins*页面出现。
4. [进行后续步骤](https://jenkins.io/zh/doc/book/installing/#setup-wizard)。

## [Docker 方式](./install_jenkins_docker.sh)

```
docker run \
  -u root \
  --rm \
  -d \
  -p 8081:8080 \
  -p 50000:50000 \
  -v /data/jenkins/jenkins_home:/var/jenkins_home \
  -v /data/jenkins/run/docker.sock:/var/run/docker.sock \
  -v /jenkins/home:/home \
  jenkinsci/blueocean
```
# 插件
如果插件安装较慢，请使用镜像源

https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json

替换原来的官方的json，我们来看看清华源拉下来的是什么 这里使用官方的下载插件的url全局搜索

进入 jenkins 工作目录的更新配置位置

```
cd /var/lib/jenkins/updates  
```

wiki和github的文档不用改，使用vim的命令替换所有插件下载的url
```
:1,$s/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g
```
替换连接测试url
```
:1,$s/http:\/\/www.google.com/https:\/\/www.baidu.com/g
```

也可以直接是要使用以下命令替换
替换 `default.json` 中插件下载的url源
```
sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' default.json
```


# 使用

```
docker run \
  --rm \
  -u root \
  -d \
  -p 8081:8080 \
  -v /data/jenkins/jenkins_home:/var/jenkins_home \
  -v /data/jenkins/run/docker.sock:/var/run/docker.sock \
  -v /jenkins/home:/home \
  jenkinsci/blueocean
```



# 参考
1. devops-jenkins部署和基本使用 . https://www.cnblogs.com/scajy/p/11806780.html
1. (官方)安装Jenkins . https://jenkins.io/zh/doc/book/installing/
2. (官方)使用Maven构建Java应用程序 . https://jenkins.io/zh/doc/tutorials/build-a-java-app-with-maven/