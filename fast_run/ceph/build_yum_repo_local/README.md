# 搭建 Ceph 本地 yum 源
## 1. 下载 Ceph 所需要的包
从 [Ceph官方源](http://download.ceph.com) 下载 rpm-mimic 版本所需要的包到 `/nfs_share/ceph/rpm-mimic/el7/x86_64` 。[Ceph官方源](http://download.ceph.com) rpm-mimic 有多个子版本,为节省时间，只下载需要的 `13.2.1` 的版本

```
#设置存放rpm包的基目录
base_dir="/nfs_share/"
#下载 ceph-deploy-2.0.1
ceph_deploy_dir="${base_dir}ceph/rpm-mimic/el7/noarch"
mkdir -p $ceph_deploy_dir
cd $ceph_deploy_dir
curl -O http://download.ceph.com/rpm-mimic/el7/noarch/ceph-deploy-2.0.1-0.noarch.rpm

#下载 ceph rpm 13.2.1
ceph_dir="${base_dir}ceph/rpm-mimic/el7/x86_64"
cd ${ceph_dir}
#下载rpm包名字到list
curl http://download.ceph.com/rpm-mimic/el7/x86_64/ | grep 13.2.1 >> tmp
cat tmp | awk '{print $2}'|cut -d "=" -f 2 | cut -d '"' -f 2 >> list
#下载rpm文件到本地
for rpmname in $(cat list)
do
	curl -O "http://download.ceph.com/rpm-mimic/el7/x86_64/${rpmname}"
done
rm -rf tmp list
```
## 1. 自动生成repodata
```
createrepo -p ${ceph_dir}
```
## 1. 在需要装 Ceph 的主机上创建repo文件
```
[Ceph-10.2.9]
name=Ceph-10.2.9
baseurl=http://yum server IP/yum/x86_64/ceph
gpgcheck=0
enabled=1
```


# 参考
1. https://blog.csdn.net/tz_gg/article/details/80401886