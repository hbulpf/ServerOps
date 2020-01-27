#/bin/bash
sudo wget  https://repo.anaconda.com/archive/Anaconda2-5.3.1-Linux-x86_64.sh #下载anaconda 2.7
# sudo wget  https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh #下载anaconda 3.7
# sudo wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.3.1-Linux-x86_64.sh #使用清华大学源下载anaconda 3.7
sh Anaconda2-5.3.1-Linux-x86_64.sh

cat <<EOM >>~/.bash_profile
#anaconda python2.7.5 (by lipengfei)
export PATH="/opt/anaconda2/bin:$PATH"
EOM
source ~/.bash_profile