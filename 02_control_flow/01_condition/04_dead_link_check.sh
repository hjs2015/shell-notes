#!/bin/bash
# =============================================================================
# 脚本名称：04_dead_link_check.sh
# 功能描述：判断死链接（指向不存在文件的符号链接）
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - 符号链接的概念
#   - readlink -f 获取链接的真实路径
#   - if-else 嵌套判断
#   - sh $0 重新执行脚本
# 使用方法：
#   chmod +x 04_dead_link_check.sh
#   ./04_dead_link_check.sh
# 什么是死链接？
#   符号链接（软链接）指向的目标文件不存在时，称为死链接
#   例如：ln -s /nonexistent/file link
#   此时 link 就是一个死链接
# =============================================================================

# 方法一（注释掉的代码）：
# 直接判断：是链接且目标不存在
#read -p "input a file:" file
#
#if [ -L $file -a ! -e $file ];then
#	echo "$file is a dead link"
#else
#	echo "$file is not a dead link"
#fi

# 方法二（更严谨）：

# 提示用户输入文件路径
read -p "input a file:" file

# 首先检查是否为符号链接
# ! -L 表示"不是链接"
if [ ! -L $file ]; then
	echo "$file is not a link file"
	sh $0  # 重新执行本脚本
	exit 1  # 退出当前进程
fi 

# 使用 readlink -f 获取链接指向的真实路径（解析所有中间链接）
sourcefile=$(readlink -f $file)

# 检查真实路径的文件是否存在
if [ ! -e $sourcefile ]; then
	echo "$file is a dead link"
else
	echo "$file is not a dead link"
fi

# 说明：
# 1. 符号链接（软链接）类似于 Windows 的快捷方式
# 2. 创建软链接：ln -s 目标文件 链接名
# 3. 死链接是指链接的目标被删除后，链接本身还在但无法使用
# 4. readlink -f 会递归解析所有链接，返回最终的真实路径
# 5. 方法二更严谨，因为它会解析链接的真实路径再判断
