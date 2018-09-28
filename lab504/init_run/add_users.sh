#!/bin/bash
groupadd docker  #增加docker组
while read line
do
    user=`echo $line | awk '{print $1}'`
    key=`echo $line | awk '{print $2}'`
    # create users    
    echo "create user [$user]"
    useradd -d /home/$user -m $user
    echo $key | passwd --stdin $user
    sed -i "/^root/a\\${user} ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
    # add all users to docker group
    usermod -aG docker $user
done < user_passwd