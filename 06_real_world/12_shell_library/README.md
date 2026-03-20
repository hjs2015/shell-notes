# 📚 Shell 函数库

**难度等级**：⭐⭐⭐⭐⭐  
**学习时间**：第 85-90 天  
**脚本数量**：4 个

---

## 📋 脚本清单

| 脚本 | 名称 | 难度 | 知识点 | 行数 |
|------|------|:---:|:---|:---:|
| 01_shell_function_library.sh | 通用函数库 | ⭐⭐⭐⭐⭐ | 日志/错误处理/文件操作/网络检查 | ~180 行 |
| 02_string_utils.sh | 字符串工具库 | ⭐⭐⭐⭐⭐ | 字符串操作/格式化/转换 | ~150 行 |
| 03_file_utils.sh | 文件工具库 | ⭐⭐⭐⭐⭐ | 文件操作/目录管理/权限 | ~160 行 |
| 04_test_utils.sh | 测试工具库 | ⭐⭐⭐⭐⭐ | 单元测试/断言/测试报告 | ~180 行 |

---

## 🎯 学习目标

- ✅ 掌握 Shell 函数库设计原则
- ✅ 学会代码复用和模块化
- ✅ 理解单元测试的重要性
- ✅ 能够设计自己的工具函数库

---

## 📚 函数库详解

### 01_shell_function_library.sh - 通用函数库

提供日常运维中最常用的函数集合：

**日志函数**
```bash
log_info "操作成功"      # 绿色信息
log_error "操作失败"      # 红色错误
log_warn "警告信息"       # 黄色警告
log_debug "调试信息"      # 蓝色调试
```

**错误处理**
```bash
check_root              # 检查 root 权限
check_command "git"     # 检查命令是否存在
handle_error $? "操作失败"  # 错误处理
```

**文件操作**
```bash
create_dir "/tmp/test"      # 创建目录（带检查）
backup_file "/etc/hosts"    # 备份文件（带时间戳）
```

**网络检查**
```bash
check_port 80           # 检查端口是否开放
check_url "https://example.com"  # 检查 URL 可访问性
```

### 02_string_utils.sh - 字符串工具库

提供完整的字符串操作函数：

**基础操作**
```bash
str_length "Hello"              # 5
str_left "Hello World" 5        # "Hello"
str_right "Hello World" 5       # "World"
str_sub "Hello World" 0 5       # "Hello"
```

**查找与替换**
```bash
str_contains "Hello World" "World"    # true
str_index "Hello World" "World"       # 6
str_replace_first "hello" "l" "L"     # "heLlo"
str_replace_all "hello" "l" "L"       # "heLLo"
```

**大小写转换**
```bash
str_to_upper "hello"          # "HELLO"
str_to_lower "HELLO"          # "hello"
str_capitalize "hello"        # "Hello"
```

**修剪与分割**
```bash
str_trim "  hello  "          # "hello"
str_split "a,b,c" ","         # 输出：a\nb\nc
str_join "-" "a" "b" "c"      # "a-b-c"
```

**其他工具**
```bash
str_repeat "ab" 3             # "ababab"
str_reverse "hello"           # "olleh"
```

### 03_file_utils.sh - 文件工具库

提供文件操作相关的所有函数：

**文件检查**
```bash
file_exists "/etc/passwd"         # true
file_readable "/etc/passwd"       # true
file_writable "/tmp/test"         # true
file_executable "/bin/ls"         # true
file_empty "/tmp/empty"           # true/false
```

**文件信息**
```bash
file_size "/var/log/syslog"       # 1234567 (字节)
file_size_human "/var/log/syslog" # "1.2MB"
file_mtime "/etc/passwd"          # "2026-03-21 10:30:00"
file_extension "test.txt"         # "txt"
```

**文件操作**
```bash
file_create "/tmp/test/file.txt"  # 创建（自动创建目录）
file_copy "src.txt" "dest.txt"    # 复制（带备份）
file_delete "file.txt"            # 删除（交互式）
```

**目录操作**
```bash
dir_create "/tmp/test/dir"        # 递归创建
dir_delete_empty "/tmp/empty"     # 删除空目录
dir_delete_tree "/tmp/olddir"     # 删除目录树
```

**文件查找**
```bash
find_by_name "*.log" "/var/log"   # 按名称查找
find_by_type "f" "/tmp"           # 查找文件
find_by_mtime "-7" "/var/log"     # 7 天内修改的文件
find_by_size "+100M" "/home"      # 大于 100M 的文件
```

**临时文件**
```bash
temp_file=$(temp_file_create)     # 创建临时文件
temp_dir=$(temp_dir_create)       # 创建临时目录
```

### 04_test_utils.sh - 测试工具库

提供 Shell 脚本单元测试框架：

**测试套件管理**
```bash
test_suite_start "字符串函数测试"
# ... 测试代码 ...
test_suite_end
```

