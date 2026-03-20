#!/bin/bash
#===============================================================================
# 脚本名称：14_variable_advanced.sh
# 功能描述：演示 Shell 变量高级操作 (删除、替换、替代)
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - ${#var} 获取长度
#   - ${var#pattern} 从前往后最短匹配删除
#   - ${var##pattern} 从前往后最长匹配删除
#   - ${var%pattern} 从后往前最短匹配删除
#   - ${var%%pattern} 从后往前最长匹配删除
#   - ${var:offset:length} 切片
#   - ${var/pattern/replacement} 替换
#   - ${var:-default} 变量替代
# 使用方法：
#   chmod +x 14_variable_advanced.sh
#   ./14_variable_advanced.sh
# 参考来源：cnblogs Shell 指南 2.2 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

print_var() {
    printf "${YELLOW}%-35s${NC} = %s\n" "$1" "$2"
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 变量高级操作"
    print_separator
    echo
    
    # 示例变量
    url="www.example.com.cn"
    path="/home/user/documents/file.txt"
    filename="archive.tar.gz"
    
    print_title "1. ${#var} - 获取变量长度"
    print_var "url" "$url"
    print_var "\${#url}" "${#url}"
    echo
    print_var "path" "$path"
    print_var "\${#path}" "${#path}"
    echo
    
    print_title "2. ${var#pattern} - 从前往后最短匹配删除"
    print_var "url" "$url"
    print_var "\${url#*.}" "${url#*.}"
    echo "  说明：删除第一个 . 及其前面的内容 (最短匹配)"
    echo
    print_var "filename" "$filename"
    print_var "\${filename#*.}" "${filename#*.}"
    echo "  说明：删除第一个 . 及前面的扩展名"
    echo
    
    print_title "3. ${var##pattern} - 从前往后最长匹配删除 (贪婪)"
    print_var "url" "$url"
    print_var "\${url##*.}" "${url##*.}"
    echo "  说明：删除最后一个 . 及其前面所有内容 (最长匹配)"
    echo "  应用：获取文件扩展名"
    echo
    
    print_title "4. ${var%pattern} - 从后往前最短匹配删除"
    print_var "url" "$url"
    print_var "\${url%.*}" "${url%.*}"
    echo "  说明：删除最后一个 . 及其后面的内容"
    echo "  应用：获取不带扩展名的文件名"
    echo
    print_var "path" "$path"
    print_var "\${path%/*}" "${path%/*}"
    echo "  说明：删除最后一个 / 及其后面的内容"
    echo "  应用：获取目录路径"
    echo
    
    print_title "5. ${var%%pattern} - 从后往前最长匹配删除 (贪婪)"
    print_var "url" "$url"
    print_var "\${url%%.*}" "${url%%.*}"
    echo "  说明：删除第一个 . 及其后面所有内容"
    echo "  应用：获取主域名"
    echo
    print_var "filename" "$filename"
    print_var "\${filename%%.*}" "${filename%%.*}"
    echo "  说明：删除第一个 . 及后面所有扩展名"
    echo
    
    print_title "6. ${var:offset:length} - 切片操作"
    text="Hello World"
    print_var "text" "$text"
    print_var "\${text:0:5}" "${text:0:5}"
    print_var "\${text:6:5}" "${text:6:5}"
    print_var "\${text:6}" "${text:6}"
    echo "  说明：从 offset 开始，取 length 个字符"
    echo
    
    print_title "7. ${var/pattern/replacement} - 替换操作"
    text="hello world, hello shell"
    print_var "text" "$text"
    print_var "\${text/hello/Hi}" "${text/hello/Hi}"
    print_var "\${text//hello/Hi}" "${text//hello/Hi}"
    echo "  说明:"
    echo "    /pattern/replacement  - 替换第一个匹配"
    echo "    //pattern/replacement - 替换所有匹配 (全局)"
    echo
    
    print_title "8. ${var:-default} - 变量替代 (未赋值时使用默认值)"
    unset var1
    var2=""
    var3="value"
    
    print_info "测试不同场景:"
    print_var "var1 (未定义)" "${var1:-未定义}"
    print_var "\${var1:-default}" "${var1:-default}"
    echo
    print_var "var2 (空值)" "${var2:-空值}"
    print_var "\${var2:-default}" "${var2:-default}"
    echo
    print_var "var3 (有值)" "$var3"
    print_var "\${var3:-default}" "${var3:-default}"
    echo
    echo "  说明:"
    echo "    \${var:-default} - var 未定义或为空时使用 default"
    echo "    \${var-default}  - var 未定义时使用 default (空值不算)"
    echo
    
    print_title "9. ${var:=default} - 变量替代并赋值"
    unset var4
    print_info "使用前：var4 = ${var4:-未定义}"
    result=${var4:=default_value}
    print_info "使用后：\${var4:=default_value} = $result"
    print_info "现在：var4 = $var4"
    echo "  说明：不仅返回默认值，还会给变量赋值"
    echo
    
    print_title "10. ${var+value} - 变量已定义时的替代"
    var5="defined"
    unset var6
    
    print_var "var5 (已定义)" "$var5"
    print_var "\${var5:+替代值}" "${var5:+替代值}"
    echo
    print_var "var6 (未定义)" "${var6:-未定义}"
    print_var "\${var6:+替代值}" "${var6:+替代值}"
    echo
    echo "  说明：变量已定义时使用替代值，否则返回空"
    echo
    
    print_title "11. 实际应用示例"
    echo "  示例 1: 提取域名"
    domain="https://www.example.com/path"
    print_var "完整 URL" "$domain"
    print_var "协议" "${domain%%://*}"
    host="${domain#*://}"
    print_var "主机部分" "$host"
    print_var "域名" "${host%%/*}"
    echo
    echo "  示例 2: 文件路径处理"
    filepath="/var/log/nginx/access.log"
    print_var "完整路径" "$filepath"
    print_var "目录" "${filepath%/*}"
    print_var "文件名" "${filepath##*/}"
    print_var "文件名 (无扩展名)" "${filepath##*/}"
    echo
    echo "  示例 3: 参数默认值"
    PORT=${PORT:-8080}
    print_var "PORT" "$PORT"
    echo "  说明：如果环境变量 PORT 未设置，使用默认值 8080"
    echo
    
    print_separator
    print_info "总结:"
    echo "  ✅ \${#var} - 获取长度"
    echo "  ✅ \${var#pattern} - 从前往后最短删除"
    echo "  ✅ \${var##pattern} - 从前往后最长删除"
    echo "  ✅ \${var%pattern} - 从后往前最短删除"
    echo "  ✅ \${var%%pattern} - 从后往前最长删除"
    echo "  ✅ \${var:offset:length} - 切片"
    echo "  ✅ \${var/pattern/rep} - 替换"
    echo "  ✅ \${var:-default} - 默认值"
    print_separator
}

main "$@"
