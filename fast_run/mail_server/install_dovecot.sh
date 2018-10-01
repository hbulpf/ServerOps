#!/bin/bash
yum -y install dovecot #安装dovecot 接收邮件服务器
#配置 安装dovecot 参数
cat <<EOF >>/etc/dovecot/dovecot.conf
ssl_cert = </etc/pki/dovecot/certs/dovecot.pem
ssl_key = </etc/pki/dovecot/private/dovecot.pem
protocols = imap pop3 lmtp
listen = *
mail_location = Maildir:~/Maildir
disable_plaintext_auth = no
EOF
vi /etc/dovecot/conf.d/10-master.conf  #去掉以下内容的注释标记
# unix_listener /var/spool/postfix/private/auth {  
#        mode = 0666  
# }
systemctl enable dovecot.service
systemctl start  dovecot.service
# tail /var/log/maillog  #查看日志 