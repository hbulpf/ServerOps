user='yaokun'
key='yaokun@hsdocker'
# create users    
echo "create user [$user]"
useradd -d /home/$user -m $user
echo $key | passwd --stdin $user
sed -i "/^root/a\\${user} ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
# add all users to docker group
usermod -aG docker $user
usermod -aG hadoop $user