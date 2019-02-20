# 安装FTP服务器

#### 1. 安装FTP服务器
```
yum install -y vsftpd
```


ftp的配置文件主要有三个，位于 /etc/vsftpd/ 目录下，分别是：
* ftpusers（该文件用来指定那些用户不能访问ftp服务器）
* user_list（该文件用来指示的默认账户在默认情况下也不能访问ftp）
* vsftpd.conf（vsftpd的主配置文件）。


#### 2. 设置FTP用户和目录
增加FTP用户
```
useradd -d /home/ftpuser -m ftpuser
echo "ftp_micros"| passwd --stdin ftpuser  #设置密码为: ftp_micros
```
>修改 /etc/vsftpd/ 下的 ftpusers、user_list文件，注释掉ftpuser用户，使ftpuser用户能够登录FTP服务器。


设置可访问目录
```
mkdir -p /nfs_share
chown -R ftpuser: /nfs_share
chmod 777 -R /nfs_share
```

设置ftp的默认访问路径
```
echo "local_root=/nfs_share" >>/etc/vsftpd/vsftpd.conf
```

#### 3. 修改FTP配置
修改 selinux 配置
```
getsebool -a | grep ftp
setsebool -P allow_ftpd_full_access on
setsebool -P ftp_home_dir on
```
修改 vsftpd.conf 配置
```
sed -i 's/^anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf
sed -i '$a\pasv_min_port=30000' /etc/vsftpd/vsftpd.conf
sed -i '$a\pasv_max_port=30999' /etc/vsftpd/vsftpd.conf
```

#### 4. 启动FTP服务器
```
systemctl start vsftpd
systemctl enable vsftpd
```
