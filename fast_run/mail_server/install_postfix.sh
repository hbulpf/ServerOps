#!/bin/bash
yum -y install postfix #安装 postfix 发送邮件服务器

#配置 postfix 参数,讲下面的scnu-george.cn的域名换成自己的域名
postconf -e 'myhostname = server.scnu-george.cn'
postconf -e 'mydestination = localhost, localhost.localdomain'
postconf -e 'myorigin = $mydomain'
postconf -e 'mynetworks = 127.0.0.0/8'
postconf -e 'inet_interfaces = all'
postconf -e 'inet_protocols = all'
postconf -e 'mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain'
postconf -e 'home_mailbox = Maildir/'
postconf -e 'smtpd_sasl_type = dovecot'
postconf -e 'smtpd_sasl_path = private/auth'
postconf -e 'smtpd_sasl_auth_enable = yes'
postconf -e 'broken_sasl_auth_clients = yes'
postconf -e 'smtpd_sasl_authenticated_header = yes'
postconf -e 'smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination'
postconf -e 'smtpd_use_tls = yes'
postconf -e 'smtpd_tls_cert_file = /etc/pki/dovecot/certs/dovecot.pem'
postconf -e 'smtpd_tls_key_file = /etc/pki/dovecot/private/dovecot.pem'

# 配置 smtps
# vi /etc/postfix/master.cf  #去掉以下内容的注释标记
# smtps inet n - n - - smtpd
# -o smtpd_tls_wrappermode=yes
sed -i 's/^#\([ ]*smtps inet n\)/\1/' /etc/postfix/master.cf #去掉 smtps inet n - n - - smtpd 前面的注释
sed -i 's/^#\([ ]*-o smtpd_tls_wrappermode=yes\)/\1/' /etc/postfix/master.cf #去掉 -o smtpd_tls_wrappermode=yes 前面的注释，-o 前面要加之撒哟一个空格
systemctl enable postfix.service
systemctl start  postfix.service
echo "Mail Content" | mail -s "Mail Subject" 1020545428@qq.com #向1020545428@qq.com发送一封邮件测试邮件服务
# tail /var/log/maillog  #查看日志 
