sed -ri 's/^#?(PasswordAuthentication)\s+(yes|no)/\1 yes/' /etc/ssh/sshd_config
sed -ri 's/^#?(PermitRootLogin)\s+(yes|no)/\1 yes/' /etc/ssh/sshd_config
sed -ri 's/^/#/;s/sleep 10"\s+/&\n/' /root/.ssh/authorized_keys
service sshd restart

passwd 
micros_test
micros_test
