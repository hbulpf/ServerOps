### nas存储器中的共享目录挂载

将NAS存储器中要分享的文件夹信息加入到fstab中
```
vi /etc/fstab
```
原配置如下：
```
192.168.200.27:/volume1/501_common /501_raid_common nfs defaults 0 0
192.168.200.27:/volume1/501_data /501_data nfs defaults 0 0
192.168.200.27:/volume1/image_recognition /image_recognition nfs defaults 0 0
192.168.200.27:/volume1/dev_materials /dev_materials nfs defaults 0 0
192.168.200.27:/volume1/postgraduates /postgraduates nfs defaults 0 0
```
保存并挂载：
```
mount -a
```
完成
