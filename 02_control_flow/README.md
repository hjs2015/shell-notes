# 📚 阶段 3：流程控制 (Control Flow)

> **学习第 8-21 天** | 难度：⭐⭐⭐ | **28 个核心脚本** | 预计 20-25 小时

---

## 📋 目录

- [简介](#简介)
- [脚本清单](#脚本清单)
  - [条件判断（01-06）](#条件判断 01-06)
  - [循环结构（07-14）](#循环结构 07-14)
  - [case 语句（15-19）](#case-语句 15-19)
  - [函数（20-28）](#函数 20-28)
- [14 天学习计划](#14-天学习计划)
- [核心知识点详解](#核心知识点详解)
  - [条件判断](#条件判断)
  - [循环结构](#循环结构)
  - [case 语句](#case-语句)
  - [函数](#函数)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 简介

掌握 Shell 编程的核心控制结构，包括条件判断、循环、case 语句和函数。

**学完你能做什么**：
- ✅ 编写有逻辑判断的智能脚本
- ✅ 用循环批量处理文件和数据
- ✅ 创建交互式菜单
- ✅ 用函数组织复杂代码
- ✅ 调试和排查脚本问题

**预计时间**：14 天，每天 1-2 小时

---

## 📁 脚本清单

### 条件判断（01-06）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [01_logic_operation.sh](01_logic_operation.sh) | 逻辑运算 | ⭐⭐ | 20 分钟 | AND/OR/NOT |
| [02_file_type_check.sh](02_file_type_check.sh) | 文件类型检查 | ⭐⭐ | 20 分钟 | -f/-d/-l |
| [03_file_permission_check.sh](03_file_permission_check.sh) | 权限检查 | ⭐⭐ | 20 分钟 | -r/-w/-x |
| [04_dead_link_check.sh](04_dead_link_check.sh) | 死链检查 | ⭐⭐⭐ | 25 分钟 | 链接有效性 |
| [05_string_comparison.sh](05_string_comparison.sh) | 字符串比较 | ⭐⭐ | 15 分钟 | =/!=/</> |
| [06_c_style_comparison.sh](06_c_style_comparison.sh) | C 风格比较 | ⭐⭐ | 15 分钟 | (( )) 语法 |

### 循环结构（07-14）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [07_for_loop_basic.sh](07_for_loop_basic.sh) | for 循环基础 | ⭐⭐ | 20 分钟 | 基本语法 |
| [08_for_c_style.sh](08_for_c_style.sh) | C 风格 for | ⭐⭐⭐ | 25 分钟 | C 风格语法 |
| [09_until_loop.sh](09_until_loop.sh) | until 循环 | ⭐⭐ | 20 分钟 | until 用法 |
| [10_break_continue.sh](10_break_continue.sh) | 循环控制 | ⭐⭐ | 15 分钟 | break/continue |
| [11_for_array.sh](11_for_array.sh) | 数组遍历 | ⭐⭐ | 20 分钟 | 遍历数组 |
| [12_guess_number_game.sh](12_guess_number_game.sh) | 猜数字游戏 | ⭐⭐⭐ | 30 分钟 | 综合练习 |
| [13_nested_loop_pattern.sh](13_nested_loop_pattern.sh) | 嵌套循环 | ⭐⭐⭐ | 30 分钟 | 循环嵌套 |
| [14_prime_numbers.sh](14_prime_numbers.sh) | 素数计算 | ⭐⭐⭐ | 30 分钟 | 数学计算 |

### case 语句（15-19）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [15_service_price.sh](15_service_price.sh) | 服务价格查询 | ⭐⭐ | 20 分钟 | case 基础 |
| [16_phone_brand_menu.sh](16_phone_brand_menu.sh) | 手机品牌菜单 | ⭐⭐ | 20 分钟 | 多级菜单 |
| [17_sysv_init_script.sh](17_sysv_init_script.sh) | SysV 初始化 | ⭐⭐⭐ | 30 分钟 | init 脚本 |
| [18_number_to_words.sh](18_number_to_words.sh) | 数字转文字 | ⭐⭐⭐ | 25 分钟 | 数字转换 |
| [19_usb_mount_menu.sh](19_usb_mount_menu.sh) | USB 挂载菜单 | ⭐⭐⭐ | 25 分钟 | 硬件操作 |

### 函数（20-28）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
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

## 📅 14 天学习计划

### 第 8-9 天：条件判断（6 个脚本，3 小时）

**学习内容**：
- 01_logic_operation.sh - 逻辑运算
- 02_file_type_check.sh - 文件类型检查
- 03_file_permission_check.sh - 权限检查
- 04_dead_link_check.sh - 死链检查
- 05_string_comparison.sh - 字符串比较
- 06_c_style_comparison.sh - C 风格比较

**目标**：掌握 if 条件和文件测试

---

### 第 10-12 天：循环结构（8 个脚本，5 小时）

**学习内容**：
- 07_for_loop_basic.sh - for 循环基础
- 08_for_c_style.sh - C 风格 for
- 09_until_loop.sh - until 循环
- 10_break_continue.sh - 循环控制
- 11_for_array.sh - 数组遍历
- 12_guess_number_game.sh - 猜数字游戏
- 13_nested_loop_pattern.sh - 嵌套循环
- 14_prime_numbers.sh - 素数计算

**目标**：熟练使用各种循环

---

### 第 13-14 天：case 语句（5 个脚本，2.5 小时）

**学习内容**：
- 15_service_price.sh - 服务价格查询
- 16_phone_brand_menu.sh - 手机品牌菜单
- 17_sysv_init_script.sh - SysV 初始化
- 18_number_to_words.sh - 数字转文字
- 19_usb_mount_menu.sh - USB 挂载菜单

**目标**：创建交互式菜单

---

### 第 15-17 天：函数基础（4 个脚本，2 小时）

**学习内容**：
- 20_function_basics.sh - 函数基础
- 21_function_parameters.sh - 函数参数
- 22_local_variables.sh - 局部变量
- 23_return_values.sh - 返回值

**目标**：掌握函数定义和调用

---

### 第 18-21 天：函数高级（5 个脚本，3 小时）

**学习内容**：
- 24_function_recursion.sh - 递归函数
- 25_function_nesting.sh - 函数嵌套
- 26_function_library.sh - 函数库
- 27_script_debugging.sh - 脚本调试
- 28_exit_codes.sh - 退出码

**目标**：编写模块化代码

---

## 🔍 核心知识点详解

### 条件判断

**if 语句**：
```bash
#!/bin/bash
# 基本 if
if [ -f "file.txt" ]; then
    echo "文件存在"
fi

# if-else
if [ -f "file.txt" ]; then
    echo "文件存在"
else
    echo "文件不存在"
fi

# if-elif-else
score=85
if [ $score -ge 90 ]; then
    echo "优秀"
elif [ $score -ge 80 ]; then
    echo "良好"
elif [ $score -ge 60 ]; then
    echo "及格"
else
    echo "不及格"
fi
```

**文件测试**：
```bash
#!/bin/bash
# 文件类型
[ -f file ]    # 普通文件
[ -d dir ]     # 目录
[ -l link ]    # 符号链接
[ -e path ]    # 存在（任意类型）

# 文件权限
[ -r file ]    # 可读
[ -w file ]    # 可写
[ -x file ]    # 可执行

# 文件状态
[ -s file ]    # 非空
[ -N file ]    # 最近修改过
[ file1 -nt file2 ]  # file1 比 file2 新
[ file1 -ot file2 ]  # file1 比 file2 旧
```

**逻辑运算**：
```bash
#!/bin/bash
# AND（与）- 两个条件都满足
if [ -f file.txt ] && [ -r file.txt ]; then
    echo "文件存在且可读"
fi

# OR（或）- 任一条件满足
if [ -f file.txt ] || [ -f file.log ]; then
    echo "file.txt 或 file.log 存在"
fi

# NOT（非）- 取反
if [ ! -f file.txt ]; then
    echo "文件不存在"
fi

# 组合使用
if [ -f file.txt ] && [ -r file.txt ] || [ "$USER" = "root" ]; then
    echo "可以读取文件"
fi
```

---

### 循环结构

**for 循环**：
```bash
#!/bin/bash
# 遍历列表
for i in 1 2 3 4 5; do
    echo "数字：$i"
done

# 遍历文件
for file in *.txt; do
    echo "处理：$file"
done

# C 风格 for（推荐用于计数）
for ((i=0; i<10; i++)); do
    echo "计数：$i"
done

# 遍历命令输出
for user in $(cat /etc/passwd | cut -d: -f1); do
    echo "用户：$user"
done
```

**while 循环**：
```bash
#!/bin/bash
# 基本 while
count=0
while [ $count -lt 5 ]; do
    echo "计数：$count"
    ((count++))
done

# 读取文件
while IFS= read -r line; do
    echo "行：$line"
done < file.txt

# 无限循环（用 break 退出）
while true; do
    read -p "输入命令（quit 退出）：" cmd
    if [ "$cmd" = "quit" ]; then
        break
    fi
    echo "执行：$cmd"
done
```

**until 循环**（条件为假时执行）：
```bash
#!/bin/bash
# until 循环（直到条件为真）
count=0
until [ $count -ge 5 ]; do
    echo "计数：$count"
    ((count++))
done
```

**循环控制**：
```bash
#!/bin/bash
# break - 退出循环
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break  # 到 5 就退出
    fi
    echo $i
done
# 输出：1 2 3 4

# continue - 跳过本次
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue  # 跳过偶数
    fi
    echo $i
done
# 输出：1 3 5 7 9
```

**嵌套循环**：
```bash
#!/bin/bash
# 九九乘法表
for ((i=1; i<=9; i++)); do
    for ((j=1; j<=i; j++)); do
        printf "%d×%d=%d\t" $j $i $((i*j))
    done
    echo
done
```

---

### case 语句

**基本语法**：
```bash
#!/bin/bash
read -p "输入选项（1/2/3）：" choice

case $choice in
    1)
        echo "选项 1：查看文件"
        ls -l
        ;;
    2)
        echo "选项 2：查看系统"
        uname -a
        ;;
    3)
        echo "选项 3：退出"
        exit 0
        ;;
    *)
        echo "无效选项"
        exit 1
        ;;
esac
```

**模式匹配**：
```bash
#!/bin/bash
case $input in
    start|begin)
        echo "启动服务"
        ;;
    stop|end)
        echo "停止服务"
        ;;
    restart)
        echo "重启服务"
        ;;
    [Yy]|[Yy][Ee][Ss])
        echo "确认"
        ;;
    [Nn]|[Nn][Oo])
        echo "取消"
        ;;
    *.txt)
        echo "文本文件"
        ;;
    *)
        echo "未知输入"
        ;;
esac
```

**菜单示例**：
```bash
#!/bin/bash
while true; do
    echo "=========================="
    echo "     系统管理菜单"
    echo "=========================="
    echo "1) 查看磁盘"
    echo "2) 查看内存"
    echo "3) 查看进程"
    echo "0) 退出"
    echo "=========================="
    
    read -p "请选择 [0-3]：" choice
    
    case $choice in
        1)
            df -h
            ;;
        2)
            free -h
            ;;
        3)
            ps aux | head -20
            ;;
        0)
            echo "退出"
            exit 0
            ;;
        *)
            echo "无效选项"
            ;;
    esac
    
    echo
    read -p "按回车继续..."
done
```

---

### 函数

**定义和调用**：
```bash
#!/bin/bash
# 定义函数
greet() {
    echo "你好，$1"
}

# 调用函数
greet "John"      # 输出：你好，John
greet "Mary"      # 输出：你好，Mary
```

**参数传递**：
```bash
#!/bin/bash
add() {
    local a=$1
    local b=$2
    local sum=$((a + b))
    echo "和：$sum"
}

add 10 20  # 输出：和：30
```

**返回值**：
```bash
#!/bin/bash
# 方法 1：return（只能返回 0-255）
check_file() {
    if [ -f "$1" ]; then
        return 0  # 成功
    else
        return 1  # 失败
    fi
}

check_file "file.txt"
if [ $? -eq 0 ]; then
    echo "文件存在"
fi

# 方法 2：echo 输出
get_max() {
    if [ $1 -gt $2 ]; then
        echo $1
    else
        echo $2
    fi
}

max=$(get_max 10 20)
echo "最大值：$max"  # 输出：最大值：20
```

**局部变量**：
```bash
#!/bin/bash
func() {
    local var="local"   # 局部变量（只在函数内有效）
    global="global"     # 全局变量（函数外也可访问）
    echo "函数内：$var, $global"
}

func
echo "函数外：$global"  # 可访问
echo "函数外：$var"     # 未定义
```

**递归函数**：
```bash
#!/bin/bash
factorial() {
    local n=$1
    if [ $n -le 1 ]; then
        echo 1
    else
        local prev=$(factorial $((n-1)))
        echo $((n * prev))
    fi
}

result=$(factorial 5)
echo "5! = $result"  # 输出：5! = 120
```

**函数库**：
```bash
#!/bin/bash
# lib.sh - 函数库
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

# main.sh - 主脚本
source lib.sh
log_info "程序启动"
log_error "发生错误"
```

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. if 条件空格错误

**错误**：
```bash
if [ -f file.txt ];then  # ❌ then 前需要空格或分号
    echo "存在"
fi
```

**正确**：
```bash
if [ -f file.txt ]; then  # ✅ 分号后加空格
    echo "存在"
fi

# 或
if [ -f file.txt ]
then  # ✅ 换行写
    echo "存在"
fi
```

---

### 2. 条件判断用错运算符

**错误**：
```bash
if [ $a > $b ]; then  # ❌ > 是重定向符号
    echo "a 大于 b"
fi
```

**正确**：
```bash
if [ $a -gt $b ]; then  # ✅ 用 -gt
    echo "a 大于 b"
fi

# 或 C 风格
if (( a > b )); then    # ✅ (( )) 内可用 >
    echo "a 大于 b"
fi
```

---

### 3. for 循环不引用数组

**错误**：
```bash
arr=("file 1.txt" "file 2.txt")
for f in ${arr[@]}; do  # ❌ 会被拆分成 4 个词
    echo "$f"
done
```

**正确**：
```bash
arr=("file 1.txt" "file 2.txt")
for f in "${arr[@]}"; do  # ✅ 保留空格
    echo "$f"
done
```

---

### 4. while read 不处理最后一行

**错误**：
```bash
while read line; do  # ❌ 最后一行无换行会丢失
    echo "$line"
done < file.txt
```

**正确**：
```bash
while IFS= read -r line || [ -n "$line" ]; do  # ✅ 处理最后一行
    echo "$line"
done < file.txt
```

---

### 5. case 语句忘记双分号

**错误**：
```bash
case $choice in
    1)
        echo "选项 1"
        # ❌ 忘记 ;;
    2)
        echo "选项 2"
        ;;
esac
```

**正确**：
```bash
case $choice in
    1)
        echo "选项 1"
        ;;  # ✅ 每个分支以 ;; 结束
    2)
        echo "选项 2"
        ;;
esac
```

---

### 6. 函数返回值误解

**错误**：
```bash
add() {
    return $(( $1 + $2 ))  # ❌ return 只能 0-255
}
```

**正确**：
```bash
add() {
    echo $(( $1 + $2 ))  # ✅ 用 echo 输出
}

result=$(add 10 20)
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: 如何退出多层循环？

**方法**：
```bash
# break n - 退出 n 层循环
for ((i=0; i<5; i++)); do
    for ((j=0; j<5; j++)); do
        if [ $j -eq 3 ]; then
            break 2  # 退出 2 层循环
        fi
        echo "i=$i, j=$j"
    done
done
```

---

### Q2: 如何后台运行循环？

**方法**：
```bash
# 后台运行
for i in {1..10}; do
    {
        echo "处理 $i"
        sleep 1
    } &
done
wait  # 等待所有后台任务完成
```

---

### Q3: case 语句如何匹配多个值？

**方法**：
```bash
case $input in
    start|begin|run)
        echo "启动"
        ;;
    stop|end|quit)
        echo "停止"
        ;;
    [Yy]|[Yy][Ee][Ss])
        echo "是"
        ;;
esac
```

---

### Q4: 如何获取函数返回值？

**方法**：
```bash
# 方法 1：echo 输出（推荐）
get_value() {
    echo "42"
}
value=$(get_value)

# 方法 2：全局变量
get_value() {
    RESULT="42"
}
get_value
echo "$RESULT"

# 方法 3：return（仅 0-255）
check_status() {
    return 0  # 成功
}
check_status
if [ $? -eq 0 ]; then
    echo "成功"
fi
```

---

### Q5: 如何调试函数？

**方法**：
```bash
# 方法 1：set -x
set -x
my_function
set +x

# 方法 2：函数内加日志
my_function() {
    echo "[DEBUG] 进入函数" >&2
    echo "[DEBUG] 参数：$@" >&2
    # ... 代码 ...
    echo "[DEBUG] 退出函数" >&2
}
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 使用 if/elif/else 进行条件判断
- [ ] 用文件测试操作符检查文件
- [ ] 编写 for/while/until 循环
- [ ] 使用 break/continue 控制循环
- [ ] 创建 case 菜单
- [ ] 定义和调用函数
- [ ] 传递参数和返回值
- [ ] 使用局部变量
- [ ] 调试脚本问题
- [ ] 避免常见陷阱

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[03_data_structures/](../03_data_structures/)** - 数据结构篇（第 22-28 天）

你将学习：
- 数组高级操作
- 关联数组
- 字符串高级处理
- 正则表达式

---

## 💡 小贴士

1. **条件加引号** - `[ "$var" = "value" ]` 避免空值错误
2. **循环引用数组** - `"${arr[@]}"` 保留空格
3. **函数用 local** - 避免污染全局变量
4. **调试用 -x** - `bash -x script.sh` 查看执行
5. **case 用 ;;** - 每个分支以双分号结束

---

## 📚 参考资源

- [Bash 条件测试](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html)
- [循环结构详解](https://tldp.org/LDP/Bash-Beginners-Guide/html/chap_09.html)
- [函数使用指南](https://tldp.org/LDP/abs/html/functions.html)
- [快速参考手册](../SHELL_GUIDE_BASE.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-脚本清单) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)
