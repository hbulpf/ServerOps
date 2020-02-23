#!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo             #导入jenkins源
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key                    #导入官方jenkins证书
systemctl start jenkins
systemctl enable jenkins
netstat -lntup | grep 8080
ps -ef |grep java
cat /var/lib/jenkins/secrets/initialAdminPassword        #查看密码

sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' /var/lib/jenkins/updates/default.json
# 替换插件下载源