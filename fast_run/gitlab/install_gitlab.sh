#!/bin/bash

# 如果内存不够，创建虚拟内存
dd if=/dev/zero of=/swap bs=1024 count=2048000  #创建一个2G的虚拟内存
mkswap /swap  2048000 #创建swap分区
swapon /swap
free -m  #或者swapon -s,查看虚拟内存信息
#设定虚拟内存开机自动挂载
cat <<EOF >>/etc/fstab  
/swap       swap    swap    defaults      0       0
EOF

# 预备工作
yum install -y curl policycoreutils-python  openssh-server openssh-clients 
systemctl enable sshd
systemctl start sshd
#yum install https://rpmfind.net/linux/remi/enterprise/6/test/x86_64/compat-mysql55-5.5.55-1.el6.remi.x86_64.rpm
yum install -y postfix #安装邮件服务
systemctl enable postfix
systemctl start postfix
firewall-cmd --permanent --add-service=http
systemctl reload firewalld

# 安装gitlab
yum install -y https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-11.3.0-ce.0.el7.x86_64.rpm
gitlab-ctl reconfigure

# vi  /etc/gitlab/gitlab.rb #在配置文件中修改端口
# unicorn['port'] = 8080 改为 unicorn['port'] = 10000
# external_url 'http://git.hnbdata.cn'
sed -i "/^\(#[ ]\)*external_url/c\external_url \'http://git.hnbdata.cn\'" /etc/gitlab/gitlab.rb  #修改 external_url
cat  /etc/gitlab/gitlab.rb | grep external_url  #输出 external_url确认结果正确
# external_url 'http://git.hnbdata.cn'
gitlab-ctl reconfigure
gitlab-ctl restart

#测试邮件服务
gitlab-rails console
Notify.test_email('1020545428@qq.com', 'Message Subject', 'Message Body').deliver_now

#默认账户为root 默认密码为5iveL!fe
