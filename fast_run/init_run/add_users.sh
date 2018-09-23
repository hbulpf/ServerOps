# create users
useradd -d /home/yaokun -m yaokun
echo "yaokun@micros"| passwd --stdin yaokun 
sed -i "/^root/a\yaokun ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers

useradd -d /home/lipengfei -m lipengfei
echo "lipengfei@micros"| passwd --stdin lipengfei 
sed -i "/^root/a\lipengfei ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers


useradd -d /home/chailiangyu -m chailiangyu
echo "chailiangyu@micros"| passwd --stdin chailiangyu 
sed -i "/^root/a\chailiangyu ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers

useradd -d /home/xuzhaoji -m xuzhaoji
echo "xuzhaoji@micros"| passwd --stdin xuzhaoji 
sed -i "/^root/a\xuzhaoji ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers

# add all users to docker group
usermod -aG docker "lipengfei"
usermod -aG docker "yaokun"
usermod -aG docker "chailiangyu"
usermod -aG docker "xuzhaoji"
