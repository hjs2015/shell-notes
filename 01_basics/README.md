# 📚 阶段 2：基础篇 (Basics)

> **学习第 2-7 天** | 难度：⭐⭐ | **28 个脚本** | **完全扁平化** ✅

---

## 📖 简介

掌握 Shell 编程的基础知识，包括变量、运算符、输入输出等核心概念。

**目标**：
- ✅ 掌握变量定义和使用
- ✅ 理解各种运算符
- ✅ 熟练输入输出操作
- ✅ 学会字符串处理

**预计时间**：6 天，每天 1-2 小时

---

## 📁 脚本清单（重组后）

### 基础入门（01-05）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [01_hello_world.sh](01_hello_world.sh) | Hello World | ⭐ | 10 分钟 | 第一个脚本 |
| [02_special_variables.sh](02_special_variables.sh) | 特殊变量 | ⭐ | 30 分钟 | $0/$1/$#/$@/$? 等 |
| [03_variable_operations.sh](03_variable_operations.sh) | 变量操作 | ⭐ | 15 分钟 | 赋值/引用/删除 |
| [04_arithmetic_basics.sh](04_arithmetic_basics.sh) | 算术基础 | ⭐ | 15 分钟 | 基本计算 |
| [05_user_input_basic.sh](05_user_input_basic.sh) | 用户输入 | ⭐ | 15 分钟 | read 命令 |

### 输入输出实战（06-10）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [06_user_input_search.sh](06_user_input_search.sh) | 搜索输入 | ⭐⭐ | 20 分钟 | 交互式搜索 |
| [07_file_check.sh](07_file_check.sh) | 文件检查 | ⭐⭐ | 15 分钟 | 文件存在性 |
| [08_ping_check.sh](08_ping_check.sh) | Ping 检查 | ⭐⭐ | 15 分钟 | 网络连通性 |
| [09_user_info_complete.sh](09_user_info_complete.sh) | 完整用户信息 | ⭐⭐ | 25 分钟 | 综合练习 |
| [10_shell_execution_modes.sh](10_shell_execution_modes.sh) | 执行模式 | ⭐⭐ | 20 分钟 | source/bash/./ |

### 变量高级（11-19）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [11_variable_type_declaration.sh](11_variable_type_declaration.sh) | 变量类型声明 | ⭐⭐ | 15 分钟 | declare 命令 |
| [12_string_operations.sh](12_string_operations.sh) | 字符串操作 | ⭐⭐ | 20 分钟 | 截取/替换/删除 |
| [13_arithmetic_operations.sh](13_arithmetic_operations.sh) | 算术运算 | ⭐⭐ | 20 分钟 | 加减乘除 |
| [14_logical_operators.sh](14_logical_operators.sh) | 逻辑运算符 | ⭐⭐ | 15 分钟 | &&/||/! |
| [15_comparison_operations.sh](15_comparison_operations.sh) | 比较运算 | ⭐⭐ | 15 分钟 | 字符串/数字比较 |
| [16_read_command_advanced.sh](16_read_command_advanced.sh) | read 进阶 | ⭐⭐ | 20 分钟 | -p/-t/-a 参数 |
| [17_printf_formatting.sh](17_printf_formatting.sh) | printf 格式化 | ⭐⭐ | 20 分钟 | 格式化输出 |
| [18_here_document.sh](18_here_document.sh) | Here 文档 | ⭐⭐ | 20 分钟 | <<EOF |
| [19_variable_default_values.sh](19_variable_default_values.sh) | 默认值 | ⭐⭐ | 15 分钟 | ${var:-default} |

### 数组和字符串（20-24）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [20_array_basics.sh](20_array_basics.sh) | 数组基础 | ⭐⭐ | 20 分钟 | 定义/访问/遍历 |
| [21_regex_matching.sh](21_regex_matching.sh) | 正则匹配 | ⭐⭐⭐ | 25 分钟 | 正则表达式 |
| [22_case_conversion.sh](22_case_conversion.sh) | 大小写转换 | ⭐⭐ | 15 分钟 | 大小写互转 |
| [23_indirect_reference.sh](23_indirect_reference.sh) | 间接引用 | ⭐⭐⭐ | 20 分钟 | 间接变量引用 |
| [24_string_trim.sh](24_string_trim.sh) | 字符串修剪 | ⭐⭐ | 15 分钟 | 去除空格 |

### 高级主题（25-28）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [25_command_output_capture.sh](25_command_output_capture.sh) | 输出捕获 | ⭐⭐ | 15 分钟 | $() 和 `` |
| [26_environment_vs_local.sh](26_environment_vs_local.sh) | 环境变量 | ⭐⭐ | 20 分钟 | 环境 vs 局部 |
| [27_boolean_and_logic.sh](27_boolean_and_logic.sh) | 布尔逻辑 | ⭐⭐ | 15 分钟 | 布尔运算 |
| [28_wildcards_detailed.sh](28_wildcards_detailed.sh) | 通配符 | ⭐⭐ | 20 分钟 | */?/[] |

---

## 🎯 学习建议

### 第 2 天：基础入门
- 01_hello_world.sh
- 02_special_variables.sh
- 03_variable_operations.sh
- 04_arithmetic_basics.sh

### 第 3 天：输入输出
- 05_user_input_basic.sh
- 06_user_input_search.sh
- 07_file_check.sh
- 08_ping_check.sh

### 第 4 天：变量高级
- 09_user_info_complete.sh
- 10_shell_execution_modes.sh
- 11_variable_type_declaration.sh
- 12_string_operations.sh

### 第 5 天：运算符
- 13_arithmetic_operations.sh
- 14_logical_operators.sh
- 15_comparison_operations.sh
- 16_read_command_advanced.sh

### 第 6 天：格式化
- 17_printf_formatting.sh
- 18_here_document.sh
- 19_variable_default_values.sh
- 20_array_basics.sh

### 第 7 天：高级主题
- 21_regex_matching.sh
- 22_case_conversion.sh
- 23_indirect_reference.sh
- 24_string_trim.sh
- 25-28 选学

---

## 📝 重组说明

**重组前**：3 个子目录（01_variables/02_operators/03_io）+ 16 个根目录脚本  
**重组后**：完全扁平化，28 个脚本统一编号（01-28）

**优势**：
- ✅ 结构统一，查找快速
- ✅ 编号连续，便于引用
- ✅ 学习路径清晰

---

*更新时间：2026-03-21*  
**状态**：✅ 重组完成
