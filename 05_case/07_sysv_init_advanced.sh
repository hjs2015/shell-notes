#!/bin/bash
# =============================================================================
# 脚本名称：07_sysv_init_advanced.sh
# 功能描述：高级 SysV 初始化脚本 - 带状态检查和彩色输出
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 知识点：
#   - chkconfig 配置
#   - 函数定义和调用
#   - netstat 查看网络状态
#   - awk '{print $7}' 提取字段
#   - cut -d'/' -f1 分割字符串
#   - 颜色代码输出（\033[0;3Xm）
#   - 多条件判断（-a 与，-o 或）
#   - statusvalue 状态值
# 使用方法：
#   sudo ./07_sysv_init_advanced.sh start
#   sudo ./07_sysv_init_advanced.sh stop
#   sudo ./06_sysv_init_advanced.sh status
# 注意：适用于 RHEL6 及之前的 SysV 系统
# =============================================================================

# chkconfig 配置行
# chkconfig: 2345 56 26
# 含义：运行级别 2345，启动优先级 56，停止优先级 26
# description: ssh daemon scripts 服务描述

# 注意：此脚本是 RHEL6 及之前版本使用的 SysV 风格
# RHEL7 的 systemd 不能这么用

# 启动函数
start() {
	# 先检查状态
	status
	
	# 状态值 1 或 2 表示服务未运行，可以启动
	# -o 表示逻辑或
	if [ $statusvalue -eq 1 -o $statusvalue -eq 2 ]; then 
		# 启动 sshd
		/usr/sbin/sshd
		
		# 彩色输出
		# \033[0;30m 黑色
		# \033[0;33m 黄色
		# \033[0;32m 绿色
		# \033[0;34m 蓝色
		# -en 不换行 + 解释转义字符
		echo -en "\033[0;30m"
		echo -en "\033[0;33m 现在启动成功\n"
		echo -en "\033[0;30m"
	else
		# 已经在运行，不做任何事
		echo -ne "do nothing\n"
	fi
}

# 停止函数
stop() {
	status
	
	# 状态值 3/4/5 表示服务在运行，可以停止
	if [ $statusvalue -eq 3 -o $statusvalue -eq 4 -o $statusvalue -eq 5 ]; then
		# 停止所有 sshd 进程
		killall sshd
		
		# 绿色显示成功
		echo -en "\033[0;30m"
		echo -en "\033[0;32m 现在关闭成功\n"
		echo -en "\033[0;30m"
	else
		echo -ne "do nothing\n" 
	fi
}

# 重新加载配置函数
reload() {
	status
	
	# 状态值 3/4/5 表示服务在运行
	if [ $statusvalue -eq 3 -o $statusvalue -eq 4 -o $statusvalue -eq 5 ]; then
		# 发送 HUP 信号重新加载配置
		kill -HUP $netstatpid
		
		# 蓝色显示成功
		echo -en "\033[0;30m"
		echo -en "\033[0;34m 现在 reload 成功\n"
		echo -en "\033[0;30m"
	else
		echo -ne "do nothing\n"
	fi  
}

# 状态检查函数（详细版本）
status() {
	# 获取 sshd 进程 ID
	# netstat -ntlup 查看 TCP/UDP 监听端口
	# grep :22 过滤 SSH 端口
	# head -1 取第一行
	# awk '{print $7}' 取第 7 列（进程信息）
	# cut -d'/' -f1 以/分割，取第一部分（PID）
	netstatpid=`netstat -ntlup |grep :22 |head -1 |awk '{print $7}' |cut -d'/' -f1`
	
	# 从 PID 文件读取进程 ID
	filepid=`cat /var/run/sshd.pid 2> /dev/null`
	
	# 判断各种状态
	if [ -z "$netstatpid" -a -f /var/run/sshd.pid ]; then
		# 没有进程，但有 PID 文件
		echo "sshd 服务没有在运行，但有 pid 文件"
		statusvalue=1
	elif [ -z "$netstatpid" -a ! -f /var/run/sshd.pid ]; then
		# 没有进程，也没有 PID 文件
		echo "sshd 服务是停止运行状态" 
		statusvalue=2
	elif [ -n "$netstatpid" -a ! -f /var/run/sshd.pid ]; then
		# 有进程，但没有 PID 文件
		echo "sshd 服务在运行，但没有 pid 文件"
		statusvalue=3
	elif [ -n "$netstatpid" -a -f /var/run/sshd.pid ] && [ "$netstatpid" -eq "$filepid" ]; then
		# 有进程，有 PID 文件，且 PID 匹配
		echo "sshd 服务在正常运行状态"
		statusvalue=4
	elif [ -n "$netstatpid" -a -f /var/run/sshd.pid ] && [ "$netstatpid" -ne "$filepid" ]; then
		# 有进程，有 PID 文件，但 PID 不匹配
		echo "sshd 服务在运行，但 pid 文件里的 pid 不正确"
		statusvalue=5
	fi	
}

# 处理命令行参数
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

# 说明：
# 1. 这个脚本比基础版更完善，有详细的状态检查
# 2. 使用 netstat 检查端口监听状态
# 3. 对比 PID 文件和实际进程 ID
# 4. 使用 ANSI 颜色代码美化输出
# 5. statusvalue 保存状态值供其他函数使用

# 状态值说明：
# 1: 无进程，有 PID 文件
# 2: 无进程，无 PID 文件（完全停止）
# 3: 有进程，无 PID 文件
# 4: 正常运行（进程和 PID 都正确）
# 5: 有进程，但 PID 不匹配

# 颜色代码：
# \033[0;30m 黑色
# \033[0;31m 红色
# \033[0;32m 绿色
# \033[0;33m 黄色
# \033[0;34m 蓝色
# \033[0;35m 紫色
# \033[0;36m 青色
# \033[0m    重置颜色
