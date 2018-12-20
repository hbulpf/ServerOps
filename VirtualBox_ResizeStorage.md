# VirtualBox给虚拟机硬盘扩容
### 1. 在宿主机下增加 VDI 文件大小,要先将该虚拟机关机
```
VBoxManage modifyhd  centos_102.vdi  --resize 100000 #增加centos_102.vdi ,单位是M,即扩展到100000M
```
### 2. 在虚拟机中创建分区并扩容
1. 创建分区
```
sudo fdisk /dev/sda  # 创建分区
# 依次按 n , p ，回车，回车，回车, w ,根据提示创建分区
# 如创建的新分区为 /dev/sda3
# 此时需要 重启一次 虚拟机
mkfs.xfs /dev/sda3 # 格式化分区文件系统为 xfs ,xfs 是centos7默认文件系统
```
2. 创建物理卷
```
pvcreate /dev/sda3
```

3. 查看卷组名并将以上物理卷加入卷组
```
sudo vgdisplay #查看卷组名，我这里是centos，记着下面要用  
sudo vgextend centos /dev/sda3 #扩展到卷组  
```

4. 扩展逻辑卷的大小
```
lvdisplay # 查看逻辑卷，根据情况扩展需要扩容的逻辑卷，这里要扩展根卷，即扩展 /dev/centos/root 
sudo lvextend -L +91300 /dev/centos/root  #添加100000M到卷组中/dev/VolGroup/lv_root，单位是M 
# sudo lvextend /dev/centos/root /dev/sda   #这个命令和上面一样，但有时候不起作用  
```


5. 刷新已扩容的逻辑卷容量
```
xfs_growfs /dev/centos/root #刷新逻辑卷容量 
#sudo resize2fs /dev/centos/root #这也是刷新逻辑卷容量，但有时候这个命令会报错，用上面的命令 
sudo df -hT #查看磁盘卷容量大小 , 有时需要重启才能看到增加的容量
```

# 参考
1. virtualBox虚拟机linux（CentOS）硬盘扩容 . [https://blog.csdn.net/bright60/article/details/65434676](https://blog.csdn.net/bright60/article/details/65434676)
2. LVM XFS增加硬盘分区容量(resize2fs: Bad magic number in super-block while). [https://www.cnblogs.com/archoncap/p/5442208.html](https://www.cnblogs.com/archoncap/p/5442208.html)