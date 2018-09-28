#!/bin/bash
##安装驱动
lsmod | grep nouveau #如果未输出任何内容，即为禁用成功
#现在nvidia显卡驱动和cuda安装包到/bak
chmod a+x /bak/* #修改nvidia显卡驱动和cuda安装包为可执行文件
sh /bak/NVIDIA-Linux-x86_64-396.44.run
sh /bak/cuda_10.0.130_410.48_linux.run
##检测是否安装成功
nvidia-smi 


# nvidia-uninstall #uninstall the NVIDIA Driver
# Logfile : /tmp/cuda_install_23258.log
