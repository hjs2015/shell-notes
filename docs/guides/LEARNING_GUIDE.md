# 📚 Shell 编程学习指南

> 完整的学习路径，从零基础到实战专家 | **226 个脚本** + **7 个学习阶段** + **90 天学习计划**

**最后更新**：2026-03-20  
**仓库**：https://github.com/hjs2015/shell-notes

---

## 📖 学习路线总览

### 仓库结构（2026-03-20 新版）

```
shell-notes/
├── 00_quickstart/          # 快速开始 (⭐) - 5 个脚本 - 第 1 天
├── 01_basics/              # 基础篇 (⭐⭐) - 28 个脚本 - 第 2-7 天
├── 02_control_flow/        # 流程控制 (⭐⭐⭐) - 67 个脚本 - 第 8-21 天
├── 03_data_structures/     # 数据结构 (⭐⭐⭐) - 19 个脚本 - 第 22-28 天
├── 04_text_processing/     # 文本处理 (⭐⭐⭐⭐) - 23 个脚本 - 第 29-42 天
├── 05_system_programming/  # 系统编程 (⭐⭐⭐⭐) - 35 个脚本 - 第 43-58 天
└── 06_real_world/          # 实战项目 (⭐⭐⭐⭐⭐) - 49 个脚本 - 第 59-90 天
```

**总计**：226 个脚本，24,242 行代码，7 个学习阶段，90 天学习计划

**每个目录都有独立的 README.md**，包含：
- 📋 完整脚本清单表格
- 🎯 学习目标
- 📚 知识点详解
- 💻 示例代码
- 🔧 练习任务
- ⚠️ 常见错误
- 📖 扩展阅读

---

## 🗓️ 90 天学习计划

### 阶段 1：快速开始（第 1 天）⭐

**目录**：`00_quickstart/` (5 个脚本)

#### 学习内容

| 脚本 | 名称 | 时间 | 知识点 |
|------|------|------|--------|
| [01_hello_world.sh](../../00_quickstart/01_hello_world.sh) | Hello World | 10 分钟 | 第一个脚本，echo |
| [02_special_variables.sh](../../00_quickstart/02_special_variables.sh) | 特殊变量 | 30 分钟 | `$0`, `$1`, `$#`, `$@`, `$*` |
| [03_echo_read.sh](../../00_quickstart/03_echo_read.sh) | 输入输出 | 15 分钟 | echo, read |
| [04_shell_environment_check.sh](../../00_quickstart/04_shell_environment_check.sh) | 环境检测 | 20 分钟 | 系统信息检测 |
| [05_script_execution_methods.sh](../../00_quickstart/05_script_execution_methods.sh) | 执行方式 | 25 分钟 | bash, sh, source, . |

#### 实战练习

```bash
# 1. 创建你的第一个脚本
cat > hello.sh << 'EOF'
#!/bin/bash
echo "Hello, World!"
EOF
chmod +x hello.sh
./hello.sh

# 2. 理解特殊变量
cat > test_vars.sh << 'EOF'
#!/bin/bash
echo "脚本名：$0"
echo "参数 1: $1"
echo "参数个数：$#"
echo "所有参数：$@"
EOF
bash test_vars.sh arg1 arg2 arg3

# 3. 环境检测
bash 00_quickstart/04_shell_environment_check.sh
```

**完成后你将能够**：
- ✅ 创建并运行 Shell 脚本
- ✅ 理解特殊变量的用途
- ✅ 使用 echo 和 read 进行交互
- ✅ 检测 Shell 环境

**📖 详细文档**：[00_quickstart/README.md](../../00_quickstart/README.md)

---

### 阶段 2：基础篇（第 2-7 天）⭐⭐

**目录**：`01_basics/` (28 个脚本)

#### 学习路径

**第 2 天**：变量基础（脚本 01-07）
- 变量赋值、引用、作用域
- 只读变量、删除变量

**第 3 天**：运算符（脚本 08-17）
- 算术运算、逻辑运算
- 比较运算

**第 4 天**：输入输出（脚本 18-20）
- read 进阶、printf 格式化
- Here Document

