#!/bin/bash
# =============================================================================
# 脚本名称：14_copy_conf_files.sh
# 功能描述：复制配置文件并修改扩展名
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - rm -rf 递归强制删除
#   - mkdir -p 递归创建目录
#   - find -name "*.conf" 查找指定名称的文件
#   - -exec command {} \; 对每个文件执行命令
#   - rename 批量重命名文件
# 使用方法：
#   chmod +x 14_copy_conf_files.sh
#   sudo ./14_copy_conf_files.sh
# 功能说明：
#   1. 查找/etc/下所有.conf 结尾的文件
#   2. 复制到/tmp/conf/目录
#   3. 将.conf 扩展名改为.html
# =============================================================================

# 删除旧的目录（如果存在）
# -r 递归删除，-f 强制删除（不提示）
rm /tmp/conf -rf

# 创建新目录
# -p 参数表示如果父目录不存在也一并创建
mkdir /tmp/conf -p

# 查找并复制配置文件
# find /etc/ -name "*.conf" 查找/etc/下所有.conf 结尾的文件
# -exec cp {} /tmp/conf \; 对每个文件执行 cp 命令
# {} 代表找到的文件，\; 表示命令结束
find /etc/ -name "*.conf" -exec cp {} /tmp/conf \;

# 切换到目标目录
cd /tmp/conf

# 批量重命名文件
# rename .conf .html * 将所有文件的.conf 改为.html
rename .conf .html *

# 说明：
# 1. find -exec 是对每个找到的文件执行指定命令
# 2. {} 是占位符，代表当前找到的文件
# 3. \; 表示-exec 命令的结束（必须转义分号）
# 4. rename 是 Perl 正则重命名工具
# 5. rename .conf .html * 将所有以.conf 结尾的文件改为.html

# 注释掉的方法（使用变量替换）：
# a=${i##*/}  # 提取文件名（去掉路径）
# b=${a%.*}   # 去掉扩展名
# cp $i /tmp/conf/$b.html  # 复制并改名

# 注意：
# 1. 需要 root 权限才能读取/etc/下的所有文件
# 2. rename 命令在某些系统上可能不可用（可用 for 循环替代）
# 3. 复制的文件数可能少于找到的文件数（因为有同名文件）