**断言函数**
```bash
assert_equals "5" "$len" "长度应该为 5"
assert_not_equals "0" "$count" "计数不应为 0"
assert_true "[ -f /etc/passwd ]" "/etc/passwd 应该存在"
assert_false "[ -f /nonexistent ]" "/nonexistent 不应存在"
assert_file_exists "/etc/passwd" "/etc/passwd 应该存在"
assert_dir_exists "/tmp" "/tmp 目录应该存在"
assert_exit_code 0 "ls /tmp" "ls 命令应该成功"
assert_contains "Hello" "$output" "输出应包含 Hello"
```

**测试辅助**
```bash
test_skip "这个测试被跳过"
test_fail "标记测试失败"
test_separator "测试分隔"
```

**测试报告**
```
测试套件：字符串函数测试
============================================================================
总测试数：10
通过：9
失败：1
❌ 有测试失败
```

---

## 💡 使用示例

### 示例 1：使用通用函数库

```bash
#!/bin/bash
source 01_shell_function_library.sh

main() {
    log_info "开始部署..."
    
    check_root || exit 1
    check_command "git" || exit 1
    
    create_dir "/opt/myapp"
    backup_file "/opt/myapp/config.ini"
    
    if check_port 80; then
        log_info "端口 80 可用"
    else
        log_error "端口 80 被占用"
        exit 1
    fi
    
    log_info "部署完成"
}

main "$@"
```

### 示例 2：使用字符串工具库

```bash
#!/bin/bash
source 02_string_utils.sh

filename="backup_2026-03-21.tar.gz"

# 提取日期
date_part=$(str_sub "$filename" 7 10)
echo "备份日期：$date_part"

# 检查是否为 tar.gz 格式
if str_contains "$filename" ".tar.gz"; then
    echo "这是 tar.gz 文件"
fi

# 转小写
lower_name=$(str_to_lower "$filename")
echo "小写名称：$lower_name"
```

### 示例 3：使用文件工具库

```bash
#!/bin/bash
source 03_file_utils.sh

config_file="/etc/myapp/config.ini"

# 检查配置文件
if ! file_exists "$config_file"; then
    echo "配置文件不存在"
    exit 1
fi

if ! file_readable "$config_file"; then
    echo "配置文件不可读"
    exit 1
fi

# 显示文件信息
echo "配置文件：$config_file"
echo "文件大小：$(file_size_human "$config_file")"
echo "修改时间：$(file_mtime "$config_file")"
```

### 示例 4：编写单元测试

```bash
#!/bin/bash
source 04_test_utils.sh
source 02_string_utils.sh

test_suite_start "字符串函数测试"

# 测试 str_length
len=$(str_length "Hello")
assert_equals "5" "$len" "str_length: Hello 的长度"

# 测试 str_to_upper
upper=$(str_to_upper "hello")
assert_equals "HELLO" "$upper" "str_to_upper: hello 转大写"

# 测试 str_contains
if str_contains "Hello World" "World"; then
    assert_true "true" "str_contains: 应包含 World"
else
    assert_true "false" "str_contains: 应包含 World"
fi

test_suite_end
```

---

## 🏆 最佳实践

### 1. 函数命名规范

```bash
# 使用动词 + 名词的组合
check_root() {}      # ✅ 好
verify_if_root() {}  # ❌ 不一致

# 使用小写和下划线
log_error() {}       # ✅ 好
LogError() {}        # ❌ 避免
```

### 2. 错误处理

```bash
my_function() {
    local param="$1"
    
    if [ -z "$param" ]; then
        log_error "参数不能为空"
        return 1
    fi
    
    # 主逻辑
    return 0
}
```

### 3. 文档注释

```bash
# ============================================================================
# 函数名称：str_length
# 功能描述：计算字符串长度
# 参数说明：$1 - 字符串
# 返回值：字符串长度（数字）
# 使用示例：len=$(str_length "Hello")
# ============================================================================
str_length() {
    local str="$1"
    echo "${#str}"
}
```

### 4. 单元测试

```bash
# 为每个重要函数编写测试
test_str_length() {
    assert_equals "5" "$(str_length "Hello")" "Hello 长度应为 5"
    assert_equals "0" "$(str_length "")" "空字符串长度应为 0"
    assert_equals "11" "$(str_length "Hello World")" "Hello World 长度应为 11"
}
```

---

## 📊 统计

| 指标 | 数值 |
|:---|:---:|
| 脚本数 | **4 个** |
| 代码行数 | **~670 行** |
| 平均脚本 | **~167 行** |
| 函数总数 | **50+ 个** |
| 测试用例 | **20+ 个** |

---

## 🔗 相关资源

- [Bash 内置变量](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)
- [Shell 编程指南](https://google.github.io/styleguide/shellguide.html)
- [Bash 单元测试框架](https://github.com/lehmannro/assert.sh)
- [Shell 函数库设计模式](https://github.com/kward/shunit2)
