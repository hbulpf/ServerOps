
# 安装 cnpm 

```
npm config set registry http://registry.npm.taobao.org/
或者
npm install -g cnpm --registry=https://registry.npm.taobao.org
```


# 安装 vue

```
npm install @vue/cli -g
vue -V
```

# 安装Electron

```
npm install -g electron
或者
cnpm install -g electron
```

# 创建运行项目

Electron官方提高了一个简单的项目，可以执行以下命令将项目克隆到本地。

```
git clone https://github.com/electron/electron-quick-start
```

然后在项目中执行如下命令即可启动项目。

```
cd electron-quick-start
npm install
npm start
```