# Shell 编程笔记与实战案例

> 系统性学习 Shell 编程，从基础到实战，51 个经典脚本案例

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Updated](https://img.shields.io/badge/updated-2026--03--18-orange.svg)]()

## 📖 简介

本仓库是 Shell 编程学习的完整笔记和实战案例集合，包含：
- **51 个经典脚本** - 覆盖 Shell 编程所有核心知识点
- **8 大主题分类** - 从基础到实战，循序渐进
- **详细注释** - 每个脚本都有清晰的说明和示例
- **实战导向** - 所有案例都来自实际运维场景

## 📁 目录结构

```
shell-notes/
├── 01_basic/           # 基础输出 (2 个脚本)
├── 02_input/           # 交互式输入 (5 个脚本)
├── 03_condition/       # 条件判断 (4 个脚本)
├── 04_loop/            # 循环结构 (20 个脚本)
├── 05_case/            # 选择结构 (12 个脚本)
├── 06_text/            # 文本处理 (教程 + awk 脚本)
├── 07_system/          # 系统管理 (1 个脚本)
├── 08_practice/        # 综合练习 (3 个脚本)
├── scripts_index.md    # 脚本分类索引
└── README.md           # 本文件
```

## 🎯 学习路径

### 初级阶段 (⭐)
适合零基础初学者，掌握 Shell 基础语法

| 主题 | 脚本数 | 核心知识点 |
|------|--------|------------|
| [01_basic](01_basic/) | 2 | echo, 特殊变量 |
| [02_input](02_input/) | 5 | read, 用户交互 |
| [03_condition](03_condition/) | 4 | if, 文件测试 |

**预计时间**: 2-3 天

### 中级阶段 (⭐⭐)
掌握流程控制，能编写简单脚本

| 主题 | 脚本数 | 核心知识点 |
|------|--------|------------|
| [04_loop](04_loop/) | 20 | for, while, until |
| [05_case](05_case/) | 12 | case, select |

**预计时间**: 3-5 天

### 高级阶段 (⭐⭐⭐)
文本处理和系统管理实战

| 主题 | 脚本数 | 核心知识点 |
|------|--------|------------|
| [06_text](06_text/) | 教程 + 示例 | grep, awk, sed |
| [07_system](07_system/) | 1 | 日志轮转，邮件 |
| [08_practice](08_practice/) | 3 | 综合应用 |

**预计时间**: 5-7 天

## 🚀 快速开始

### 环境准备
```bash
# 确保有 Bash
bash --version

# 克隆仓库
git clone https://github.com/hjs2015/shell-notes.git
cd shell-notes
```

### 运行第一个脚本
```bash
# 进入基础目录
cd 01_basic

# 运行 Hello World
bash 1.shell

# 查看特殊变量
bash 5.shell arg1 arg2 arg3
```

### 练习建议
1. **先读代码** - 理解每行的作用
2. **手动运行** - 观察输出结果
3. **修改测试** - 尝试修改参数看变化
4. **自己写** - 不看代码，自己实现类似功能

## 📊 脚本统计

| 分类 | 脚本数 | 难度 | 核心技能 |
|------|--------|------|----------|
| 基础输出 | 2 | ⭐ | echo, 变量 |
| 交互式输入 | 5 | ⭐⭐ | read, 验证 |
| 条件判断 | 4 | ⭐⭐ | if, 测试 |
| 循环结构 | 20 | ⭐⭐⭐ | for, while |
| 选择结构 | 12 | ⭐⭐⭐ | case, select |
| 文本处理 | 教程 | ⭐⭐⭐⭐ | awk, grep |
| 系统管理 | 1 | ⭐⭐⭐⭐ | mail, logger |
| 综合练习 | 3 | ⭐⭐⭐⭐⭐ | 综合应用 |
| **总计** | **51** | - | - |

## 💡 经典案例

### 1. 用户登录系统 (08_practice/18.shell)
```bash
# 功能：带验证码的完整登录系统
# 知识点：函数、验证码、超时、认证
bash 08_practice/18.shell
```

### 2. 日志轮转 (07_system/3.shell)
```bash
# 功能：自动备份日志并发送通知
# 知识点：date, mkdir, mail, logger
# 应用：生产环境日志管理
```

### 3. 99 乘法表 (04_loop/11.shell)
```bash
# 功能：打印 99 乘法表
# 知识点：嵌套循环、格式化输出
bash 04_loop/11.shell
```

### 4. 文件类型判断 (03_condition/9.shell)
```bash
# 功能：判断文件类型 (目录、链接、设备等)
# 知识点：if/elif、文件测试操作符
bash 03_condition/9.shell
```

## 📚 学习资源

### 在线文档
- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [awk 用户指南](https://www.gnu.org/software/gawk/manual/)

### 推荐书籍
- 《Linux Shell 脚本攻略》
- 《Bash 编程指南》
- 《awk 程序设计语言》

### 练习平台
- [Exercism - Bash Track](https://exercism.org/tracks/bash)
- [HackerRank - Shell](https://www.hackerrank.com/domains/shell)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 👤 作者

- **hjs2015** - [GitHub](https://github.com/hjs2015)
- 学校：Xiangtan University

## 📅 更新日志

- **2026-03-18** - 重新整理仓库，添加详细分类和说明
- **2026-03-17** - 初始版本，51 个脚本案例

---

**Happy Coding!** 🎉
