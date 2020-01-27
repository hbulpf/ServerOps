# 防火墙设置
## 使用 firewalld
1. 开启防火墙： ` systemctl start firewalld.service `   
1. 重启防火墙： ` systemctl restart firewalld.service `   
1. 关闭防火墙： ` systemctl stop firewalld.service `
1. 开机启动防火墙： ` systemctl enable firewalld.service `
1. 禁止开机启动防火墙： ` systemctl disable firewalld.service `
1. 列出已开放的端口
```
firewall-cmd --list-ports
```
1. 列出已全部规则
```
firewall-cmd --list-ports
```
1. 开放80端口的方法：
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
```
>命令含义: (1) --zone #作用域    (2) --add-port=80/tcp #添加端口，格式为：端口/通讯协议   (3) --permanent #永久生效
1. 开放 5901-5920 端口的方法：
```
firewall-cmd --zone=public --add-port=5901-5920/tcp --permanent
firewall-cmd --reload
```
1. 关闭端口
```
firewall-cmd --zone=public --remove-port=5901-5920/tcp --permanent
firewall-cmd --reload
```

## 使用iptable
1. 永久性生效，重启后不会复原
```
开启： chkconfig iptables on
关闭： chkconfig iptables off
```
1. 即时生效，重启后复原
```
开启： service iptables start
关闭： service iptables stop
```

需要说明的是对于Linux下的其它服务都可以用以上命令执行开启和关闭操作。在开启了防火墙时，做如下设置，开启相关端口，修改/etc/sysconfig/iptables 文件，添加以下内容：
```
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
```
然后重启防火墙
```
[root@localhost ~]# service iptables restart
```
查看防火墙状态
```
[root@localhost ~]# service iptables status
```