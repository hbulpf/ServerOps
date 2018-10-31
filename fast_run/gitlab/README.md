# GitLab 使用与维护
## 1. 安装 GitLab
1. [脚本方式 gitlab-ce:11.3.0-ce.0](./install_gitlab.sh)
2. [docker 容器方式安装 gitlab-ce:11.3.0-ce.0](gitlab_docker.sh)

## 2. GitLab 备份与恢复
### Gitlab 数据备份与恢复
1. 使用一条命令即可创建完整的Gitlab备份:
```
gitlab-rake gitlab:backup:create
```
使用以上命令会在 `/var/opt/gitlab/backups` 目录下创建一个名称类似为 `1540817160_2018_10_29_11.3.0_gitlab_backup.tar` 的压缩包, 这个压缩包就是Gitlab整个的完整部分 , 其中开头的 `1540817160_2018_10_29_11.3.0`是备份创建的日期.

1. Gitlab 恢复
同样, Gitlab的从备份恢复也非常简单:

    (1) 停止相关数据连接服务
```
gitlab-ctl stop unicorn
gitlab-ctl stop sidekiq
```

    (2) 从 `1540817160_2018_10_29_11.3.0` 编号备份中恢复
```
gitlab-rake gitlab:backup:restore BACKUP=1540817160_2018_10_29_11.3.0
```

1. 启动Gitlab
```
sudo gitlab-ctl start
```

    > 需要注意: 新服务器上的Gitlab的版本必须与创建备份时的Gitlab版本号相同. 比如新服务器安装的是最新的7.60版本的Gitlab, 那么最好将老服务器的Gitlab 升级为7.60再进行备份.

### Gitlab 数据备份参数
1. Gitlab 修改备份文件默认目录,可以通过修改 `/etc/gitlab/gitlab.rb` 来修改默认存放备份文件的目录:
```
gitlab_rails['backup_path'] = '/mnt/backups'
```
`/mnt/backups` 修改为存放备份的目录即可, 修改完成之后使用 
```
gitlab-ctl reconfigure
```
命令重载配置文件即可.

1. Gitlab 自动备份,可以通过crontab使用备份命令实现自动备份:
```
sudo su -
crontab -e
```
加入以下, 实现每天凌晨2点进行一次自动备份:
```
0 2 * * * gitlab-rake gitlab:backup:create
```

## 3. GitLab 主从同步/双活

## 4. FAQ
1. 安装过程出现 `ruby_block[supervise_redis_sleep] action run`,一直卡无法往下进行！
解决方法:<br>
```
a. 按住CTRL+C强制结束
b. 运行:    sudo systemctl restart gitlab-runsvdir
c. 再次执行: sudo gitlab-ctl reconfigure
```

# 参考资料
1. rsync命令 . http://man.linuxde.net/rsync 
1. 实现Shell脚本自动备份Gitlab档案并同步到远程 . https://cloud.tencent.com/developer/article/1010390
1. 实用运维之gitlab主从实时同步 . https://www.jianshu.com/p/52de6a8d29d6
1. gitlab服务器迁移
 . https://cloud.tencent.com/developer/article/1111939
1. keepalived + rsync +inotify 实现真正的高效数据实时同步 . https://fandenggui.com/post/keepalived-rsync-inotify.html 
1. 使用GitLab Mirrors同步 GitHub 仓库 . http://www.itmuch.com/work/git-repo-sync-with-gitlab-mirrors/