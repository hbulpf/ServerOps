#!/bin/bash
LANG=en_US.UTF-8

urlPrefix="https://download.xp.cn"
randNum=$RANDOM

Install_Docker()
{
	#download docker
	mkdir -p /usr/local/phpstudy/docker-18.09.6
	wget $urlPrefix/docker/docker-18.09.6.tar.xz -O /usr/local/phpstudy/docker-18.09.6.tar.xz
	xz -dv /usr/local/phpstudy/docker-18.09.6.tar.xz
	tar -xvf /usr/local/phpstudy/docker-18.09.6.tar -C /usr/local/phpstudy/docker-18.09.6
	rm -rf /usr/local/phpstudy/docker-18.09.6.tar

	#create link
	ln -sb /usr/local/phpstudy/docker-18.09.6/containerd /usr/bin/containerd
	ln -sb /usr/local/phpstudy/docker-18.09.6/containerd-shim /usr/bin/containerd-shim
	ln -sb /usr/local/phpstudy/docker-18.09.6/ctr /usr/bin/ctr
	ln -sb /usr/local/phpstudy/docker-18.09.6/docker /usr/bin/docker
	ln -sb /usr/local/phpstudy/docker-18.09.6/dockerd /usr/bin/dockerd
	ln -sb /usr/local/phpstudy/docker-18.09.6/docker-init /usr/bin/docker-init
	ln -sb /usr/local/phpstudy/docker-18.09.6/docker-proxy /usr/bin/docker-proxy
	ln -sb /usr/local/phpstudy/docker-18.09.6/runc /usr/bin/runc
	
	
	#check ubuntu14.04
	u14_04=`cat /etc/issue`
	if [[ $u14_04 =~ "Ubuntu 14.04" ]];then
		ln -sb /usr/local/phpstudy/docker-18.09.6/cgroup-lite/cgroups-mount /bin/cgroups-mount
		ln -sb /usr/local/phpstudy/docker-18.09.6/cgroup-lite/cgroups-umount /bin/cgroups-umount
		ln -sb /usr/local/phpstudy/docker-18.09.6/cgroup-lite/cgroup-lite.conf /etc/init/cgroup-lite.conf
		/bin/cgroups-mount
	fi


	#start docker
	nCount=20
	pid=`/usr/local/phpstudy/system/module/getPidByExe /usr/local/phpstudy/docker-18.09.6/dockerd`
	while [[ $pid == "0" ]] && [[ $nCount>0 ]]
	do
		dockerd > /dev/null 2>&1 &
		((nCount-=1))
		sleep 1
		pid=`/usr/local/phpstudy/system/module/getPidByExe /usr/local/phpstudy/docker-18.09.6/dockerd`
	done
	if [[ $pid == "0" ]];then
		echo -e "\033[31m docker daemon start error! \033[0m"
		echo -e "\033[31m phpstudy start error,please connect us https://www.xp.cn \033[0m"
		End_Install
	fi
	unset pid	

	#download image
	wget $urlPrefix/docker/centos_env.tar.xz -O /usr/local/phpstudy/docker-18.09.6/centos_env.tar.xz
	xz -dv /usr/local/phpstudy/docker-18.09.6/centos_env.tar.xz
	
	wget $urlPrefix/docker/centos_ssl.tar.xz -O /usr/local/phpstudy/docker-18.09.6/centos_ssl.tar.xz
	xz -dv /usr/local/phpstudy/docker-18.09.6/centos_ssl.tar.xz
	
	#load image
	docker load -i /usr/local/phpstudy/docker-18.09.6/centos_env.tar
	docker load -i /usr/local/phpstudy/docker-18.09.6/centos_ssl.tar
	#create container
	docker create -it --name centos_env --network=host -v /usr/local/phpstudy:/usr/local/phpstudy -v /www:/www  centos:v4
	docker create -it --name centos_ssl --network=host -v /usr/local/phpstudy:/usr/local/phpstudy -v /www:/www  centos_ssl:v1
}

Install_Php()
{
	#download php
	mkdir -p /usr/local/phpstudy/soft/php
	wget $urlPrefix/soft/php/php-5.5.38.tar.xz -O /usr/local/phpstudy/soft/php/php-5.5.38.tar.xz
	xz -dv /usr/local/phpstudy/soft/php/php-5.5.38.tar.xz
	tar -xvf /usr/local/phpstudy/soft/php/php-5.5.38.tar -C /usr/local/phpstudy/soft/php
	
	rm -rf /usr/local/phpstudy/soft/php/php-5.5.38.tar
}

