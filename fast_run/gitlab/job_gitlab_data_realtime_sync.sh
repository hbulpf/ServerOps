#!/bin/bash
# File name:job_gitlab_data_realtime_sync.sh
# File path: /opt/script/job_gitlab_data_realtime_sync.sh
src_dir="/var/opt/gitlab/git-data"
rsync_module_name="gitlab_data"
# 如需多个节点同步，可以填写多个IP
# 用这种判断主机名的方法，实现通用的脚本
# 就无需每个节点都得单独修改脚本的 dest_ip 变量内容了。
if [[ $(hostname) =~ 1-1-1 ]];then
    dest_ip="119.29.13.35"
else
    dest_ip="10.1.1.1"
fi
rsync_user="gitlab"
rsync_pass="/etc/rsyncd/gitlab_client.pass"
#
. /etc/init.d/functions
# 开启inotifywait文件监控，当文件发生变化进行文件同步
cd ${src_dir}
inotifywait -mrq -e modify,attrib,close_write,move,create,delete --format '%e %w%f' ./ |
while read file;do
    INO_EVENT=$(echo $file | awk '{print $1}')      # 把inotify输出切割 把事件类型部分赋值给INO_EVENT
    INO_FILE=$(echo $file | awk '{print $2}')       # 把inotify输出切割 把文件路径部分赋值给INO_FILE
    # 判断事件类型
    #增加、修改、写入完成、移动进事件
    #增、改放在同一个判断，因为他们都肯定是针对文件的操作，即使是新建目录，要同步的也只是一个空目录，不会影响速度。
    if [[ $INO_EVENT =~ 'CREATE' ]] || [[ $INO_EVENT =~ 'MODIFY' ]] || [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]];then
        for ip in ${dest_ip};do
            rsync -azcR --password-file=${rsync_pass} $(dirname ${INO_FILE}) ${rsync_user}@${ip}::${rsync_module_name}
            # INO_FILE变量代表文件路径  -c校验文件内容
            #仔细看 上面的rsync同步命令 源是用了$(dirname ${INO_FILE})变量 即每次只针对性的同步发生改变的文件的目录
            # (只同步目标文件的方法在生产环境的某些极端环境下会漏文件 现在可以在不漏文件下也有不错的速度 做到平衡)
            # 然后用-R参数把源的目录结构递归到目标后面 保证目录结构一致性
        done
    fi
    #修改属性事件（指 touch chgrp chmod chown等操作）
    if [[ $INO_EVENT =~ 'ATTRIB' ]];then
        # 如果修改属性的是目录 则不同步，因为同步目录会发生递归扫描，等此目录下的文件发生同步时，rsync会顺带更新此目录。
        if [ ! -d "$INO_FILE" ];then
            for ip in ${dest_ip};do
                rsync -azcR --password-file=${rsync_pass} $(dirname ${INO_FILE}) ${rsync_user}@${ip}::${rsync_module_name}
            done
        fi
    fi
    #删除、移动出事件
    if [[ $INO_EVENT =~ 'DELETE' ]] || [[ $INO_EVENT =~ 'MOVED_FROM' ]];then
        for ip in ${dest_ip};do
            rsync -azcR --delete --password-file=${rsync_pass} $(dirname ${INO_FILE}) ${rsync_user}@${ip}::${rsync_module_name}
            #看rsync命令 如果直接同步已删除的路径${INO_FILE}会报no such or directory错误 所以这里同步的源是被删文件或目录的上一级路径，并加上--delete来删除目标上有而源中没有的文件，这里不能做到指定文件删除，如果删除的路径越靠近根，则同步的目录月多，同步删除的操作就越花时间。这里有更好方法的同学，欢迎交流。
        done
    fi
done