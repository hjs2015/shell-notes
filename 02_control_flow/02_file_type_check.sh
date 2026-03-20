#!/bin/bash
# =============================================================================
# 脚本名称：02_file_type_check.sh
# 功能描述：判断文件类型（目录、链接、设备等）
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - if-elif-else 多条件判断
#   - 文件测试操作符
#   - exit 88 退出并返回状态码
# 使用方法：
#   chmod +x 02_file_type_check.sh
#   ./02_file_type_check.sh
# 文件测试操作符：
#   -e 文件 - 文件是否存在 (exist)
#   -L 文件 - 是否为符号链接 (link)
#   -d 文件 - 是否为目录 (directory)
#   -S 文件 - 是否为套接字 (socket)
#   -p 文件 - 是否为管道 (pipe)
#   -c 文件 - 是否为字符设备 (character)
#   -b 文件 - 是否为块设备 (block)
#   -f 文件 - 是否为普通文件 (file)
# =============================================================================

# 提示用户输入文件或路径
read -p "input a file:" file

# 首先检查文件是否存在
# ! 表示取反，-e 测试是否存在
if [ ! -e $file ]; then
	echo "$file is not exist" 
	exit 88  # 文件不存在，退出并返回状态码 88
	
# 检查是否为符号链接（软链接）
elif [ -L $file ]; then
	echo "$file is a symblic link file"	
	
# 检查是否为目录
elif [ -d $file ]; then
	echo "$file is a directory"	

# 检查是否为套接字文件
elif [ -S $file ]; then
	echo "$file is a socket file"	

# 检查是否为管道文件
elif [ -p $file ]; then
	echo "$file is a pipe file"	

# 检查是否为字符设备文件（如终端/dev/tty）
elif [ -c $file ]; then
	echo "$file is a character file"	

# 检查是否为块设备文件（如硬盘/dev/sda）
elif [ -b $file ]; then
	echo "$file is a block file"	

# 如果以上都不是，则是普通文件
else
	echo "$file is a regular file"	
fi

# 说明：
# 1. if-elif-else 结构从上到下依次判断，命中即执行并退出
# 2. 判断顺序很重要，应该先判断特殊的，再判断一般的
# 3. exit 88 返回自定义状态码，便于其他脚本判断执行结果
