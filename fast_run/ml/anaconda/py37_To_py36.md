# 安装Anaconda python 3.7要使用python3.6
```bash 
conda create -n py36 python=3.6 #建立python3.6的虚拟环境，并将虚拟环境命名为py36
# To activate this environment, use:
# > source activate py36
#
# To deactivate an active environment, use:
# > source deactivate
```

即想激活python3.6版本，使用命令：
```
source activate py36
```
退出python3.6，使用命令：
```
source deactivate
```

**[Tips]**:
在`~/.bash_profile`文件的末尾加上` source activate py36`，用户登录后将自动切换到(py36)环境  
```
cat <<EOM >>~/.bash_profile
#get python36
source activate py36
EOM
source ~/.bash_profile
```