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

#生成repodata
yum install -y createrepo
createrepo -p /nfs_share/ceph/rpm-mimic
createrepo -p /nfs_share/ceph/ceph-deploy
