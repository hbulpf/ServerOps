#! /bin/bash
#   
# frp
# author : lipengfei
# Source function library.
source /etc/profile && . /etc/init.d/functions
start(){
    source /etc/profile
    if [ ! -d /opt/frp/frp_0.21.0_linux_amd64/ ] ; then
        echo "frp file dosen't exist!"
        exit 0 
    fi

    if [ -e "/var/run/frp.pid" ] ; then
        action "frp service start fail" /bin/false
        echo "frp is running....."
        sleep 1
        exit 1
    fi

    echo "frp is starting"
    cd /opt/frp/frp_0.21.0_linux_amd64/ && \
    nohup ./frpc -c frpc.ini &
    `ps -ef|grep "frp"|grep -v "grep"|awk '{print $2}'` >/var/run/inotify.pid
    if [ `ps -ef|grep frp|wc -l` -gt 2 ] ; then
        action "frp service is started" /bin/true
    else
        action "frp service is started" /bin/false
     fi    

    echo "frp succeeded to start !"
}

stop(){
     if [ `ps -ef|grep frp|grep -v grep|wc -l` -a -e "/var/run/frp.pid" ]
     then
        rm -f /var/run/frp.pid >/dev/null 2>&1
        pkill frp
     else
        action "frp service stop fail" /bin/false
        echo "frp server is not running"
        sleep 1
        exit 1
     fi
     sleep 1
     if [ `ps -ef|grep frp|grep -v grep|wc -l` -eq 0 -a ! -e "/var/run/frp.pid" ]
     then
        action "frp service is stoped" /bin/true
     else
        action "frp service is stoped" /bin/false
     fi
}


if [ $# -ne 1 ]
then
 echo "usage: $0 {start|stop|status}"
 exit 1
fi

case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
status)
    if [ `ps -ef|grep frp|wc -l` -gt 2 ] ; then
        action "frp service is running"
    else
        action "frp service is stoped"
    fi    
    ;;
restart|reload|force-reload)
    stop
    start
    ;;
*)
    echo $"Usage: $0 {start|stop|status|restart|reload|force-reload}"
    exit 2
esac


