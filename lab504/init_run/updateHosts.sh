sed -i '3,$d' /etc/hosts
cat >>/etc/hosts <<EOM
# aws hosts
172.31.25.125 micros-k8s-3 ec2-52-83-175-232.cn-northwest-1.compute.amazonaws.com.cn
172.31.21.32 micros-k8s-5 ec2-52-83-226-180.cn-northwest-1.compute.amazonaws.com.cn
172.31.33.109 micros-k8s-6 ec2-52-82-23-119.cn-northwest-1.compute.amazonaws.com.cn
172.31.12.75 k8s-test-1 ec2-52-82-36-226.cn-northwest-1.compute.amazonaws.com.cn
172.31.0.116 k8s-test-2 ec2-52-82-19-210.cn-northwest-1.compute.amazonaws.com.cn
172.31.13.165 k8s-test-3 ec2-52-82-16-213.cn-northwest-1.compute.amazonaws.com.cn
172.31.2.23 k8s-dev-1 ec2-52-82-30-248.cn-northwest-1.compute.amazonaws.com.cn
172.31.20.39 k8s-storage ec2-52-82-8-82.cn-northwest-1.compute.amazonaws.com.cn
172.31.18.88 ceph-rc-1 ec2-52-82-29-154.cn-northwest-1.compute.amazonaws.com.cn
172.31.17.193 ceph-rc-2 ec2-52-82-17-117.cn-northwest-1.compute.amazonaws.com.cn
172.31.20.221 ceph-rc-3 ec2-52-82-7-113.cn-northwest-1.compute.amazonaws.com.cn
EOM
cat /etc/hosts
