#!/bin/bash
# =============================================================================
# 脚本：05_wildcards_and_echo.sh
# 功能：演示通配符和 echo 颜色控制
# 难度：⭐⭐
# 知识点：
#   - 通配符 (*, ?, [], {})
#   - echo 转义字符
#   - echo 颜色控制
# 使用方法：
#   ./05_wildcards_and_echo.sh
# =============================================================================

echo "=========================================="
echo "【1】通配符基础"
echo "=========================================="

# 创建测试文件
mkdir -p /tmp/wildcard_test
cd /tmp/wildcard_test
touch file1.txt file2.txt file10.txt
touch test.log test.dat
touch .hidden

echo "创建测试文件："
ls -la

echo ""
echo "=========================================="
echo "【2】* 匹配任意多个字符"
echo "=========================================="

echo "匹配 *.txt:"
ls *.txt

echo ""
echo "匹配 file*:"
ls file*

echo ""
echo "=========================================="
echo "【3】? 匹配任意一个字符"
echo "=========================================="

echo "创建测试文件：a.txt, ab.txt, abc.txt"
touch a.txt ab.txt abc.txt

echo "匹配 ?.txt (单个字符):"
ls ?.txt

echo ""
echo "匹配 ??.txt (两个字符):"
ls ??.txt

echo ""
echo "=========================================="
echo "【4】[] 匹配指定范围"
echo "=========================================="

echo "匹配 [0-9].txt (数字):"
ls [0-9].txt 2>/dev/null || echo "(无匹配)"

echo ""
echo "匹配 [ab].txt (a 或 b):"
ls [ab].txt 2>/dev/null || echo "(无匹配)"

echo ""
echo "匹配 [!0-9].txt (非数字):"
ls [!0-9].txt 2>/dev/null | head -3

echo ""
echo "=========================================="
echo "【5】{} 集合"
echo "=========================================="

echo "创建文件：file{1..5}.txt"
touch file{1..5}.txt
ls file*.txt

echo ""
echo "创建目录：mkdir -p test/{a,b,c}"
mkdir -p test/{a,b,c}
ls test/

echo ""
echo "=========================================="
echo "【6】echo 转义字符"
echo "=========================================="

echo "使用 -e 启用转义："
echo -e "Tab 键：\tHello\tWorld"
echo -e "换行：\n第一行\n第二行"
echo -e "退格：Hello\b\b\b\b\bWorld"
echo -e "警告音：\a (听不到是正常的)"

echo ""
echo "=========================================="
echo "【7】echo 颜色控制"
echo "=========================================="

echo "前景色："
echo -e "\033[30m■\033[0m 黑色 (30)"
echo -e "\033[31m■\033[0m 红色 (31)"
echo -e "\033[32m■\033[0m 绿色 (32)"
echo -e "\033[33m■\033[0m 黄色 (33)"
echo -e "\033[34m■\033[0m 蓝色 (34)"
echo -e "\033[35m■\033[0m 洋红 (35)"
echo -e "\033[36m■\033[0m 青色 (36)"
echo -e "\033[37m■\033[0m 白色 (37)"

echo ""
echo "背景色："
echo -e "\033[41m  \033[0m 红色背景 (41)"
echo -e "\033[42m  \033[0m 绿色背景 (42)"
echo -e "\033[44m  \033[0m 蓝色背景 (44)"

echo ""
echo "字体效果："
echo -e "\033[1m■\033[0m 粗体 (1)"
echo -e "\033[4m■\033[0m 下划线 (4)"
echo -e "\033[5m■\033[0m 闪烁 (5)"
echo -e "\033[7m■\033[0m 反显 (7)"

echo ""
echo "组合使用："
echo -e "\033[1;31;43m■\033[0m 粗体 + 红字 + 黄底"

echo ""
echo "=========================================="
echo "【8】实战技巧"
echo "=========================================="

# 定义颜色变量
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}✅${NC} 成功消息"
echo -e "${RED}❌${NC} 错误消息"
echo -e "${YELLOW}⚠️${NC} 警告消息"
echo -e "${BLUE}💡${NC} 提示信息"

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
cd - > /dev/null
rm -rf /tmp/wildcard_test 2>/dev/null