**第 5 天**：高级变量（脚本 21-28）
- 变量默认值、数组基础
- 正则匹配、大小写转换
- 间接引用、环境变量

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [13_variable_type_declaration.sh](../../01_basics/13_variable_type_declaration.sh) | 变量类型声明 | ⭐⭐ | 15 分钟 |
| [14_string_operations.sh](../../01_basics/14_string_operations.sh) | 字符串操作 | ⭐⭐ | 20 分钟 |
| [19_printf_formatting.sh](../../01_basics/19_printf_formatting.sh) | printf 格式化 | ⭐⭐ | 20 分钟 |
| [20_here_document.sh](../../01_basics/20_here_document.sh) | Here Document | ⭐⭐ | 20 分钟 |
| [22_array_basics.sh](../../01_basics/22_array_basics.sh) | 数组基础 | ⭐⭐ | 20 分钟 |

#### 实战练习

```bash
# 1. 字符串操作
name="Hello World"
echo "${name:0:5}"    # Hello
echo "${name//World/Shell}"  # Hello Shell

# 2. 算术运算
a=10
b=20
echo $((a + b))       # 30
echo $((a * b))       # 200

# 3. Here Document
cat > config.txt << EOF
server=localhost
port=8080
user=admin
EOF
cat config.txt

# 4. 数组操作
fruits=("apple" "banana" "orange")
echo "${fruits[0]}"   # apple
echo "${#fruits[@]}"  # 3
```

**完成后你将能够**：
- ✅ 熟练使用各种变量
- ✅ 进行算术和逻辑运算
- ✅ 格式化输入输出
- ✅ 使用数组存储数据

**📖 详细文档**：[01_basics/README.md](../../01_basics/README.md)

---

### 阶段 3：流程控制（第 8-21 天）⭐⭐⭐

**目录**：`02_control_flow/` (67 个脚本)

#### 学习路径

**第 8-10 天**：条件判断（脚本 01-10）
- if/else/elif
- 字符串/数值/文件比较
- case 语句、select 菜单

**第 11-16 天**：循环结构（脚本 11-30）
- for 循环（基础/范围/数组/文件）
- while/until 循环
- break/continue
- 嵌套循环

**第 17-21 天**：函数（脚本 31-67）
- 函数定义、参数、返回值
- 局部变量、递归
- 错误处理、信号处理
- 作业控制、超时重试

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_if_basic.sh](../../02_control_flow/01_if_basic.sh) | if 基础 | ⭐⭐⭐ | 20 分钟 |
| [08_case_basic.sh](../../02_control_flow/08_case_basic.sh) | case 基础 | ⭐⭐⭐ | 25 分钟 |
| [11_for_basic.sh](../../02_control_flow/11_for_basic.sh) | for 基础 | ⭐⭐⭐ | 20 分钟 |
| [15_while_basic.sh](../../02_control_flow/15_while_basic.sh) | while 基础 | ⭐⭐⭐ | 20 分钟 |
| [31_function_basic.sh](../../02_control_flow/31_function_basic.sh) | 函数基础 | ⭐⭐⭐ | 20 分钟 |
| [35_function_recursive.sh](../../02_control_flow/35_function_recursive.sh) | 递归函数 | ⭐⭐⭐⭐ | 30 分钟 |
| [46_function_trap.sh](../../02_control_flow/46_function_trap.sh) | trap 信号 | ⭐⭐⭐⭐⭐ | 35 分钟 |

#### 实战练习

```bash
# 1. 猜数字游戏
number=$((RANDOM % 100 + 1))
while true; do
    read -p "猜数字 (1-100): " guess
    if [ $guess -eq $number ]; then
        echo "猜对了！"
        break
    elif [ $guess -lt $number ]; then
        echo "太小了"
    else
        echo "太大了"
    fi
done

# 2. 服务管理菜单
select action in start stop restart exit; do
    case $action in
        start) echo "启动服务..." ;;
        stop) echo "停止服务..." ;;
        restart) echo "重启服务..." ;;
        exit) break ;;
    esac
done

# 3. 函数库
source 02_control_flow/37_function_library.sh
color_print "红色文字" "red"
```

**完成后你将能够**：
- ✅ 编写有逻辑判断的脚本
- ✅ 使用各种循环结构
- ✅ 定义和调用函数
- ✅ 处理错误和异常

**📖 详细文档**：[02_control_flow/README.md](../../02_control_flow/README.md)

---

### 阶段 4：数据结构（第 22-28 天）⭐⭐⭐

