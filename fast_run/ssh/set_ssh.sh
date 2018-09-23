#!/bin/bash

# ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys
cat > ~/.ssh/config << EOF
Host micros-k8s-1
   Hostname  52.83.92.135
   User root
Host micros-k8s-2
   Hostname  52.82.7.66
   User root
Host micros-k8s-3
   Hostname  52.83.175.232
   User root
Host micros-k8s-5
   Hostname  52.83.226.180
   User root
Host micros-k8s-6
   Hostname  52.82.23.119
   User root
Host micros-k8s-8
   Hostname  52.82.32.252
   User root
Host k8s-test-1
   Hostname  52.82.36.226
   User lipengfei
Host k8s-test-2
   Hostname  52.82.19.210
   User lipengfei
Host k8s-test-3
   Hostname  52.82.16.213
   User lipengfei
Host k8s-dev-1
   Hostname  52.82.30.248
   User lipengfei
EOF
chmod 644 ~/.ssh/config

#把当前主机公钥加入远程主机

#方法1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-2
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-3
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-5
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-6
ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-8
ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-1
ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-2
ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-3
ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-dev-1

#方法2
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-1
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-2
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-3
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-5
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-6
# sshpass -p 'lipengfei' ssh-copy-id -i ~/.ssh/id_rsa.pub root@micros-k8s-7
# sshpass -p 'lipengfei@micros' ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-1
# sshpass -p 'lipengfei@micros' ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-2
# sshpass -p 'lipengfei@micros' ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-test-3
# sshpass -p 'lipengfei@micros' ssh-copy-id -i ~/.ssh/id_rsa.pub lipengfei@k8s-dev-1

#方法2
# sh ./read_host.sh

