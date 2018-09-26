#!/bin/bash
useradd -d /home/cephuser -m hnbd
echo "hnbdata"| passwd --stdin hnbd 
echo "hnbd ALL = (ALL:ALL) NOPASSWD:ALL" | tee /etc/sudoers

#查看所有用户,500以上是非系统用户了.其它为系统用户.
cat /etc/passwd
# cat /etc/passwd |cut -f 1 -d 