Install_Apache()
{
	#download 
	mkdir -p /usr/local/phpstudy/soft/apache
	wget $urlPrefix/soft/apache/httpd-2.4.39.tar.gz -O /usr/local/phpstudy/soft/apache/httpd-2.4.39.tar.gz
	tar -zxvf /usr/local/phpstudy/soft/apache/httpd-2.4.39.tar.gz -C /usr/local/phpstudy/soft/apache
	
	rm -rf /usr/local/phpstudy/soft/apache/httpd-2.4.39.tar.gz
}

Install_Nginx()
{
	mkdir -p /usr/local/phpstudy/soft/nginx
	wget $urlPrefix/soft/nginx/nginx-1.15.tar.gz -O /usr/local/phpstudy/soft/nginx/nginx-1.15.tar.gz
	tar -zxvf /usr/local/phpstudy/soft/nginx/nginx-1.15.tar.gz -C /usr/local/phpstudy/soft/nginx
	
	rm -rf /usr/local/phpstudy/soft/nginx/nginx-1.15.tar.gz
}


Install_Ftp()
{
	mkdir -p /usr/local/phpstudy/soft/ftp
	wget $urlPrefix/soft/ftp/pureftpd-1.0.47.tar.gz -O /usr/local/phpstudy/soft/ftp/pureftpd-1.0.47.tar.gz
	tar -zxvf /usr/local/phpstudy/soft/ftp/pureftpd-1.0.47.tar.gz -C /usr/local/phpstudy/soft/ftp
	
	rm -rf /usr/local/phpstudy/soft/ftp/pureftpd-1.0.47.tar.gz
}

Install_WebPanel()
{
	mkdir -p /usr/local/phpstudy/web

	
	wget $urlPrefix/web/web.tar.xz -O /usr/local/phpstudy/web/web.tar.xz
	xz -dv /usr/local/phpstudy/web/web.tar.xz
	tar -xvf /usr/local/phpstudy/web/web.tar -C /usr/local/phpstudy/web
	
	rm -rf /usr/local/phpstudy/web/web.tar
}

Install_System()
{
	mkdir -p /usr/local/phpstudy/system
	wget $urlPrefix/system/system.tar.gz -O /usr/local/phpstudy/system.tar.gz
	tar -zxvf /usr/local/phpstudy/system.tar.gz -C /usr/local/phpstudy/system

	#create link
	ln -sb /usr/local/phpstudy/system/phpstudyctl /usr/bin/phpstudy
	ln -sb /usr/local/phpstudy/system/phpstudyctl /usr/bin/xp
	
	ln -sb /usr/local/phpstudy/system/module/php /usr/bin/php
	
	
	LOGINPWD=`< /dev/urandom tr -dc 0-9-A-Z-a-z-|head -c ${1:-10};echo`
	export LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
	#init login pwd
	/usr/local/phpstudy/system/phpstudy -initpwd $LOGINPWD
	#write cpucore to web
	/usr/local/phpstudy/system/phpstudy -cpucore > /usr/local/phpstudy/web/cpucore
	export -n LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
	
	
	
	rm -rf /usr/local/phpstudy/system.tar.gz
}


Install_Others()
{
	#install fixeddata
	mkdir -p /usr/local/phpstudy/fixeddata
	wget $urlPrefix/fixeddata/fixeddata.tar.gz -O /usr/local/phpstudy/fixeddata/fixeddata.tar.gz
	tar -zxvf /usr/local/phpstudy/fixeddata/fixeddata.tar.gz -C /usr/local/phpstudy/fixeddata
	
	if [ -d "/www/" ];then 
		mv /www /www_$randNum
	fi
		
	cp -rf /usr/local/phpstudy/fixeddata/www /
	rm -rf /usr/local/phpstudy/fixeddata/www
		
	
	rm -rf /usr/local/phpstudy/fixeddata/fixeddata.tar.gz
	
	
	
	#install vhost
	mkdir -p /usr/local/phpstudy/vhost
	wget $urlPrefix/vhost/vhost.tar.gz -O /usr/local/phpstudy/vhost/vhost.tar.gz
	tar -zxvf /usr/local/phpstudy/vhost/vhost.tar.gz -C /usr/local/phpstudy/vhost
	rm -rf /usr/local/phpstudy/vhost/vhost.tar.gz
}


Set_AutoStart()
{
	ubuntu=`cat /etc/issue`
    if [[ $ubuntu =~ "Ubuntu" ]];then
		result=`cat /etc/rc.local`
		if [[ $result =~ '/usr/local/phpstudy/system/phpstudyctl' ]];then
			echo 'already set autostart'
		else
			echo '#!/bin/bash' > /etc/rc.local
			echo '/usr/local/phpstudy/system/phpstudyctl -start' >> /etc/rc.local
			chmod +x /etc/rc.local
		fi
    else
        
		result=`cat /etc/rc.d/rc.local`
                if [[ $result =~ '/usr/local/phpstudy/system/phpstudyctl' ]];then
                        echo 'already set autostart'
                else
                        echo '/usr/local/phpstudy/system/phpstudyctl -start' >>/etc/rc.d/rc.local
                fi
		
        chmod +x /etc/rc.d/rc.local
        
    fi
}

