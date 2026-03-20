#!/bin/bash
# ============================================================================
# 脚本名称：02_tr_advanced.sh
# 功能描述：tr 命令高级用法 - 字符转换、删除、压缩、实战应用
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：tr 高级选项、字符集、删除、压缩、大小写转换
# 使用方法：bash 02_tr_advanced.sh
# 依赖命令：tr, echo, cat
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 tr 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 字符集转换
# ------------------------------------------------------------------------------
print_header "🔹 字符集转换"

echo -e "${YELLOW}【小写转大写】${NC}"
echo "命令：echo 'hello world' | tr 'a-z' 'A-Z'"
echo 'hello world' | tr 'a-z' 'A-Z'
echo ""

echo -e "${YELLOW}【大写转小写】${NC}"
echo "命令：echo 'HELLO WORLD' | tr 'A-Z' 'a-z'"
echo 'HELLO WORLD' | tr 'A-Z' 'a-z'
echo ""

echo -e "${YELLOW}【数字转字母】${NC}"
echo "命令：echo '12345' | tr '0-9' 'a-e'"
echo '12345' | tr '0-9' 'a-e'
echo ""

# ------------------------------------------------------------------------------
# 2. 删除字符
# ------------------------------------------------------------------------------
print_header "🔹 删除字符"

echo -e "${YELLOW}【删除所有数字】${NC}"
echo "命令：echo 'abc123def456' | tr -d '0-9'"
echo 'abc123def456' | tr -d '0-9'
echo ""

echo -e "${YELLOW}【删除所有空格】${NC}"
echo "命令：echo 'hello world test' | tr -d ' '"
echo 'hello world test' | tr -d ' '
echo ""

echo -e "${YELLOW}【删除标点符号】${NC}"
echo "命令：echo 'Hello, World! How are you?' | tr -d '[:punct:]'"
echo 'Hello, World! How are you?' | tr -d '[:punct:]'
echo ""

# ------------------------------------------------------------------------------
# 3. 压缩重复字符
# ------------------------------------------------------------------------------
print_header "🔹 压缩重复字符"

echo -e "${YELLOW}【压缩连续空格】${NC}"
echo "命令：echo 'too    many     spaces' | tr -s ' '"
echo 'too    many     spaces' | tr -s ' '
echo ""

echo -e "${YELLOW}【压缩连续换行】${NC}"
echo "命令：echo -e 'line1\\n\\n\\nline2\\n\\nline3' | tr -s '\\n'"
echo -e 'line1\n\n\nline2\n\nline3' | tr -s '\n'
echo ""

echo -e "${YELLOW}【压缩并转换】${NC}"
echo "命令：echo 'aaaabbbbcccc' | tr -s 'a-c' 'x'"
echo 'aaaabbbbcccc' | tr -s 'a-c' 'x'
echo ""

# ------------------------------------------------------------------------------
# 4. 字符类
# ------------------------------------------------------------------------------
print_header "🔹 字符类"

echo -e "${YELLOW}【删除所有空白字符】${NC}"
echo "命令：echo 'hello\tworld\n' | tr -d '[:space:]'"
echo 'hello	world
' | tr -d '[:space:]'
echo ""

echo -e "${YELLOW}【只保留字母】${NC}"
echo "命令：echo 'abc123!@#' | tr -cd '[:alpha:]'"
echo 'abc123!@#' | tr -cd '[:alpha:]'
echo ""

echo -e "${YELLOW}【只保留数字】${NC}"
echo "命令：echo 'abc123!@#' | tr -cd '[:digit:]'"
echo 'abc123!@#' | tr -cd '[:digit:]'
echo ""

# ------------------------------------------------------------------------------
# 5. 实战：清理文本
# ------------------------------------------------------------------------------
print_header "🔹 实战：清理文本"

cat > /tmp/messy.txt << 'EOF'
  This   is   a   messy   text  
WITH    UPPERCASE    AND    
123    NUMBERS    456
EOF

echo -e "${YELLOW}【原始文本】${NC}"
cat /tmp/messy.txt
echo ""

echo -e "${YELLOW}【清理：转小写 + 压缩空格 + 删除数字】${NC}"
echo "命令：cat /tmp/messy.txt | tr 'A-Z' 'a-z' | tr -s ' ' | tr -d '0-9'"
cat /tmp/messy.txt | tr 'A-Z' 'a-z' | tr -s ' ' | tr -d '0-9'
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：密码生成
# ------------------------------------------------------------------------------
print_header "🔹 实战：密码生成"

echo -e "${YELLOW}【生成随机密码】${NC}"
echo "命令：tr -dc 'A-Za-z0-9!@#' < /dev/urandom | head -c 16"
password=$(tr -dc 'A-Za-z0-9!@#' < /dev/urandom | head -c 16)
echo "$password"
echo ""

echo -e "${YELLOW}【生成数字验证码】${NC}"
echo "命令：tr -dc '0-9' < /dev/urandom | head -c 6"
code=$(tr -dc '0-9' < /dev/urandom | head -c 6)
echo "$code"
echo ""

# ------------------------------------------------------------------------------
# 7. 实战：URL 处理
# ------------------------------------------------------------------------------
print_header "🔹 实战：URL 处理"

echo -e "${YELLOW}【空格转 URL 编码】${NC}"
echo "命令：echo 'hello world test' | tr ' ' '+'"
echo 'hello world test' | tr ' ' '+'
echo ""

echo -e "${YELLOW}【转换路径分隔符】${NC}"
echo "命令：echo '/usr/local/bin' | tr '/' ':'"
echo '/usr/local/bin' | tr '/' ':'
echo ""

# ------------------------------------------------------------------------------
# 8. 实战：数据格式化
# ------------------------------------------------------------------------------
print_header "🔹 实战：数据格式化"

cat > /tmp/phone.txt << 'EOF'
138-1234-5678
139.8765.4321
13712345678
EOF

echo -e "${YELLOW}【统一手机号格式】${NC}"
echo "命令：cat /tmp/phone.txt | tr '-.' '  '"
cat /tmp/phone.txt | tr '-.' '  '
echo ""

echo -e "${YELLOW}【删除所有分隔符】${NC}"
echo "命令：cat /tmp/phone.txt | tr -d '-. '"
cat /tmp/phone.txt | tr -d '-. '
echo ""

# ------------------------------------------------------------------------------
# 9. 反转字符
# ------------------------------------------------------------------------------
print_header "🔹 反转字符"

echo -e "${YELLOW}【ROT13 编码】${NC}"
echo "命令：echo 'hello' | tr 'A-Za-z' 'N-ZA-Mn-za-m'"
echo 'hello' | tr 'A-Za-z' 'N-ZA-Mn-za-m'
echo ""

echo -e "${YELLOW}【ROT13 解码】${NC}"
echo "命令：echo 'uryyb' | tr 'A-Za-z' 'N-ZA-Mn-za-m'"
echo 'uryyb' | tr 'A-Za-z' 'N-ZA-Mn-za-m'
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/messy.txt /tmp/phone.txt
print_example "清理完成" "rm -f /tmp/messy.txt /tmp/phone.txt"

print_header "✅ tr 命令高级学习完成！"
