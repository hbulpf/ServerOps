# VirtualBox 命令行
1. 列出系统已有的虚拟机 
    - 列出所有虚拟机  `VBoxManage list vms`  
    - 列出运行中的虚拟机  `VBoxManage list runningvms `
2. 启动虚拟机
    - 使用gui类型启动虚拟机  `VBoxManage startvm XP --type gui`  
    - 使用headless类型启动虚拟机  `VBoxManage startvm "XP" --type headless`  或者 `VBoxHeadless --startvm "XP"`
3. 关闭虚拟机，等价于点击系统关闭按钮，正常关机 `VBoxManage controlvm XP acpipowerbutton`
4. 关闭虚拟机，等价于直接关闭电源，非正常关机  `VBoxManage controlvm XP poweroff`
5. 暂停虚拟机的运行  `VBoxManage controlvm XP pause`
6. 恢复暂停的虚拟机  `VBoxManage controlvm XP resume`
7. 保存当前虚拟机的运行状态  `VBoxManage controlvm XP savestate`
8. 使用vnc连接: 
```
VBoxHeadless -s winxp --vnc --vncport 5900 --vncpass password
```

# 参考
1. 使用命令行启动VirtualBox虚拟机 . [https://blog.csdn.net/junbujianwpl/article/details/52821933](https://blog.csdn.net/junbujianwpl/article/details/52821933)
