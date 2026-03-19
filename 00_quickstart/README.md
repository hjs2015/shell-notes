# 🚀 快速开始 (Quick Start)

> **学习第 1 天** | 难度：⭐ | 3 个脚本

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
| [05_wildcards_and_echo.sh](05_wildcards_and_echo.sh) | 通配符 | ⭐ | 20 分钟 |

---

## 🎯 学习目标

完成本阶段后，你将能够：

- ✅ 创建并运行 Shell 脚本
- ✅ 理解 `$0`, `$1`, `$@`, `$*` 等特殊变量
- ✅ 使用通配符 (`*`, `?`, `[]`) 匹配文件
- ✅ 使用 `echo` 和 `printf` 输出信息

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

### 3. 通配符 (20 分钟)

```bash
# 查看脚本
cat 05_wildcards_and_echo.sh

# 运行脚本
./05_wildcards_and_echo.sh

# 输出：
# *.sh 文件：01_hello_world.sh 02_special_variables.sh ...
# ?.txt 文件：a.txt b.txt c.txt
```

**知识点**：
- `*` - 匹配任意字符
- `?` - 匹配单个字符
- `[]` - 匹配字符范围

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 创建并运行一个简单的 Shell 脚本
- [ ] 解释 `$0`, `$1`, `$#` 的含义
- [ ] 使用 `*` 和 `?` 匹配文件
- [ ] 使用 `echo` 和 `printf` 输出信息

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
