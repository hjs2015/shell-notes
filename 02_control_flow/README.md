# 📚 阶段 3：流程控制 (Control Flow)

> **学习第 8-21 天** | 难度：⭐⭐⭐ | **28 个核心脚本** | **完全扁平化** ✅

---

## 📖 简介

掌握 Shell 编程的核心控制结构，包括条件判断、循环、case 语句和函数。

**目标**：
- ✅ 掌握 if/else 条件判断
- ✅ 熟练使用 for/while/until 循环
- ✅ 理解 case 语句和多分支选择
- ✅ 学会函数定义和调用

**预计时间**：14 天，每天 1-2 小时

---

## 📁 脚本清单（重组后）

### 条件判断（01-06）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [01_logic_operation.sh](01_logic_operation.sh) | 逻辑运算 | ⭐⭐ | 20 分钟 | AND/OR/NOT |
| [02_file_type_check.sh](02_file_type_check.sh) | 文件类型检查 | ⭐⭐ | 20 分钟 | -f/-d/-l 等 |
| [03_file_permission_check.sh](03_file_permission_check.sh) | 权限检查 | ⭐⭐ | 20 分钟 | -r/-w/-x |
| [04_dead_link_check.sh](04_dead_link_check.sh) | 死链检查 | ⭐⭐⭐ | 25 分钟 | 链接有效性 |
| [05_string_comparison.sh](05_string_comparison.sh) | 字符串比较 | ⭐⭐ | 15 分钟 | =/!=/</> |
| [06_c_style_comparison.sh](06_c_style_comparison.sh) | C 风格比较 | ⭐⭐ | 15 分钟 | (( )) 语法 |

### 循环结构（07-14）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [07_for_loop_basic.sh](07_for_loop_basic.sh) | for 循环基础 | ⭐⭐ | 20 分钟 | 基本语法 |
| [08_for_c_style.sh](08_for_c_style.sh) | C 风格 for | ⭐⭐⭐ | 25 分钟 | C 风格语法 |
| [09_until_loop.sh](09_until_loop.sh) | until 循环 | ⭐⭐ | 20 分钟 | until 用法 |
| [10_break_continue.sh](10_break_continue.sh) | 循环控制 | ⭐⭐ | 15 分钟 | break/continue |
| [11_for_array.sh](11_for_array.sh) | 数组遍历 | ⭐⭐ | 20 分钟 | 遍历数组 |
| [12_guess_number_game.sh](12_guess_number_game.sh) | 猜数字游戏 | ⭐⭐⭐ | 30 分钟 | 综合练习 |
| [13_nested_loop_pattern.sh](13_nested_loop_pattern.sh) | 嵌套循环 | ⭐⭐⭐ | 30 分钟 | 循环嵌套 |
| [14_prime_numbers.sh](14_prime_numbers.sh) | 素数计算 | ⭐⭐⭐ | 30 分钟 | 数学计算 |

### case 语句（15-19）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [15_service_price.sh](15_service_price.sh) | 服务价格查询 | ⭐⭐ | 20 分钟 | case 基础 |
| [16_phone_brand_menu.sh](16_phone_brand_menu.sh) | 手机品牌菜单 | ⭐⭐ | 20 分钟 | 多级菜单 |
| [17_sysv_init_script.sh](17_sysv_init_script.sh) | SysV 初始化 | ⭐⭐⭐ | 30 分钟 | init 脚本 |
| [18_number_to_words.sh](18_number_to_words.sh) | 数字转文字 | ⭐⭐⭐ | 25 分钟 | 数字转换 |
| [19_usb_mount_menu.sh](19_usb_mount_menu.sh) | USB 挂载菜单 | ⭐⭐⭐ | 25 分钟 | 硬件操作 |

### 函数（20-28）

| 脚本 | 名称 | 难度 | 时间 | 说明 |
|------|------|------|------|------|
| [20_function_basics.sh](20_function_basics.sh) | 函数基础 | ⭐⭐ | 20 分钟 | 定义/调用 |
| [21_function_parameters.sh](21_function_parameters.sh) | 函数参数 | ⭐⭐ | 20 分钟 | 参数传递 |
| [22_local_variables.sh](22_local_variables.sh) | 局部变量 | ⭐⭐ | 15 分钟 | local 关键字 |
| [23_return_values.sh](23_return_values.sh) | 返回值 | ⭐⭐ | 20 分钟 | return 语句 |
| [24_function_recursion.sh](24_function_recursion.sh) | 递归函数 | ⭐⭐⭐ | 30 分钟 | 递归调用 |
| [25_function_nesting.sh](25_function_nesting.sh) | 函数嵌套 | ⭐⭐⭐ | 25 分钟 | 嵌套调用 |
| [26_function_library.sh](26_function_library.sh) | 函数库 | ⭐⭐⭐ | 30 分钟 | 库函数 |
| [27_script_debugging.sh](27_script_debugging.sh) | 脚本调试 | ⭐⭐⭐ | 30 分钟 | set -x 等 |
| [28_exit_codes.sh](28_exit_codes.sh) | 退出码 | ⭐⭐ | 20 分钟 | $?/exit |

---

## 🎯 学习建议

### 第 8-9 天：条件判断
- 01-06 条件判断脚本
- 重点：文件检查、字符串比较

### 第 10-12 天：循环结构
- 07-14 循环脚本
- 重点：for/while、嵌套循环

### 第 13-14 天：case 语句
- 15-19 case 脚本
- 重点：菜单设计、init 脚本

### 第 15-17 天：函数基础
- 20-23 函数基础
- 重点：参数传递、返回值

### 第 18-21 天：函数高级
- 24-28 函数高级
- 重点：递归、调试、退出码

---

## 📝 重组说明

**重组前**：4 个子目录（01_condition/02_loops/03_case/04_functions）+ 22 个根目录脚本（共 67 个）  
**重组后**：完全扁平化，精简到 28 个核心脚本（01-28）

**删除**：39 个重复/低质量脚本（如多个猜数字、俄罗斯方块等）  
**保留**：28 个核心精华脚本

**优势**：
- ✅ 结构统一，查找快速
- ✅ 编号连续，便于引用
- ✅ 质量提升，去除冗余

---

*更新时间：2026-03-21*  
**状态**：✅ 重组完成
