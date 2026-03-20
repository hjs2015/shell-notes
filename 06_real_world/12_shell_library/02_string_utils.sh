#!/bin/bash
# ============================================================================
# 脚本名称：02_string_utils.sh
# 功能描述：字符串工具库 - 常用字符串操作函数集合
# 难度等级：⭐⭐⭐⭐ 专家级
# 知识点：字符串处理、函数封装、代码复用
# 使用方法：source 02_string_utils.sh
# 依赖命令：bash builtins
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ============================================================================
# 字符串长度
# ============================================================================

str_length() {
    local str="$1"
    echo "${#str}"
}

# ============================================================================
# 字符串截取
# ============================================================================

# 从左边截取 n 个字符
str_left() {
    local str="$1"
    local len="$2"
    echo "${str:0:$len}"
}

# 从右边截取 n 个字符
str_right() {
    local str="$1"
    local len="$2"
    local start=$((${#str} - len))
    echo "${str:$start:$len}"
}

# 从指定位置截取
str_sub() {
    local str="$1"
    local start="$2"
    local len="${3:-${#str}}"
    echo "${str:$start:$len}"
}

# ============================================================================
# 字符串查找
# ============================================================================

# 检查是否包含子串
str_contains() {
    local str="$1"
    local substr="$2"
    [[ "$str" == *"$substr"* ]]
}

# 查找子串位置（从 0 开始）
str_index() {
    local str="$1"
    local substr="$2"
    local temp="${str%%$substr*}"
    if [ "$temp" = "$str" ]; then
        echo "-1"
    else
        echo "${#temp}"
    fi
}

# ============================================================================
# 字符串替换
# ============================================================================

# 替换第一个匹配
str_replace_first() {
    local str="$1"
    local old="$2"
    local new="$3"
    echo "${str/$old/$new}"
}

# 替换所有匹配
str_replace_all() {
    local str="$1"
    local old="$2"
    local new="$3"
    echo "${str//$old/$new}"
}

# 删除前缀
str_remove_prefix() {
    local str="$1"
    local prefix="$2"
    echo "${str#$prefix}"
}

# 删除后缀
str_remove_suffix() {
    local str="$1"
    local suffix="$2"
    echo "${str%$suffix}"
}

# ============================================================================
# 字符串大小写转换
# ============================================================================

# 转大写
str_to_upper() {
    local str="$1"
    echo "${str^^}"
}

# 转小写
str_to_lower() {
    local str="$1"
    echo "${str,,}"
}

# 首字母大写
str_capitalize() {
    local str="$1"
    local first="${str:0:1}"
    local rest="${str:1}"
    echo "${first^^}${rest,,}"
}

# ============================================================================
# 字符串修剪
# ============================================================================

# 删除两端空白
str_trim() {
    local str="$1"
    str="${str#"${str%%[![:space:]]*}"}"
    str="${str%"${str##*[![:space:]]}"}"
    echo "$str"
}

# 删除左端空白
str_ltrim() {
    local str="$1"
    echo "${str#"${str%%[![:space:]]*}"}"
}

# 删除右端空白
str_rtrim() {
    local str="$1"
    echo "${str%"${str##*[![:space:]]}"}"
}

# ============================================================================
# 字符串分割
# ============================================================================

# 分割字符串为数组
str_split() {
    local str="$1"
    local delimiter="$2"
    local IFS="$delimiter"
    read -ra parts <<< "$str"
    printf '%s\n' "${parts[@]}"
}

# ============================================================================
# 字符串连接
# ============================================================================

# 连接多个字符串
str_join() {
    local delimiter="$1"
    shift
    local result=""
    local first=true
    for str in "$@"; do
        if $first; then
            result="$str"
            first=false
        else
            result="$result$delimiter$str"
        fi
    done
    echo "$result"
}

# ============================================================================
# 字符串重复
# ============================================================================

str_repeat() {
    local str="$1"
    local count="$2"
    local result=""
    for ((i=0; i<count; i++)); do
        result="$result$str"
    done
    echo "$result"
}

# ============================================================================
# 字符串反转
# ============================================================================

str_reverse() {
    local str="$1"
    echo "$str" | rev
}

# ============================================================================
# 示例用法
# ============================================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== 字符串工具库示例 ==="
    echo ""
    
    local test_str="  Hello World  "
    echo "测试字符串：'$test_str'"
    echo ""
    
    echo "长度：$(str_length "$test_str")"
    echo "左边 5 个字符：$(str_left "$test_str" 5)"
    echo "右边 5 个字符：$(str_right "$test_str" 5)"
    echo "截取 3-8: $(str_sub "$test_str" 3 5)"
    echo ""
    
    echo "包含 'World': $(str_contains "$test_str" "World" && echo "是" || echo "否")"
    echo "'World' 位置：$(str_index "$test_str" "World")"
    echo ""
    
    echo "替换第一个 'l' 为 'L': $(str_replace_first "$test_str" "l" "L")"
    echo "替换所有 'l' 为 'L': $(str_replace_all "$test_str" "l" "L")"
    echo ""
    
    echo "转大写：$(str_to_upper "$test_str")"
    echo "转小写：$(str_to_lower "$test_str")"
    echo "首字母大写：$(str_capitalize "hello")"
    echo ""
    
    echo "修剪两端空白：'$(str_trim "$test_str")'"
    echo ""
    
    echo "分割 'a,b,c'："
    str_split "a,b,c" ","
    echo ""
    
    echo "连接 'a' 'b' 'c' 用 '-'：$(str_join '-' 'a' 'b' 'c')"
    echo ""
    
    echo "重复 'ab' 3 次：$(str_repeat 'ab' 3)"
    echo "反转 'hello': $(str_reverse 'hello')"
    echo ""
    
    echo "✅ 字符串工具库加载成功！"
fi
