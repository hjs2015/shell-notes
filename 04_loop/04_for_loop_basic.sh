#!/bin/bash
# =============================================================================
# 脚本名称：04_for_loop_basic.sh
# 功能描述：演示 for 循环的各种写法
# 难度等级：⭐⭐ 入门
# 知识点：
#   - for in 列表 - 遍历列表中的每个元素
#   - for {1..5} - 大括号展开（Bash 4.0+）
#   - for {1..100..2} - 带步长的大括号展开
#   - for /etc/* - 遍历目录中的文件
#   - for `command` - 遍历命令的输出
#   - while read - 通过管道读取
#   - echo -n - 输出不换行
# 使用方法：
#   chmod +x 04_for_loop_basic.sh
#   ./04_for_loop_basic.sh
# =============================================================================

# 方法 1：使用大括号展开 {1..5}
# 这是最简洁的写法，但需要 Bash 4.0+
for i in {1..5}
do
	echo -n $i  # -n 表示输出不换行
done
echo  # 最后换行

# 方法 2：带步长的大括号展开 {1..100..2}
# 第三个参数是步长（step），表示每次增加 2
# 等价于：for ((i=1;i<=100;i+=2))
# 等价于：for i in `seq 1 2 100`
for i in {1..100..2}
do
	echo -n $i
done
echo

# 方法 3：遍历目录中的所有文件和子目录
for i in /etc/*
do
	echo $i
done

# 方法 4：遍历 find 命令找到的所有文件
# `command` 会执行命令并将输出作为列表
for i in `find /etc/ -type f`
do
	echo $i
done

# 方法 5：使用管道和 while read
# 这种方式更适合处理包含空格的文件名
find /etc/ -type f | while read i
do
	echo $i
done

# 说明：
# 1. for 循环的基本语法：for 变量 in 列表; do 命令; done
# 2. 大括号展开 {1..5} 会展开为 1 2 3 4 5
# 3. {1..100..2} 会展开为 1 3 5 7 ... 99（步长为 2）
# 4. /etc/* 是通配符，匹配/etc/下的所有文件和目录
# 5. `command` 是命令替换，执行命令并将输出作为列表
# 6. while read 更适合处理包含空格或特殊字符的文件名
