# 服务器初始化说明
## 1. 服务器初始化账户
504的服务器初始化时，将安装 sshd ，docker ，vnc 等基础环境，同时会给刘老师和庞老师的同学分配系统登录账户及密码并赋予 sudo 权限。    

### **重要1**：
每个同学的**系统账号为自己的姓名拼音，密码为 `姓名拼音@504`**，如
账号为 `lipengfei` , 对应的系统初始密码为 `lipengfei@504`。     建议在第一次登录后使用
```
passwd
```
修改自己的登录密码。连接远程服务器，windows平台的同学可以使用 `xshell` 或 `secureCRT`等工具进行连接。     

### **重要2**：
如果需要用到图形化界面，请使用命令
```
sudo vncserver -list |grep "^:" |tr -d ':' | cut -f 1
1
```
查看输出最大的数字，然后使用最大的数字加1，比如**这里应该是 2**，使用如下命令为自己开启图形界面：
```
vncserver :2
```
>1. 初次启动 vncserver 时，系统会让设置你自己的vnc密码，设置并记住，在你自己电脑连接时需要输入  
>2. 如果服务器被重启，需要自己重新登录服务器，执行这两条命令，为自己开启 vnc远程连接。

然后自己在自己的电脑上使用 vnc 客户端，输入服务器 `ip:vncserver :后面的数字` ,并按提示输入自己设置的vnc密码即可连接。如果忘记密码，可以登录到服务器上，使用
```
vncpasswd
```
修改自己的 vnc 密码

附服务器内网ip：  

服务器 | 学院内网ip | 学校内网ip
------ | --------- | ----------
501-25 | 192.168.13.25 |  -  
501-26 | 192.168.13.26 |  -

## 2. 服务器初始化脚本说明 （ for 运维开发）
1. 修改hosts脚本 : [updateHosts.sh](updateHosts.sh)
2. 增加用户: [add_users.sh](add_users.sh)  本脚本用到 [user_passwd](user_passwd), [user_passwd](user_passwd) 第一列为用户名，第二列为用户密码
3. 检测节点，安装相关工具: [check_all_node.sh](check_all_node.sh)
4. 设置允许 ssh 登录: [enale_ssh_passwd.sh](enale_ssh_passwd.sh)
5. 安装docker-ce: [install_docker.sh](install_docker.sh)

-------
如果有任何问题，请找 @[`RunAtWorld`](https://github.com/RunAtWorld)   @[`加伟`](https://github.com/1846263444)   