**目录**：`03_data_structures/` (19 个脚本)

#### 学习路径

**第 22-23 天**：索引数组（7 个脚本）
- 创建、访问、修改
- 切片、合并、排序、搜索

**第 24-25 天**：关联数组（6 个脚本）
- 字典创建、访问、修改
- 遍历、删除

**第 26-28 天**：字符串操作（6 个脚本）
- 拼接、分割、替换
- 修剪、反转

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_indexed_arrays/01_array_create.sh](../../03_data_structures/01_indexed_arrays/01_array_create.sh) | 创建数组 | ⭐⭐⭐ | 20 分钟 |
| [01_indexed_arrays/04_array_slice.sh](../../03_data_structures/01_indexed_arrays/04_array_slice.sh) | 数组切片 | ⭐⭐⭐⭐ | 25 分钟 |
| [02_associative_arrays/01_dict_create.sh](../../03_data_structures/02_associative_arrays/01_dict_create.sh) | 创建字典 | ⭐⭐⭐ | 20 分钟 |
| [03_strings/02_string_split.sh](../../03_data_structures/03_strings/02_string_split.sh) | 字符串分割 | ⭐⭐⭐⭐ | 25 分钟 |

#### 实战练习

```bash
# 1. 索引数组
numbers=(1 2 3 4 5)
echo "${numbers[@]}"      # 1 2 3 4 5
echo "${numbers:1:3}"     # 2 3 4

# 2. 关联数组
declare -A user
user[name]="Alice"
user[age]=25
echo "${user[name]}"      # Alice

# 3. 字符串分割
str="apple,banana,orange"
IFS=',' read -ra arr <<< "$str"
echo "${arr[1]}"          # banana
```

**完成后你将能够**：
- ✅ 使用数组存储和遍历数据
- ✅ 使用关联数组创建映射
- ✅ 进行高级字符串操作

**📖 详细文档**：[03_data_structures/README.md](../../03_data_structures/README.md)

---

### 阶段 5：文本处理（第 29-42 天）⭐⭐⭐⭐

**目录**：`04_text_processing/` (23 个脚本)

#### 学习路径

**第 29-32 天**：grep（8 个脚本）
- 基础搜索、正则表达式
- 选项、上下文、计数

**第 33-36 天**：sed（7 个脚本）
- 基础、替换、删除
- 插入、打印、文件操作

**第 37-42 天**：awk（8 个脚本）
- 基础、字段操作
- 打印、数学、条件、循环、函数

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_grep/01_grep_basic.sh](../../04_text_processing/01_grep/01_grep_basic.sh) | grep 基础 | ⭐⭐⭐⭐ | 25 分钟 |
| [02_sed/02_sed_replace.sh](../../04_text_processing/02_sed/02_sed_replace.sh) | sed 替换 | ⭐⭐⭐⭐ | 30 分钟 |
| [03_awk/01_awk_basic.sh](../../04_text_processing/03_awk/01_awk_basic.sh) | awk 基础 | ⭐⭐⭐⭐ | 25 分钟 |
| [03_awk/08_awk_advanced.sh](../../04_text_processing/03_awk/08_awk_advanced.sh) | awk 高级 | ⭐⭐⭐⭐⭐ | 40 分钟 |

#### 实战练习

```bash
# 1. grep 搜索
grep -r "error" /var/log/        # 递归搜索
grep -i "warning" app.log        # 忽略大小写
grep -c "ERROR" app.log          # 计数

# 2. sed 替换
sed 's/old/new/g' file.txt       # 全局替换
sed -i 's/foo/bar/g' file.txt    # 原地修改

# 3. awk 分析
awk -F: '{print $1}' /etc/passwd           # 提取用户名
awk '{sum+=$1} END {print sum}' numbers.txt # 求和
awk '$3 > 100 {print $1}' data.txt         # 条件过滤
```

**完成后你将能够**：
- ✅ 搜索和过滤文本（grep）
- ✅ 批量替换文本（sed）
- ✅ 生成格式化报告（awk）

**📖 详细文档**：[04_text_processing/README.md](../../04_text_processing/README.md)

---

### 阶段 6：系统编程（第 43-58 天）⭐⭐⭐⭐

**目录**：`05_system_programming/` (35 个脚本)

#### 学习路径

