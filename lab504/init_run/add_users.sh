#!/bin/bash
groupadd docker  #增加docker组
for line in $(cat user_passwd)
do
	user=$(echo $line | awk '{print $1}')
	pwd=$(echo $line | awk '{print $2}')
	# create users
	useradd -d /home/$user -m $user
	echo "${pwd}"| passwd --stdin $user 
	sed -i "/^root/a\\${user} ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
	# add all users to docker group
	usermod -aG docker $user
done
