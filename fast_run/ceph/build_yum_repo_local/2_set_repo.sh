rm -rf /etc/yum.repos.d/ceph*
sudo cat << EOM > /etc/yum.repos.d/ceph.repo
[Ceph-13.2.1]
name=Ceph-13.2.1
baseurl=http://ec2-52-82-8-82.cn-northwest-1.compute.amazonaws.com.cn/ceph/rpm-mimic/el7/x86_64
gpgcheck=0
enabled=1
EOM
# sudo cp /etc/yum.repos.d/ceph.repo /etc/yum.repos.d/ceph.repo.rpmnew