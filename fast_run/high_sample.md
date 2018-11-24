# ps
1. 杀掉包含 'gitlab' 关键词的所有进程
```
ps -ef| grep gitlab |grep -v grep|cut -c 9-15|xargs kill -9
```
也可以使用
```
ps -aux|grep gitlab|grep -v grep |awk '{print $1}'|xargs kill -9
```
> grep gitlab 是找出含有 gitlab 的进程
> grep -v grep 是去掉 grep 本身
> cut -c 9-15 是截取 9-15 位的字符， awk '{print $1}' 是打印出索引为 1 的参数，都是取 pid
> xargs kill -9 是将前面的 pid 作为参数传进来杀死

# sed
1. 增删注释   
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

2. 替换含有特定字符的某一行
 将含有以 '#external_url' 或 空格external_url 开头的行替换为 external_url 'http://scnu-george.cn'
```
sed -i "/^\(#[ ]\)*external_url/c\external_url \'http://scnu-george.cn\'" /etc/gitlab/gitlab.rb 
```

3. 在以 `root` 开头的行下面插入
```
sed -i "/^root/a\\${user} ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
```

4. 替换字符串
```
Echo "2014-08-22 01:55:11" | sed 's/-//g' | sed 's/ //g' | sed 's/://g'
结果为：20140822015511
```
