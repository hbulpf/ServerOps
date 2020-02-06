# 安装 httpd 服务

# 常见问题
> 遇到问题，先看日志 ` tail /var/log/httpd/error_log `
httpd 服务的默认静态文件路径 `/var/www/html/`


### 1. Forbidden问题
  访问时总是出现 `Forbidden错误`,原因可能有多种，但常见的解决方法有
  1. 关闭Selinux 
	- 临时关闭Selinux，重启后无效
		```
		setenforce 0 #临时关闭Selinux
		sestatus -v  #查看Selinux Current mode是否为 permissive

		SELinux status:                 enabled
		SELinuxfs mount:                /sys/fs/selinux
		SELinux root directory:         /etc/selinux
		Loaded policy name:             targeted
		Current mode:                   permissive
		Mode from config file:          error (Success)
		Policy MLS status:              enabled
		Policy deny_unknown status:     allowed
		Max kernel policy version:      31
		.......
		```
	- 永久关闭Selinux,重启后也有效
		```
		sed -i "s/^SELINUX=.*/SELINUX=disable/" /etc/selinux/config  #永久关闭Selinux
		```
# 参考

1. Linux之Web服务(2)Httpd服务配置之一 . http://blog.51cto.com/mengzhaofu/1860321
2. httpd之Forbidden问题解决 . http://blog.51cto.com/1inux/1640243