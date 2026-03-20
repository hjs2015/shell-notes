#!/bin/bash
# ============================================================================
# 脚本名称：03_file_utils.sh
# 功能描述：文件工具库 - 常用文件操作函数集合
# 难度等级：⭐⭐⭐⭐ 专家级
# 知识点：文件操作、函数封装、代码复用
# 使用方法：source 03_file_utils.sh
# 依赖命令：bash builtins, cp, mv, rm, mkdir, find
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ============================================================================
# 文件检查
# ============================================================================

# 检查文件是否存在
file_exists() {
    [ -f "$1" ]
}

# 检查目录是否存在
dir_exists() {
    [ -d "$1" ]
}

# 检查文件是否可读
file_readable() {
    [ -r "$1" ]
}

# 检查文件是否可写
file_writable() {
    [ -w "$1" ]
}

# 检查文件是否可执行
file_executable() {
    [ -x "$1" ]
}

# 检查是否为符号链接
is_symlink() {
    [ -L "$1" ]
}

# 检查文件是否为空
file_empty() {
    [ ! -s "$1" ]
}

# ============================================================================
# 文件信息
# ============================================================================

# 获取文件大小（字节）
file_size() {
    local file="$1"
    stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null
}

# 获取文件大小（人类可读）
file_size_human() {
    local file="$1"
    local size=$(file_size "$file")
    if [ $size -lt 1024 ]; then
        echo "${size}B"
    elif [ $size -lt 1048576 ]; then
        echo "$((size / 1024))KB"
    elif [ $size -lt 1073741824 ]; then
        echo "$((size / 1048576))MB"
    else
        echo "$((size / 1073741824))GB"
    fi
}

# 获取文件修改时间
file_mtime() {
    local file="$1"
    stat -c%y "$file" 2>/dev/null || stat -f%Sm "$file" 2>/dev/null
}

# 获取文件扩展名
file_extension() {
    local file="$1"
    echo "${file##*.}"
}

# 获取文件名（不含路径）
file_basename() {
    local file="$1"
    echo "${file##*/}"
}

# 获取目录名
file_dirname() {
    local file="$1"
    echo "${file%/*}"
}

# ============================================================================
# 文件操作
# ============================================================================

# 创建文件（带目录）
file_create() {
    local file="$1"
    local dir=$(dirname "$file")
    mkdir -p "$dir" && touch "$file"
}

# 复制文件（带备份）
file_copy() {
    local src="$1"
    local dest="$2"
    local backup="${dest}.bak.$(date +%Y%m%d_%H%M%S)"
    
    if [ -f "$dest" ]; then
        mv "$dest" "$backup"
        echo -e "${YELLOW}已备份到：$backup${NC}"
    fi
    
    cp "$src" "$dest"
}

# 移动文件（带检查）
file_move() {
    local src="$1"
    local dest="$2"
    
    if [ ! -f "$src" ]; then
        echo -e "${RED}源文件不存在：$src${NC}"
        return 1
    fi
    
    mv "$src" "$dest"
}

# 删除文件（安全删除）
file_delete() {
    local file="$1"
    local force="${2:-false}"
    
    if [ ! -f "$file" ]; then
        echo -e "${YELLOW}文件不存在：$file${NC}"
        return 0
    fi
    
    if [ "$force" = "true" ]; then
        rm -f "$file"
    else
        rm -i "$file"
    fi
}

# ============================================================================
# 目录操作
# ============================================================================

# 创建目录（递归）
dir_create() {
    local dir="$1"
    mkdir -p "$dir"
}

# 删除空目录
dir_delete_empty() {
    local dir="$1"
    rmdir "$dir" 2>/dev/null
}

# 删除目录树
dir_delete_tree() {
    local dir="$1"
    rm -rf "$dir"
}

# 列出目录内容
dir_list() {
    local dir="${1:-.}"
    ls -la "$dir"
}

# ============================================================================
# 文件查找
# ============================================================================

# 按名称查找文件
find_by_name() {
    local dir="${2:-.}"
    find "$dir" -name "$1" 2>/dev/null
}

# 按类型查找文件
find_by_type() {
    local type="$1"
    local dir="${2:-.}"
    find "$dir" -type "$type" 2>/dev/null
}

# 按修改时间查找
find_by_mtime() {
    local days="$1"
    local dir="${2:-.}"
    find "$dir" -mtime "$days" 2>/dev/null
}

# 按大小查找
find_by_size() {
    local size="$1"
    local dir="${2:-.}"
    find "$dir" -size "$size" 2>/dev/null
}

# ============================================================================
# 文件权限
# ============================================================================

# 设置文件权限
file_chmod() {
    local mode="$1"
    shift
    chmod "$mode" "$@"
}

# 设置文件所有者
file_chown() {
    local owner="$1"
    local group="$2"
    shift 2
    chown "$owner:$group" "$@"
}

# ============================================================================
# 文件内容
# ============================================================================

# 读取文件内容
file_read() {
    local file="$1"
    cat "$file" 2>/dev/null
}

# 写入文件（覆盖）
file_write() {
    local file="$1"
    local content="$2"
    echo "$content" > "$file"
}

# 追加到文件
file_append() {
    local file="$1"
    local content="$2"
    echo "$content" >> "$file"
}

# 读取文件行数
file_lines() {
    local file="$1"
    wc -l < "$file" 2>/dev/null
}

# 读取文件单词数
file_words() {
    local file="$1"
    wc -w < "$file" 2>/dev/null
}

# ============================================================================
# 临时文件
# ============================================================================

# 创建临时文件
temp_file_create() {
    local prefix="${1:-tmp}"
    mktemp "/tmp/${prefix}.XXXXXX"
}

# 创建临时目录
temp_dir_create() {
    local prefix="${1:-tmp}"
    mktemp -d "/tmp/${prefix}.XXXXXX"
}

# ============================================================================
# 示例用法
# ============================================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== 文件工具库示例 ==="
    echo ""
    
    # 创建测试文件
    local test_file="/tmp/test_file_utils.txt"
    echo "Hello World" > "$test_file"
    echo "测试文件：$test_file"
    echo ""
    
    echo "文件存在：$(file_exists "$test_file" && echo "是" || echo "否")"
    echo "文件大小：$(file_size_human "$test_file")"
    echo "文件扩展名：$(file_extension "$test_file")"
    echo "文件行数：$(file_lines "$test_file")"
    echo ""
    
    echo "读取内容：$(file_read "$test_file")"
    echo ""
    
    # 清理
    rm -f "$test_file"
    
    echo "✅ 文件工具库加载成功！"
fi
