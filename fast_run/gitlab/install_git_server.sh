#!/bin/bash
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel  #安装一些相关依赖库
yum install gcc perl-ExtUtils-MakeMaker #安装编译工具
cd /usr/local/src && wget https://www.kernel.org/pub/software/scm/git/git-2.10.0.tar.gz && tar -zvxf git-2.10.0.tar.gz #下载源码包并解压
cd git-2.10.0 && make all prefix=/usr/local/git && make install prefix=/usr/local/git #解压下载的源码包并编译

echo 'export PATH=$PATH:/usr/local/git/bin' >> /etc/bashrc  #git 目录加入 PATH 环境变量
source /etc/bashrc #生效环境变量
git --version  #查看版本

useradd -m gituser  #创建一个git账号
passwd gituser  #为git账号设置密码
mkdir -p /data/repositories  #创建 /data/repositories 目录用于存放 git 仓库
cd /data/repositories/ && git init --bare test.git #初始化这个仓库
chown -R gituser:gituser /data/repositories  #给 git 仓库目录设置用户和用户组并设置权限
chmod 755 /data/repositories  

which git-shell  #查找git-shell的位置
vi /etc/passwd  #修改 gituser 的登录 shell 配置改为 git-shell，修改内容如下
# gituser:x:500:500::/home/gituser:/usr/local/git/bin/git-shell

# 在客户端使用 git 仓库
# cd ~ && git clone gituser@<您的 CVM IP 地址>:/data/repositories/test.git