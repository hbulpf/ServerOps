#卸载旧版版本
sudo yum remove -y docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-selinux \
	docker-engine-selinux \
	docker-engine

# 安装依赖
sudo yum install -y yum-utils \
	device-mapper-persistent-data \
	lvm2	

#使用国内安装源
sudo yum-config-manager \
	--add-repo \
	https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo

sudo yum-config-manager --enable docker-ce-edge

#开始安装
sudo yum makecache fast
sudo yum install -y docker-ce

#当前用户加入 docker 用户组
sudo groupadd docker
sudo usermod -aG docker $USER

#添加镜像加速器
# curl -sSL http://oyh1cogl9.bkt.clouddn.com/setmirror.sh | sh -s reg-mirror.qiniu.com  #使用七牛云镜像加速
#使用aliyun镜像加速
if [[ ! -f /etc/docker/daemon.json ]]; then 
    if [[ ! -d /etc/docker ]]; then 
        mkdir -p /etc/docker
    fi
	touch /etc/docker/daemon.json
fi
cat <<EOF >>/etc/docker/daemon.json
{
  "registry-mirrors": ["https://po68u8ag.mirror.aliyuncs.com"]
}
EOF
#使用docker-cn镜像加速
# cat <<EOF >>/etc/docker/daemon.json
# {
#   "registry-mirrors": ["https://registry.docker-cn.com"]
# }
# EOF

#也可以在启动docker使用参数临时设置镜像加速器
# dockerd --registry-mirror=https://registry.docker-cn.com
# dockerd --registry-mirror=https://po68u8ag.mirror.aliyuncs.com

#启动docker并加入开机启动
systemctl start docker
systemctl enable docker

#开启网络转发
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
#重启网络服务，让配置生效
systemctl restart network 
#查看是否成功,如果返回为“net.ipv4.ip_forward = 1”则表示成功
sysctl net.ipv4.ip_forward