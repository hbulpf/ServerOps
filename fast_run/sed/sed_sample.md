#### 1. 增删注释   
输出原文件为：
```
cat  zimu.txt
# bicbbb
# jcccnd
```
```
#以'# bic'开头 删除注释
sed -i 's/^#\([ ]*bic\)/\1/' zimu.txt  #\1的就类似于前面的'bic'，'()'里面是一个整体,\1就是复制这个位置的内容,如果有第2个,那么\2就是复制第2个位置的内容

#以'bic'开头 添加注释
sed -i 's/^[ ]*bic/#&/' zimu.txt  # '&'是匹配任意字符（就是啥都行），这条命令是替换以'bic'开头的为 '#bic'
```

#### 2. 替换含有特定字符的某一行
 将含有以 '#external_url' 或 空格external_url 开头的行替换为 external_url 'http://scnu-george.cn'
```
sed -i "/^\(#[ ]\)*external_url/c\external_url \'http://scnu-george.cn\'" /etc/gitlab/gitlab.rb 
```