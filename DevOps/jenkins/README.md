# Jenkins

> 配置文件路径 : /etc/sysconfig/jenkins 

# 安装

## yum 方式

## war 方式

## Docker 方式

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