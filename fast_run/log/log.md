## Linux 日志
大部分Linux发行版默认的日志守护进程为 syslog，位于 /etc/syslog 或 /etc/syslogd 或/etc/rsyslog.d，默认配置文件为 /etc/syslog.conf 或 rsyslog.conf，任何希望生成日志的程序都可以向 syslog 发送信息。

为了方便查阅，可以把内核信息与其他信息分开，单独保存到一个独立的日志文件中。默认配置下，日志文件通常都保存在“/var/log”目录下。

常用日志文件
系统日志是由一个名为syslog的服务管理的，如以下日志文件都是由syslog日志服务驱动的：

/var/log/boot.log：录了系统在引导过程中发生的事件，就是Linux系统开机自检过程显示的信息

/var/log/lastlog ：记录最后一次用户成功登陆的时间、登陆IP等信息

/var/log/messages ：记录Linux操作系统常见的系统和服务错误信息

/var/log/secure ：Linux系统安全日志，记录用户和工作组变坏情况、用户登陆认证情况

/var/log/btmp ：记录Linux登陆失败的用户、时间以及远程IP地址

/var/log/syslog：只记录警告信息，常常是系统出问题的信息，使用lastlog查看

/var/log/wtmp：该日志文件永久记录每个用户登录、注销及系统的启动、停机的事件，使用last命令查看

/var/run/utmp：该日志文件记录有关当前登录的每个用户的信息。如 who、w、users、finger等就需要访问这个文件

/var/log/syslog 或 /var/log/messages 存储所有的全局系统活动数据，包括开机信息。基于 Debian 的系统如 Ubuntu 在 /var/log/syslog 中存储它们，而基于 RedHat 的系统如 RHEL 或 CentOS 则在 /var/log/messages 中存储它们。

/var/log/auth.log 或 /var/log/secure 存储来自可插拔认证模块(PAM)的日志，包括成功的登录，失败的登录尝试和认证方式。Ubuntu 和 Debian 在 /var/log/auth.log 中存储认证信息，而 RedHat 和 CentOS 则在 /var/log/secure 中存储该信息。

## 相关命令
查看系统日志
```
journalctl
```

查看设备故障日志
```
dmesg 
```

我们可以使用如‘more’ ‘head’, ‘tail’, ‘less ’或者‘grep’文字处理工具来处理命令的输出。由于日志的输出不适合在一页中完全显示，因此我们使用管道（pipe）将其输出送到more或者less命令单页显示(more只能向后翻页，不能往前翻；less可以向后向前翻页。)
```
[root@tecmint.com ~]# dmesg | more
[root@tecmint.com ~]# dmesg | less 
[root@tecmint.com ~]# dmesg | head  -20 #只输出dmesg命令的前20行日志
[root@tecmint.com ~]# dmesg | tail -20  #只输出dmesg命令最后20行日志
[root@tecmint.com ~]# dmesg | grep sda #搜索‘sda’关键词
[root@tecmint.com log]# dmesg | grep -i usb  #过滤出一些包含‘usb’字符串的日志行。grep 命令 的‘-i’选项表示忽略大小写
[root@tecmint.com log]# dmesg -c  #清空dmesg缓冲区日志
[root@tecmint.com log]# watch "dmesg | tail -20" #实时监控dmesg日志输出
```

