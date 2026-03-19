#!/bin/bash
# =============================================================================
# 脚本名称：15_copy_index_html.sh
# 功能描述：复制所有 index.html 文件并编号
# 难度等级：⭐⭐ 入门
# 知识点：
#   - rm -rf 递归强制删除
#   - mkdir -p 递归创建目录
#   - find -name 查找指定名称的文件
#   - for 循环遍历
#   - let a++ 变量自增
# 使用方法：
#   chmod +x 15_copy_index_html.sh
#   ./15_copy_index_html.sh
# 功能说明：
#   1. 查找/usr/share/doc/下所有 index.html 文件
#   2. 复制到/tmp/index/目录
#   3. 按顺序编号：index.html.1, index.html.2...
# =============================================================================

# 删除旧的目录（如果存在）
# -r 递归删除，-f 强制删除（不提示）
rm -rf /tmp/index/

# 创建新目录
# -p 参数表示如果父目录不存在也一并创建
mkdir /tmp/index/ -p

# 初始化计数器
a=1

# 查找并复制 index.html 文件
# find /usr/share/doc/ -name "index.html" 查找所有 index.html 文件
for i in `find /usr/share/doc/ -name "index.html"`
do
	# 复制文件并编号
	# index.html.$a 表示 index.html.1, index.html.2...
	cp $i /tmp/index/index.html.$a
	
	# 计数器加 1
	let a++
done

# 说明：
# 1. find -name "index.html" 精确匹配文件名
# 2. for 循环遍历 find 找到的所有文件
# 3. let a++ 等价于 a=$((a+1))，变量自增
# 4. 这样可以避免文件名冲突，每个文件都有唯一编号

# 实际应用场景：
# 1. 收集分散的文件到一处
# 2. 备份时避免文件名冲突
# 3. 批量处理文件
