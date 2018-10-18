#!/bin/bash
yum install yum-utils
yum install -y yum-plugin-downloadonly
yum install -y https://download.ceph.com/rpm-mimic/el7/noarch/ceph-release-1-0.el7.noarch.rpm
yum clean all && yum makecache
yum install --downloadonly  --downloaddir=/nfs_share/ceph/ceph-deploy ceph-deploy-2.0.1-0

yum install -y yum-utils && \
yum-config-manager --add-repo https://dl.fedoraproject.org/pub/epel/7/x86_64/ && \
yum install --nogpgcheck -y epel-release && \
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
rm -f /etc/yum.repos.d/dl.fedoraproject.org*

cat << EOM > /etc/yum.repos.d/ceph.repo  
[Ceph]
name=Ceph packages for \$basearch
baseurl=http://download.ceph.com/rpm-mimic/el7/\$basearch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
priority=1

[Ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-mimic/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
priority=1

[ceph-source]
name=Ceph source packages
baseurl=http://download.ceph.com/rpm-mimic/el7/SRPMS
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
priority=1
EOM
yum install --downloadonly  --downloaddir=/nfs_share/ceph/rpm-mimic ceph ceph-radosgw