#!/bin/bash
# =============================================================================
# 脚本名称：06_sysv_init_script.sh
# 功能描述：SysV 风格初始化脚本 - 服务管理脚本模板
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 知识点：
#   - chkconfig 配置（RHEL6 及之前）
#   - 函数定义和调用
#   - kill -TERM/-HUP 发送信号
#   - cat 读取 PID 文件
#   - [ -e file ] 文件存在测试
#   - case $1 处理命令行参数
# 使用方法：
#   sudo ./06_sysv_init_script.sh start
#   sudo ./06_sysv_init_script.sh stop
#   sudo ./06_sysv_init_script.sh restart
#   sudo ./06_sysv_init_script.sh status
# 注意：此脚本适用于 RHEL6 及之前的 SysV 系统，RHEL7+ 使用 systemd
# =============================================================================

# chkconfig 配置行（注释掉，用于 chkconfig 工具识别）
# chkconfig: 2345 64 36
# 含义：运行级别 2345，启动优先级 64，停止优先级 36

# 注意：此脚本是 RHEL6 及其之前版本使用的 SysV 风格
# RHEL7 的 systemd 不能这么用（应该用 systemd service 文件）

# 启动函数
start() {
	/usr/sbin/sshd  # 启动 sshd 服务
}

# 停止函数
stop () {
	# 读取 PID 文件，获取进程 ID
	# kill -TERM 发送终止信号（优雅关闭）
	kill -TERM `cat /var/run/sshd.pid`
}

# 重新加载配置函数
reload() {
	# kill -HUP 发送挂起信号（重新加载配置）
	kill -HUP `cat /var/run/sshd.pid`
}

# 状态检查函数
status() {
	# 检查 PID 文件是否存在
	if [ -e /var/run/sshd.pid ]; then
		echo "sshd 正在运行"
	else
		echo "sshd 是停止状态"
	fi
}

# 处理命令行参数
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
		# 未知参数，显示帮助
		echo "只支持 (start|stop|restart|reload|status)"
esac

# 说明：
# 1. SysV init 是传统的 Linux 初始化系统
# 2. 服务脚本通常放在/etc/init.d/目录
# 3. PID 文件保存进程 ID，用于管理进程
# 4. kill -TERM (15) 优雅终止，kill -HUP (1) 重新加载
# 5. case $1 处理第一个命令行参数

# 信号说明：
# - TERM (15): 终止进程
# - HUP (1): 挂起信号，常用于重新加载配置
# - KILL (9): 强制杀死（不推荐，除非必要）

# 注意：
# 1. 此脚本需要 root 权限运行
# 2. RHEL7+ 使用 systemd，应该用 systemctl 命令
# 3. 实际使用中应该添加更完善的错误检查
# 4. PID 文件路径可能因系统而异

# systemd 对比：
# RHEL7+ 应该使用：
# systemctl start sshd
# systemctl stop sshd
# systemctl restart sshd
# systemctl status sshd
