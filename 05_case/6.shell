#!/bin/bash

# chkconfig: 2345 64 36

#注意此脚本是rhel6及其之前的版本使用sysV管理用的，rhel7的systemd不能这么用了

start() {
	/usr/sbin/sshd	
}
stop () {
	kill -TERM `cat /var/run/sshd.pid`
}
reload() {
	kill -HUP `cat /var/run/sshd.pid`
}
status() {
	if [ -e /var/run/sshd.pid ];then
		echo "sshd正在运行"
	else
		echo "sshd是停止状态"
	fi
}

case "$1" in
	start )
		start
		;;
	stop  )
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
		echo "只支持(start|stop|restart|reload|status)"
esac


