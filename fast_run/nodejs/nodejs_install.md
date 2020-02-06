

# 安装Node js

推荐淘宝镜像 https://npm.taobao.org/mirrors/

首先安装必要的环境(推荐方式一安装)
```
yum install gcc gcc-c++
```

## 一、方式一

```
wget https://npm.taobao.org/mirrors/node/v10.16.0/node-v10.16.0-linux-x64.tar.gz #针对 x86_64架构
# wget https://npm.taobao.org/mirrors/node/v10.16.0/node-v10.16.0-linux-arm64.tar.gz #针对 arm64架构
```
然后执行下面命令

```
tar -xvf  node-v10.16.0-linux-x64.tar.gz
mv node-v10.16.0-linux-x64 /opt/nodejs
```

创建软连接变量

```
ln -s /opt/nodejs/bin/npm   /usr/local/bin/ 
ln -s /opt/nodejs/bin/node   /usr/local/bin/
ln -s /opt/nodejs/bin/npx   /usr/local/bin/
```


## 二、方式二 源码安装
> make很浪费时间,但可以体验编译的乐趣

```
wget https://npm.taobao.org/mirrors/node/v10.16.0/node-v10.16.0.tar.gz
```

解压安装

```
tar xvf node-v10.16.0.tar.gz
cd node-v10.16.0/
./configure
make   #这个操作可能会很久
make install
npm -v #查看版本
```

## 三、其它操作，如换个源

```
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm -v
```

不想用cnpm操作，那就直接换npm源
单次使用

```
npm install --registry=https://registry.npm.taobao.org
```
永久使用

```
npm config set registry https://registry.npm.taobao.org
```

检测是否成功

#配置后可通过下面方式来验证是否成功
```
npm config get registry
#或
npm info express
```

# 参考
1. [npm安装(Centos7)](https://www.jianshu.com/p/ea0fe8d177c0)
2. [菜鸟教程 - Node.js 教程](https://www.runoob.com/nodejs/nodejs-tutorial.html)