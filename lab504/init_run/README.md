# 服务器初始化脚本
1. 修改hosts脚本 : [updateHosts.sh](updateHosts.sh)
2. 增加用户: [add_users.sh](add_users.sh)  本脚本用到 [user_passwd](user_passwd), [user_passwd](user_passwd) 第一列为用户名，第二列为用户密码
3. 检测节点，安装相关工具: [check_all_node.sh](check_all_node.sh)
4. 设置允许 ssh 登录: [enale_ssh_passwd.sh](enale_ssh_passwd.sh)
5. 安装docker-ce: [install_docker.sh](install_docker.sh)