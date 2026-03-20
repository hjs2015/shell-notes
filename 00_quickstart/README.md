# 🚀 快速开始 (Quick Start)

> **学习第 1 天** | 难度：⭐ | 5 个脚本

---

## 📖 简介

这是 Shell 编程的**第一个目录**，帮助你快速体验 Shell 脚本的魅力。

**目标**：
- ✅ 运行第一个 Shell 脚本
- ✅ 理解特殊变量的用途
- ✅ 掌握基本通配符

**预计时间**：1-2 小时

---

## 📁 脚本清单

| 脚本 | 名称 | 难度 | 时间 |
|------|------|------|------|
| [01_hello_world.sh](01_hello_world.sh) | Hello World | ⭐ | 10 分钟 |
| [02_special_variables.sh](02_special_variables.sh) | 特殊变量 | ⭐ | 30 分钟 |
| [03_wildcards_and_echo.sh](03_wildcards_and_echo.sh) | 通配符 | ⭐ | 15 分钟 |
| [04_shell_environment_check.sh](04_shell_environment_check.sh) | 环境检测 | ⭐ | 20 分钟 |
| [05_script_execution_methods.sh](05_script_execution_methods.sh) | 执行方式 | ⭐ | 25 分钟 |

---

## 🎯 学习目标

完成本阶段后，你将能够：

- ✅ 创建并运行 Shell 脚本
- ✅ 理解 `$0`, `$1`, `$@`, `$*` 等特殊变量
- ✅ 使用通配符 (`*`, `?`, `[]`) 匹配文件
- ✅ 使用 `echo` 和 `printf` 输出信息
- ✅ 检测 Shell 环境和系统信息
- ✅ 掌握脚本的各种执行方式及其区别

---

## 📝 学习步骤

### 1. Hello World (10 分钟)

```bash
# 查看脚本
cat 01_hello_world.sh

# 运行脚本
./01_hello_world.sh

# 输出：
# Hello World!
```

**知识点**：
- Shebang (`#!/bin/bash`)
- 执行权限 (`chmod +x`)
- 基本输出 (`echo`)

---

### 2. 特殊变量 (30 分钟)

```bash
# 查看脚本
cat 02_special_variables.sh

# 运行脚本（带参数）
./02_special_variables.sh arg1 arg2 arg3

# 输出：
# 脚本名：./02_special_variables.sh
# 第 1 个参数：arg1
# 第 2 个参数：arg2
# 所有参数：arg1 arg2 arg3
```

**知识点**：
- `$0` - 脚本名
- `$1`, `$2`, `$3` - 位置参数
- `$#` - 参数个数
- `$@`, `$*` - 所有参数

---

### 3. 用户问候 (15 分钟)

```bash
# 查看脚本
cat 03_user_greeting.sh

# 运行脚本
./03_user_greeting.sh

# 输出：
# 你好，root！欢迎学习 Shell 编程。
# 今天是：2026-03-20 星期五
```

**知识点**：
- 环境变量 (`$USER`, `$HOME`)
- 命令替换 (`$(date)`)
- 条件判断

---

### 4. Shell 环境检测 (20 分钟) ⭐ 新增

```bash
# 查看脚本
cat 04_shell_environment_check.sh

# 运行脚本
bash 04_shell_environment_check.sh

# 输出：
# ========================================
# Shell 环境检测报告
# ========================================
# 操作系统：Linux Ubuntu 22.04
# Shell 类型：bash
# Shell 版本：5.1.16(1)-release
# ...
```

**知识点**：
- 系统信息检测 (`uname`, `hostname`)
- Shell 版本识别
- 环境变量检查
- 函数封装与组织

**命令行选项**：
- `-h, --help` - 显示帮助
- `-q, --quick` - 快速检查
- `-t, --tips` - 故障排查建议

---

### 5. 脚本执行方式详解 (25 分钟) ⭐ 新增

```bash
# 查看脚本
cat 05_script_execution_methods.sh

# 运行脚本
bash 05_script_execution_methods.sh

# 输出：
# ========================================
# 脚本执行权限与运行方式详解
# ========================================
# 【演示 1】检查脚本执行权限
# 【演示 2】不同执行方式对比
# ...
```

**知识点**：
- 执行权限检查 (`chmod +x`)
- 5 种执行方式对比（bash/./source/sh/exec）
- shebang 行规范
- 常见错误与解决方案

**演示内容**：
- 权限检查
- 执行方式对比
- 路径运行方式
- shebang 规范
- 常见错误排查

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 创建并运行一个简单的 Shell 脚本
- [ ] 解释 `$0`, `$1`, `$#` 的含义
- [ ] 使用 `*` 和 `?` 匹配文件
- [ ] 使用 `echo` 和 `printf` 输出信息
- [ ] 检测当前 Shell 环境和系统信息
- [ ] 说明 bash、./、source 三种执行方式的区别

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[01_basics/](../01_basics/)** - 基础篇（第 2-7 天）

你将学习：
- 变量定义和操作
- 算术和逻辑运算
- 用户输入和格式化输出

---

## 💡 小贴士

1. **多动手** - 每个脚本都要亲自运行
2. **修改代码** - 尝试修改参数看效果
3. **做笔记** - 记录特殊变量的用途
4. **遇到问题** - 查看 [FAQ](../appendices/faq.md)

---

## 📚 参考资源

- [Bash 特殊变量详解](https://www.gnu.org/software/bash/manual/)
- [通配符使用指南](https://www.runoob.com/linux/linux-shell.html)
- [快速参考手册](../appendices/cheatsheet.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-学习步骤) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)
