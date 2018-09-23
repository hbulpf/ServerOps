#!/bin/bash
#安装 nfs 与 rpc 相关软件包
yum install nfs-utils rpcbind -y

touch /etc/exports
if [[ ! -d /nfs_share ]]
then 
	mkdir /nfs_share
fi
echo "/nfs_share *(rw,sync,root_squash,insecure)" >> /etc/exports
# example: /home/nfs 192.168.64.134(rw,sync,fsid=0)  192.168.64.135(rw,sync,fsid=0)   
# 第一部分: /home/nfs, 本地要共享出去的目录。
# 第二部分: 192.168.64.0/24 ，允许访问的主机，可以是一个IP：192.168.64.134，也可以是一个IP段：192.168.64.0/24. "*"表示所有
# 第三部分:
#     rw表示可读写，ro只读；
#     sync ：同步模式，内存中数据时时写入磁盘；async ：不同步，把内存中数据定期写入磁盘中；
#     no_root_squash ：加上这个选项后，root用户就会对共享的目录拥有至高的权限控制，就像是对本机的目录操作一样。不安全，不建议使用；root_squash：和上面的选项对应，root用户对共享目录的权限不高，只有普通用户的权限，即限制了root；all_squash：不管使用NFS的用户是谁，他的身份都会被限定成为一个指定的普通用户身份；
#     anonuid/anongid ：要和root_squash 以及all_squash一同使用，用于指定使用NFS的用户限定后的uid和gid，前提是本机的/etc/passwd中存在这个uid和gid。
#     fsid=0表示将/home/nfs整个目录包装成根目录

chmod -R o+wr  /nfs_share
systemctl start rpcbind
systemctl enable rpcbind
systemctl start nfs 
systemctl enable nfs 
 
rpcinfo -p  #查看运行 
systemctl stop firewalld.service  #关闭防火墙
