# 安装 Nvidia 显卡驱动, CUDA,Tensorflow
>以下说明适用于 CentOS 7，仅在 CentOS 7.5 上测试
## 安装 Nvidia 显卡驱动
1. 装前准备工作：运行脚本 [0_nvidia_pre.sh](./0_nvidia_pre.sh) 即可   `sh ./0_nvidia_pre.sh`
2. 安装 Nvidia 显卡驱动，运行脚本 [1_nvidia_install.sh](./1_nvidia_install.sh) 即可 `sh ./1_nvidia_install.sh`
```
lsmod | grep nouveau #检测开源驱动是否禁用成功，如果未输出任何内容，即为禁用成功
cd /bak/driver/  #nvidia显卡驱动在到 /bak/driver/ 目录下
chmod a+x NVIDIA-Linux-x86_64-396.44_forK20.run #根据显卡型号安装驱动，这里安装 k20m 的驱动
./NVIDIA-Linux-x86_64-396.44_forK20.run #安装 k20m 的驱动
nvidia-smi  #检测是否安装成功
# nvidia-uninstall #uninstall the NVIDIA Driver
# Logfile : /tmp/cuda_install_23258.log
```

## 安装 CUDA
### 下载 cuda tookit
1. 下载 cuda-9.0 tookit
```
cd /bak/driver/cuda_run
wget -b https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
wget -b https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda_9.0.176.1_linux-run
wget -b https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda_9.0.176.2_linux-run
wget -b https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/3/cuda_9.0.176.3_linux-run
wget -b https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/4/cuda_9.0.176.4_linux-run
```

1. 安装 cuda-9.0 tookit
```
yum install epel-release  #安装依赖
yum install --enablerepo=epel dkms #安装依赖
cd /bak/driver/cuda_run/ && chmod +x cuda*
./cuda_9.0.176_384.81_linux-run
cat <<EOM >>/etc/profile
export PATH="$PATH:/usr/local/cuda/bin"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64"
EOM
source /etc/profile
./cuda_9.0.176.1_linux-run
./cuda_9.0.176.2_linux-run 
./cuda_9.0.176.3_linux-run
./cuda_9.0.176.4_linux-run 
```

1. 安装CUDA样例程序 
```
cuda-install-samples-8.0.sh <dir> 
```
    该命令已经在系统环境变量中，dir为自定义目录；执行完该命令之后，如果成功，会在dir中生成一个 NVIDIA_CUDA-9.0_Samples 目录 ,假设目录为 `/root/NVIDIA_CUDA-9.0_Samples`

1. 编译样例程序，校验CUDA安装
```
cd /root/NVIDIA_CUDA-9.0_Samples 
make
```

1. 运行样例程序 
```
/root/NVIDIA_CUDA-9.0_Samples/bin/x86_64/linux/release/deviceQuery
```
输出结果末端显示如下，即CUDA安装校验完成。 
```
......
deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 8.0, CUDA Runtime Version = 8.0, NumDevs = 2, Device0 = Tesla M40, Device1 = Tesla M40 
Result = PASS 
```

## 安装 cudnn
cudnn 下载地址： [https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download) (需注册nvidia账号并登录)
```
cd /bak/driver　&& tar -xvzf cudnn-9.0-linux-x64-v7.3.1.20.tgz 
cd cuda 
cp -r ./include/*.h /usr/local/cuda/include/
cp -r ./lib64/libcudnn* /usr/local/cuda/lib64/ 
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn* 
```

## tensorflow1.0安装
```
yum install python-devel libffi-devel openssl-devel #安装必备依赖
wget https://bootstrap.pypa.io/get-pip.py  #下载pip安装文件
python get-pip.py # 安装 pip
```

1. 安装CPU版本tensorflow
```
pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp27-none-linux_x86_64.whl #安装CPU版本tensorflow
```

2. 安装GPU版本tensorflow
```
pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0-cp27-none-linux_x86_64.whl #安装GPU版本tensorflow
```

3. 测试tensorflow
```
import tensorflow as tf
print(tf.__version__)
hello=tf.constant('hello world') 
sess = tf.Session() 
print(sess.run(hello))  
```

# 卸载

### 卸载 cuda tookit
卸载cuda-toolkit
```
/usr/local/cuda/bin/uninstall_*** # ***换成自己的文件名
```
### 卸载 显卡驱动
假如安装的是NVIDIA-Linux-x86-340.96.run , 卸载运行如下命令：
```
sh NVIDIA-Linux-x86-270.41.19.run --uninstall  # NVIDIA-Linux-x86-270.41.19.run换成自己的文件名
```



# 参考
1. TESLA DRIVER FOR LINUX X64 驱动下载 . https://www.nvidia.cn/Download/driverResults.aspx/140749/cn
1. cuda-9.0 tookit下载地址：https://developer.nvidia.com/cuda-90-download-archive?target_os=Linux&target_arch=x86_64&target_distro=CentOS&target_version=7&target_type=runfilelocal
1. NVIDIA CUDA Toolkit Release Notes 版本支持 . https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
1. GPU版Tensorflow安装 centos7 64位 . https://blog.csdn.net/wang2008start/article/details/71319970

------------
@504实验室<br>
友情贡献： @[`鹏飞`](https://github.com/RunAtWorld)   @[`加伟`](https://github.com/1846263444)   