Start_All()
{
	/usr/local/phpstudy/system/phpstudyctl -start
	
	export LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
	wlanip=`/usr/local/phpstudy/system/phpstudy -wlanip`
	port=`/usr/local/phpstudy/system/phpstudy -port`
	token=`/usr/local/phpstudy/system/phpstudy -token`
		
	export -n LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
}

Start_Install()
{
	dir=$RANDOM
	mkdir $dir
	cd $dir

	#check root
	who=`whoami`
	if [ "$who" != "root" ];then
		echo -e "\033[31m请先切换到root身份登录系统后再安装,退出安装\033[0m"
		End_Install
	fi


	#check os 64bit 
	b64bit=`getconf LONG_BIT`
	if [ "$b64bit" != "64" ];then
		echo -e "\033[31mphpstudy暂时还不支持32位系统,退出安装\033[0m"
		End_Install
	fi

	#check os version
	py26=$(python -V 2>&1|grep '2.6.')
	if [ "$py26" != "" ];then
		echo -e "\033[31mphpstudy暂时还不支持centos7以下版本系统,退出安装\033[0m"
		End_Install
	fi	

	which docker >/dev/null
    if [[ $? -eq 0 ]];then
		echo -e "\033[31m检测到已经安装过docker,已放弃本次安装,强烈建议您将phpstudy安装至纯净的系统里\033[0m"
		echo -e "\033[31mdocker has installed,this install progress is termination,please install phpstudy into a clean system\033[0m"
		End_Install
	fi

	#check 
	if [[ -d "/usr/local/phpstudy" ]];then
		echo -n -e "\033[31mphpstudy 可能已经安装过,继续安装会覆盖原有的文件,请谨慎操作,继续请按Y/y,否则按任意键退出安装:\033[0m"
		read CH
				
		if [[ "$CH" != "Y" ]] && [[ "$CH" != "y" ]];then
			echo '退出安装'
			End_Install
		else
			pkill phpstudy
			phpstudy -stop
			docker stop centos_env
			docker rm centos_env
			docker rmi centos:v4
			pkill dockerd
			mv /usr/local/phpstudy /usr/local/phpstudy_$randNum
		fi
	fi
	
}





End_Install()
{
	cd ..
	#rm -rf ./$dir
	rm -rf ./install.sh*
	exit
}

Set_Privilege()
{
	chmod -R 700 /usr/local/phpstudy
	chmod -R 700 /www
	docker exec centos_env chown -R www:www /www
	docker exec centos_env chown -R www:www /usr/local/phpstudy

}



Show_Result()
{





echo ""
echo -e "=================\033[35m安装完成\033[0m=================="
echo ""
echo -e "\033[35m请用浏览器访问面板http://$wlanip:$port/$token\033[0m"
echo -e "\033[35m系统初始账号:admin\033[0m"
echo -e "\033[35m系统初始密码:$LOGINPWD\033[0m"
echo -e "\033[35m官网https://www.xp.cn\033[0m"
echo -e "\033[35m如果使用的是云服务器，请至安全组开放9080端口\033[0m"
echo -e "\033[35m如果使用ftp，请开放21以及30000-30050端口\033[0m"
echo -e "\033[35m如果在虚拟机安装，请将ip换成虚拟机内网ip\033[0m"
echo  ""
echo '==========================================='


echo "感谢您的耐心等待,安装已经完成" > /usr/local/phpstudy/install.result
echo "请用浏览器访问面板http://$wlanip:$port/$token"  >> /usr/local/phpstudy/install.result
echo "系统初始账号:admin" >> /usr/local/phpstudy/install.result
echo "系统初始密码:$LOGINPWD" >> /usr/local/phpstudy/install.result
echo "官网https://www.xp.cn"  >> /usr/local/phpstudy/install.result



}



Init_System()
{
	sleep 5
	export LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
	/usr/local/phpstudy/system/phpstudy -showindex 1 #apache 2.4.39
	/usr/local/phpstudy/system/phpstudy -showindex 2 #nginx 1.15
	/usr/local/phpstudy/system/phpstudy -showindex 3 #pureftpd 1.0.47
	/usr/local/phpstudy/system/phpstudy -init_localhost
	
	export -n LD_LIBRARY_PATH=/usr/local/phpstudy/system/depends
}



Start_Install

Install_Php
Install_Apache
Install_Nginx
Install_Ftp
Install_WebPanel
Install_System
Install_Docker
Install_Others

Set_AutoStart

Start_All

Set_Privilege

Show_Result

Init_System


End_Install