**第 43-45 天**：Shell 初始化（10 个脚本）
- 变量、选项、内置命令
- 环境变量、profile 配置

**第 46-48 天**：作业控制（7 个脚本）
- bg/fg、jobs、disown
- nohup、PID 管理

**第 49-50 天**：信号处理（5 个脚本）
- 信号列表、捕获、忽略
- 自定义处理、清理

**第 51-53 天**：并发控制（6 个脚本）
- 并行执行、wait
- 互斥锁、信号量

**第 54-58 天**：快捷操作（7 个脚本）
- 快捷命令、别名函数
- 历史、通配符

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_shell_init/05_profile.sh](../../05_system_programming/01_shell_init/05_profile.sh) | profile 配置 | ⭐⭐⭐⭐ | 30 分钟 |
| [02_job_control/04_nohup.sh](../../05_system_programming/02_job_control/04_nohup.sh) | nohup | ⭐⭐⭐⭐ | 25 分钟 |
| [03_signals/02_signal_catch.sh](../../05_system_programming/03_signals/02_signal_catch.sh) | 捕获信号 | ⭐⭐⭐⭐⭐ | 30 分钟 |
| [04_concurrency/01_parallel_exec.sh](../../05_system_programming/04_concurrency/01_parallel_exec.sh) | 并行执行 | ⭐⭐⭐⭐⭐ | 35 分钟 |

#### 实战练习

```bash
# 1. 后台任务
sleep 100 &
jobs -l
kill %1

# 2. 信号处理
trap 'echo "收到中断信号"; exit' INT
while true; do
    echo "运行中..."
    sleep 1
done

# 3. 并行执行
for i in {1..5}; do
    (echo "任务 $i"; sleep 2) &
done
wait
echo "所有任务完成"
```

**完成后你将能够**：
- ✅ 配置 Shell 环境
- ✅ 管理后台任务
- ✅ 捕获和处理信号
- ✅ 并行执行任务

**📖 详细文档**：[05_system_programming/README.md](../../05_system_programming/README.md)

---

### 阶段 7：实战项目（第 59-90 天）⭐⭐⭐⭐⭐

**目录**：`06_real_world/` (49 个脚本)

#### 学习路径

**第 59-62 天**：系统监控（5 个脚本）
- CPU、内存、磁盘 IO、网络、进程

**第 63-66 天**：备份自动化（5 个脚本）
- 增量备份、远程备份、验证、轮转

**第 67-70 天**：日志分析（5 个脚本）
- 日志轮转、错误提取、访问分析

**第 71-75 天**：用户管理（7 个脚本）
- 批量创建、导入导出、密码管理

**第 76-79 天**：部署脚本（5 个脚本）
- 自动部署、回滚、健康检查、蓝绿部署

**第 80-84 天**：网络工具（7 个脚本）
- Ping 监控、DNS 检查、端口扫描

**第 85-88 天**：安全工具（8 个脚本）
- 端口扫描、日志审计、密码生成

**第 89-90 天**：DevOps 工具（21 个脚本）
- Docker、K8s、Jenkins、Ansible 等

#### 重点脚本

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_system_monitor/01_cpu_monitor.sh](../../06_real_world/01_system_monitor/01_cpu_monitor.sh) | CPU 监控 | ⭐⭐⭐⭐ | 25 分钟 |
| [02_backup_automation/01_incremental_backup.sh](../../06_real_world/02_backup_automation/01_incremental_backup.sh) | 增量备份 | ⭐⭐⭐⭐ | 30 分钟 |
| [05_deploy_script/01_auto_deploy.sh](../../06_real_world/05_deploy_script/01_auto_deploy.sh) | 自动部署 | ⭐⭐⭐⭐⭐ | 35 分钟 |
| [08_devops_tools/01_docker_deploy.sh](../../06_real_world/08_devops_tools/01_docker_deploy.sh) | Docker 部署 | ⭐⭐⭐⭐⭐ | 40 分钟 |

#### 毕业项目

**项目 1：系统监控平台**
```bash
# 整合所有监控脚本
source 06_real_world/01_system_monitor/*.sh
cpu_monitor
memory_monitor
disk_io_monitor
network_speed
process_top
```

