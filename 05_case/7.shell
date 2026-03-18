#!/bin/bash

# chkconfig: 2345 56 26
# description: ssh daemon scripts

#注意此脚本是rhel6及其之前的版本使用sysV管理用的，rhel7的systemd不能这么用了

start() {
	status
	if [ $statusvalue -eq 1 -o $statusvalue -eq 2 ];then 
		/usr/sbin/sshd
		echo -en "\\033[0;30m"
        	echo -en "\\033[0;33m现在启动成功\n"
        	echo -en "\\033[0;30m"
	else
		echo -ne "do nothing\n"
	fi
}

stop() {
	status
	if [ $statusvalue -eq 3 -o $statusvalue -eq 4 -o $statusvalue -eq 5 ];then
		killall sshd
		echo -en "\\033[0;30m"
        	echo -en "\\033[0;32m现在关闭成功\n"
        	echo -en "\\033[0;30m"
	else
		echo -ne "do nothing\n" 
	fi
}

reload() {
	status
	if [ $statusvalue -eq 3 -o $statusvalue -eq 4 -o $statusvalue -eq 5 ];then
		kill -HUP $netstatpid
		echo -en "\\033[0;30m"
        	echo -en "\\033[0;34m现在reload成功\n"
        	echo -en "\\033[0;30m"
	else
		echo -ne "do nothing\n"
	fi  
}

status() {
	netstatpid=`netstat -ntlup |grep :22 |head -1 |awk '{print $7}' |cut -d'/' -f1`
#	netstatpid=`pgrep sshd`
	filepid=`cat /var/run/sshd.pid 2> /dev/null`
	if [ -z "$netstatpid"  -a -f /var/run/sshd.pid ];then
		echo "sshd服务没有在运行，但有pid文件"
		statusvalue=1
	elif [ -z "$netstatpid" -a ! -f /var/run/sshd.pid ];then
		echo "sshd服务是停止运行状态" 
		statusvalue=2
	elif [ -n "$netstatpid" -a ! -f /var/run/sshd.pid ];then
		echo "sshd服务在运行，但没有pid文件"
		statusvalue=3
	elif [ -n "$netstatpid" -a -f /var/run/sshd.pid ] && [ "$netstatpid" -eq "$filepid" ];then
		echo "sshd服务在正常运行状态"
		statusvalue=4
	elif [ -n "$netstatpid" -a -f /var/run/sshd.pid ] && [ "$netstatpid" -ne "$filepid" ];then
		echo "sshd服务在运行,但pid文件里的pid不正确"
		statusvalue=5
	fi	
}

case "$1" in
	start )
		start
		;;
	stop )
		stop
		;;
	restart )
		stop
		start
		;;
	reload )
		reload
		;;
	status )
		status
		;;
	* )
		echo "只支持 start|stop|restart|reload|status"
esac
