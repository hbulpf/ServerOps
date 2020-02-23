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
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean
```

# 参考
1. 安装Jenkins : https://jenkins.io/zh/doc/book/installing/