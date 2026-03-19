#!/bin/bash
# =============================================================================
# 脚本名称：10_usb_mount_menu.sh
# 功能描述：USB 设备挂载菜单 - 图形化 USB 管理工具
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 知识点：
#   - 函数定义和调用
#   - fdisk -l 列出磁盘分区
#   - mount/umount 挂载/卸载
#   - cp -r 递归复制
#   - while 循环
#   - case 语句菜单
#   - $? 检查上一个命令状态
# 使用方法：
#   sudo ./10_usb_mount_menu.sh
# 注意：需要 root 权限才能挂载设备
# =============================================================================

# 挂载 USB 函数
mountusb () {
	# 显示所有磁盘分区
	fdisk -l
	
	# 提示用户输入设备名
	read -p "选择你要挂载的设备 (如:/dev/sdb1):" dev
	
	# 挂载设备到/mnt
	mount $dev /mnt
}

# 卸载 USB 函数
umountusb () {
	# 卸载/mnt 目录
	umount /mnt
}

# 显示 USB 内容函数
display () {
	# 列出/mnt 目录内容（长格式）
	ls -l /mnt
}

# 从 USB 拷贝到系统函数
usbtosystem () {
	# 显示 USB 内容
	display
	
	# 输入要拷贝的文件名（相对路径）
	read -p "选择你要拷贝的文件名 (相对路径):" file1
	
	# 输入目标目录（绝对路径）
	read -p "选择你要拷贝到哪个目录 (绝对路径):" dir1
	
	# 显示提示
	echo "拷贝中，请耐心等待..."
	
	# 递归拷贝文件
	cp -r /mnt/$file1 $dir1
	
	echo "拷贝完成"
}

# 从系统拷贝到 USB 函数
systemtousb () {
	# 输入要拷贝的文件名
	read -p "选择你要拷贝的文件名 (相对路径):" file2
	
	echo "拷贝中，请耐心等待..."
	
	# 递归强制拷贝到 USB
	cp $file2 /mnt/ -rf
	
	echo "拷贝完成"
}

# 退出函数
quit () {
	echo "谢谢使用，如有 BUG，请联系 xxx@gmail.com"
	exit 1
}

# 初始化变量
anwser=Y

# 循环菜单
# [ $anwser = Y -o $anwser = y ] 当回答是 Y 或 y 时继续
while [ $anwser = Y -o $anwser = y ]
do
	# 显示菜单
	echo "##################################"
	echo "    usb mount program by li       "
	echo "##################################"
	echo "                                  "
	echo "          1-挂载                  "
	echo "          2-卸载                  "
	echo "          3-列出内容              "
	echo "          4-拷文件到系统          "
	echo "          5-拷文件到 usb           "
	echo "          0-退出程序              "
	echo "                                  "
	echo "##################################"
	echo -n "请选择 (0-5): "
	read choice

	# 处理用户选择
	case "$choice" in 
		1 ) clear && mountusb ;;      # 挂载
		2 ) clear && umountusb ;;     # 卸载
		3 ) clear && display ;;       # 列出内容
		4 ) clear && usbtosystem ;;   # 拷文件到系统
		5 ) clear && systemtousb ;;   # 拷文件到 USB
		0 ) clear && quit ;;          # 退出
		* ) echo "选择有误，只能选择 0-5!"
		    exit 1
	esac
	
	# 检查命令执行状态
	# $? 是上一个命令的退出状态码
	# -ne 0 表示不等于 0（失败）
	if [ $? -ne 0 ]; then
		echo '程序出错!'
		exit 3
	fi
	
	# 询问是否继续
	echo -e "你要继续循环运行吗？(输入 Y 或 y 继续，输入其它退出)"
	read anwser
done

# 说明：
# 1. 函数封装了各个功能模块
# 2. while 循环实现重复使用
# 3. case 语句处理菜单选择
# 4. clear 清屏让界面更干净
# 5. $? 检查上一个命令是否成功

# 挂载点说明：
# /mnt 是临时挂载点
# 实际使用中可以用 /media/usb 等

# 注意：
# 1. 需要 root 权限（sudo）
# 2. USB 设备名可能是/dev/sdb1, /dev/sdc1 等
# 3. 卸载前确保没有程序在使用 USB
# 4. 拷贝大文件时耐心等待

# 扩展：
# 1. 自动检测 USB 设备
# 2. 创建专用挂载点
# 3. 显示磁盘空间使用情况
