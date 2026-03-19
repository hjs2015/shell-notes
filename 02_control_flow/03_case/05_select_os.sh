#!/bin/bash
# =============================================================================
# 脚本名称：05_select_os.sh
# 功能描述：选择操作系统 - 使用 select 创建菜单
# 难度等级：⭐⭐ 入门
# 知识点：
#   - PS3 设置 select 提示符
#   - select 循环创建菜单
#   - in 后跟选项列表
#   - break 退出循环
# 使用方法：
#   chmod +x 05_select_os.sh
#   ./05_select_os.sh
# =============================================================================

# 设置 select 菜单的提示符
# PS3 是 Bash 的特殊变量，用于 select 语句的提示
PS3="please choose what operation system you are using:"

# 显示空行
echo

# select 循环创建菜单
# os 是变量，保存用户选择的选项
# in 后跟所有选项列表
select os in xp vista windows7 windows8 windows10 linux unix
do
	# 显示空行
	echo
	# 显示用户选择
	echo "your operation system is $os"
	echo
	# 退出循环（只选择一次）
	break
done

# 说明：
# 1. select 是 Bash 的菜单选择结构
# 2. PS3 是 select 的提示符变量（类似 PS1 是命令提示符）
# 3. in 后面列出所有选项
# 4. select 自动显示编号菜单（1) xp, 2) vista...）
# 5. 用户输入数字选择
# 6. break 退出循环，否则会继续显示菜单

# select 语法：
# select 变量 in 选项 1 选项 2 选项 3...
# do
#   命令
# done

# 实际输出示例：
# please choose what operation system you are using:
# 1) xp
# 2) vista
# 3) windows7
# 4) windows8
# 5) windows10
# 6) linux
# 7) unix
# #? 1
#
# your operation system is xp

# 扩展：
# 1. 可以用 case 处理不同选择
# 2. 可以去掉 break 实现循环菜单
# 3. 可以添加输入验证