**项目 2：自动化备份系统**
```bash
# 完整的备份方案
source 06_real_world/02_backup_automation/*.sh
incremental_backup
remote_backup
backup_verify
backup_rotation
```

**项目 3：CI/CD 部署流水线**
```bash
# 自动化部署
source 06_real_world/05_deploy_script/*.sh
auto_deploy
health_check
rollback
blue_green
```

**完成后你将能够**：
- ✅ 编写生产级系统脚本
- ✅ 自动化日常运维任务
- ✅ 构建完整的监控系统
- ✅ 实现 CI/CD 部署流水线

**📖 详细文档**：[06_real_world/README.md](../../06_real_world/README.md)

---

## 🎯 学习建议

### 1. 循序渐进

按照 7 个阶段顺序学习，不要跳级：
- 阶段 1-2：打基础（7 天）
- 阶段 3-4：核心技能（21 天）
- 阶段 5-6：进阶提升（28 天）
- 阶段 7：实战应用（32 天）

### 2. 多动手

- ✅ 每个脚本至少运行 3 遍
- ✅ 尝试修改参数看效果
- ✅ 完成每个章节的练习
- ✅ 记录学习笔记

### 3. 理解原理

- 为什么要这样写？
- 有没有更好的方法？
- 如果...会怎样？

### 4. 实战应用

- 用脚本解决实际问题
- 自动化日常任务
- 参与开源项目

---

## 📚 推荐资源

### 在线教程
- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)

### 练习平台
- [Exercism - Bash](https://exercism.org/tracks/bash)
- [HackerRank - Shell](https://www.hackerrank.com/domains/shell)
- [Codewars - Shell](https://www.codewars.com/?language=shell)

### 书籍
- 《Linux Shell 脚本攻略》
- 《Bash 编程指南》
- 《awk 程序设计语言》

---

## 📖 仓库文档体系

本仓库包含完整的文档体系，帮助你高效学习：

### 核心文档（4 个）

| 文档 | 用途 | 何时阅读 |
|------|------|----------|
| [README.md](../../README.md) | 仓库介绍和快速开始 | 第一次使用仓库 |
| [LEARNING_PATH.md](../../LEARNING_PATH.md) | 90 天学习路径 | 制定学习计划时 |
| [LEARNING_GUIDE.md](LEARNING_GUIDE.md) | 学习指南（本文档） | 学习过程中查阅 |
| [CONTRIBUTING.md](../../CONTRIBUTING.md) | 贡献指南 | 想要贡献代码时 |

### 参考文档（3 个）

| 文档 | 用途 | 何时阅读 |
|------|------|----------|
| [CATALOG.md](../catalog/CATALOG.md) | 脚本完整清单 | 查找特定脚本 |
| [CHEATSHEET.md](../reference/CHEATSHEET.md) | 语法速查表 | 写脚本时查阅 |
| [STATS.md](../reference/STATS.md) | 统计报告 | 了解仓库规模 |

### 支持文档（2 个）

| 文档 | 用途 | 何时阅读 |
|------|------|----------|
| [FAQ.md](../support/FAQ.md) | 常见问题解答 | 遇到问题时 |
| [EXPANSION_PLAN.md](../../EXPANSION_PLAN.md) | 补充计划 | 了解发展历程 |

---

## 📊 仓库统计

| 指标 | 数值 |
|------|------|
| **脚本总数** | **226 个** ✅ |
| **代码行数** | **24,242 行** |
| **学习阶段** | **7 个** |
| **学习天数** | **90 天** |
| **文档数量** | **29 个 MD 文件** |

---

## 🚀 开始学习

1. **克隆仓库**
   ```bash
   git clone https://github.com/hjs2015/shell-notes.git
   cd shell-notes
   ```

2. **阅读 README**
   ```bash
   cat README.md
   ```

3. **运行第一个脚本**
   ```bash
   bash 00_quickstart/01_hello_world.sh
   ```

4. **按照学习路径前进**
   - 第 1 天：00_quickstart/
   - 第 2-7 天：01_basics/
   - 第 8-21 天：02_control_flow/
   - ...

---

**祝你学习愉快！** 🎉

有任何问题，欢迎提 Issue 或 PR！

---

**最后更新**：2026-03-20  
**作者**：hjs2015  
**仓库**：https://github.com/hjs2015/shell-notes  
**版本**：v2.0（226 个脚本完整版）
