# Linux 资源限额

## 内存限额
查看某个用户当前使用的总内存大小
```
ps   -o rss  aU qujun  |grep -v RSS|awk 'BEGIN {sum=0}{sum+=$1}END{print sum}'
```

Linux下管理员可以限制某个用户的内存
```
root@localhost ~]# su - test
[test@localhost ~]$ ulimit -a
core file size                    (blocks, -c) 0
data seg size                     (kbytes, -d) unlimited
scheduling priority                         (-e) 0
file size                             (blocks, -f) unlimited
pending signals                                 (-i) 8192
max locked memory             (kbytes, -l) 32
max memory size                 (kbytes, -m) unlimited
open files                                            (-n) 1024
pipe size                        (512 bytes, -p) 8
POSIX message queues         (bytes, -q) 819200
real-time priority                            (-r) 0
stack size                            (kbytes, -s) 10240
cpu time                             (seconds, -t) unlimited
max user processes                            (-u) 8192
virtual memory                    (kbytes, -v) unlimited
file locks                                            (-x) unlimited
```

`ulimit -a` 命令统计了当前用户在系统中的多种限制信息，从 virtual memory 中可以看到，当前对用户并没有做内存使用限制。
限制test用户内存
```
[root@localhost ~]# vi /etc/security/limits.conf
........
#在最后加入一行，保存退出
test        hard        as            38300
[root@localhost ~]#su - test
[test@localhost ~]$ulimit -a
......
virtual memory          (kbytes, -v) 38300
```

## 磁盘配额
参考: https://my.oschina.net/emptytimespace/blog/177773


# 参考
1. linux下限制用户的可用内存 . https://blog.51cto.com/4359260/1194871
2. Linux系统限制普通用户内存使用(ulimit)和硬盘配额空间（quota）. https://my.oschina.net/emptytimespace/blog/177773