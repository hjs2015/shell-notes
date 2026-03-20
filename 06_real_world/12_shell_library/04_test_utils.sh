#!/bin/bash
# ============================================================================
# 脚本名称：04_test_utils.sh
# 功能描述：测试工具库 - 单元测试、断言、测试报告
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：单元测试、断言、测试框架、代码质量
# 使用方法：source 04_test_utils.sh
# 依赖命令：bash builtins
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================================
# 测试统计
# ============================================================================

TEST_TOTAL=0
TEST_PASSED=0
TEST_FAILED=0
TEST_SUITE=""

# ============================================================================
# 测试套件管理
# ============================================================================

# 开始测试套件
test_suite_start() {
    TEST_SUITE="$1"
    TEST_TOTAL=0
    TEST_PASSED=0
    TEST_FAILED=0
    
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}测试套件：$TEST_SUITE${NC}"
    echo -e "${BLUE}============================================================================${NC}"
    echo ""
}

# 结束测试套件
test_suite_end() {
    echo ""
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}测试报告：$TEST_SUITE${NC}"
    echo -e "${BLUE}============================================================================${NC}"
    echo "总测试数：$TEST_TOTAL"
    echo -e "${GREEN}通过：$TEST_PASSED${NC}"
    echo -e "${RED}失败：$TEST_FAILED${NC}"
    
    if [ $TEST_FAILED -eq 0 ]; then
        echo -e "${GREEN}✅ 所有测试通过！${NC}"
        return 0
    else
        echo -e "${RED}❌ 有测试失败${NC}"
        return 1
    fi
}

# ============================================================================
# 断言函数
# ============================================================================

# 断言相等
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-}"
    
    ((TEST_TOTAL++))
    
    if [ "$expected" = "$actual" ]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  期望：$expected"
        echo "  实际：$actual"
        return 1
    fi
}

# 断言不相等
assert_not_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-}"
    
    ((TEST_TOTAL++))
    
    if [ "$expected" != "$actual" ]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  不应等于：$expected"
        return 1
    fi
}

# 断言为真
assert_true() {
    local condition="$1"
    local message="${2:-}"
    
    ((TEST_TOTAL++))
    
    if eval "$condition"; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  条件应为真"
        return 1
    fi
}

# 断言为假
assert_false() {
    local condition="$1"
    local message="${2:-}"
    
    ((TEST_TOTAL++))
    
    if ! eval "$condition"; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  条件应为假"
        return 1
    fi
}

# 断言文件存在
assert_file_exists() {
    local file="$1"
    local message="${2:-文件存在}"
    
    ((TEST_TOTAL++))
    
    if [ -f "$file" ]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  文件不存在：$file"
        return 1
    fi
}

# 断言目录存在
assert_dir_exists() {
    local dir="$1"
    local message="${2:-目录存在}"
    
    ((TEST_TOTAL++))
    
    if [ -d "$dir" ]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  目录不存在：$dir"
        return 1
    fi
}

# 断言命令退出码
assert_exit_code() {
    local expected="$1"
    local command="$2"
    local message="${3:-退出码正确}"
    
    ((TEST_TOTAL++))
    
    eval "$command" > /dev/null 2>&1
    local actual=$?
    
    if [ "$expected" -eq "$actual" ]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  期望退出码：$expected"
        echo "  实际退出码：$actual"
        return 1
    fi
}

# 断言输出包含
assert_contains() {
    local expected="$1"
    local actual="$2"
    local message="${3:-}"
    
    ((TEST_TOTAL++))
    
    if [[ "$actual" == *"$expected"* ]]; then
        ((TEST_PASSED++))
        echo -e "${GREEN}✓ PASS${NC}: $message"
        return 0
    else
        ((TEST_FAILED++))
        echo -e "${RED}✗ FAIL${NC}: $message"
        echo "  应包含：$expected"
        echo "  实际：$actual"
        return 1
    fi
}

# ============================================================================
# 测试辅助函数
# ============================================================================

# 跳过测试
test_skip() {
    local message="$1"
    echo -e "${YELLOW}⊘ SKIP${NC}: $message"
}

# 测试失败（标记）
test_fail() {
    local message="$1"
    ((TEST_TOTAL++))
    ((TEST_FAILED++))
    echo -e "${RED}✗ FAIL${NC}: $message"
}

# 打印测试分隔线
test_separator() {
    echo ""
    echo -e "${BLUE}--- ${1:-测试分隔} ---${NC}"
    echo ""
}

# ============================================================================
# 示例用法
# ============================================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # 示例：测试字符串函数
    
    test_suite_start "字符串函数测试"
    
    # 测试 str_length
    test_separator "测试 str_length"
    local len=${#"Hello"}
    assert_equals "5" "$len" "str_length: Hello 的长度"
    
    # 测试文件存在
    test_separator "测试文件操作"
    assert_file_exists "/etc/passwd" "/etc/passwd 应该存在"
    assert_file_exists "/nonexistent" "不存在的文件" || true
    
    # 测试命令退出码
    test_separator "测试退出码"
    assert_exit_code 0 "ls /tmp" "ls 命令应该成功"
    assert_exit_code 1 "ls /nonexistent" "ls 不存在的目录应该失败"
    
    # 测试输出包含
    test_separator "测试输出"
    local output=$(echo "Hello World")
    assert_contains "Hello" "$output" "输出应包含 Hello"
    
    # 跳过测试示例
    test_separator "跳过测试"
    test_skip "这个测试被跳过"
    
    # 结束测试套件
    test_suite_end
    
    echo ""
    echo "✅ 测试工具库加载成功！"
fi
