#!/bin/bash
user='webui'
key='webui@sfyh'
echo "create user [$user]"
useradd -d /home/$user -m $user
echo $key | passwd --stdin $user
sed -i "/^root/a\\${user} ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
usermod -aG docker ${user}
