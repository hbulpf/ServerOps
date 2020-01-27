#!/bin/bash
find /501_data/bak/gitlab -type f -mtime +14 -exec rm -f {} \;
rm -rf /var/opt/gitlab/backups/*
alias cp='cp'
nohup cp -p -r /bak/gitlab/backups/* /501_data/bak/gitlab/ &
cp -p -r /bak/gitlab/backups/`ls -t /bak/gitlab/backups/ |head -1` /var/opt/gitlab/backups/
alias cp='cp -i'
chmod 777 /var/opt/gitlab/backups/*.tar 
gitlab-ctl stop unicorn && gitlab-ctl stop sidekiq 
backup_num=$(ls -t /var/opt/gitlab/backups/ |head -1 |sed 's/_gitlab_backup.tar//g')
# gitlab-rake gitlab:backup:restore BACKUP=$(ls -t /var/opt/gitlab/backups/ |head -1 |sed 's/_gitlab_backup.tar//g') 
expect << EOF  
set timeout 30
spawn gitlab-rake gitlab:backup:restore BACKUP=$backup_num  
expect "Do you want to continue (yes/no)?"  
send "yes\r" 
set timeout 30 
expect "Do you want to continue (yes/no)?"  
send "yes\r"  
expect eof;  
EOF
gitlab-ctl start
