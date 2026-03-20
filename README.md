# 🐚 Shell 编程笔记与实战案例

> **226 个脚本** | **7 个学习阶段** | **90 天学习计划** | **24,242 行代码**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Scripts](https://img.shields.io/badge/scripts-226-green.svg)](#学习路径)
[![Lines](https://img.shields.io/badge/lines-24242-orange.svg)](#统计)
[![Stages](https://img.shields.io/badge/stages-7-red.svg)](#学习路径)

---

## 🎯 简介

**226 个 Shell 脚本实战案例**，从基础语法到运维实战，循序渐进掌握 Shell 编程。

**适合人群**：
- 🐧 Linux 系统管理员
- ⚙️ DevOps 工程师
- 💻 开发者（提升自动化能力）
- 📚 Shell 初学者

**核心特色**：
- ✅ **中文全注释** - 每个脚本都有详细注释
- ✅ **难度分级** - ⭐入门 → ⭐⭐⭐⭐⭐专家
- ✅ **实战导向** - 来自真实运维场景
- ✅ **开箱即用** - 克隆即可运行

---

## 🗺️ 学习路径（90 天）

| 阶段 | 名称 | 时间 | 难度 | 脚本 | 核心内容 |
|:---:|:---|:---:|:---:|:---:|:---|
| 1 | 快速开始 | 第 1 天 | ⭐ | 5 | Hello World、权限、执行方式 |
| 2 | 基础篇 | 第 2-7 天 | ⭐⭐ | 28 | 变量、运算符、输入输出 |
| 3 | 流程控制 | 第 8-21 天 | ⭐⭐⭐ | 67 | if/for/while/case、函数 |
| 4 | 数据结构 | 第 22-28 天 | ⭐⭐⭐ | 19 | 字符串、数组、管道 |
| 5 | 文本处理 | 第 29-42 天 | ⭐⭐⭐⭐ | 23 | grep/sed/awk/cut/sort |
| 6 | 系统编程 | 第 43-58 天 | ⭐⭐⭐⭐ | 35 | 进程、信号、文件锁 |
| 7 | 实战项目 | 第 59-90 天 | ⭐⭐⭐⭐⭐ | 49 | 监控、备份、部署、安全 |
| **总计** | **90 天** | **12 周** | **-** | **226** ✅ | **完整体系** |

---

## 🚀 快速开始

### 1. 克隆仓库
```bash
git clone https://github.com/hjs2015/shell-notes.git
cd shell-notes
```

### 2. 运行第一个脚本
```bash
chmod +x 00_quickstart/01_hello_world.sh
./00_quickstart/01_hello_world.sh
```

### 3. 开始学习
从 `00_quickstart/` 开始，按照学习路径循序渐进。

---

## 📚 核心文档

| 文档 | 说明 | 适合 |
|------|------|------|
| [📖 SHELL_GUIDE.md](SHELL_GUIDE.md) | 完整学习指南（226 个脚本详解 + 90 天计划） | 系统学习 |
| [📋 SHELL_GUIDE_BASE.md](SHELL_GUIDE_BASE.md) | 基础速查表（特殊变量/运算符/命令） | 写脚本时查阅 |

**学习路线**：README → 开始学习 → SHELL_GUIDE → SHELL_GUIDE_BASE（速查）

---

## 📁 目录结构

```
shell-notes/
├── 00_quickstart/          # 阶段 1: 快速开始 (5 个脚本) ⭐
├── 01_basics/              # 阶段 2: 基础篇 (28 个脚本) ⭐⭐
├── 02_control_flow/        # 阶段 3: 流程控制 (67 个脚本) ⭐⭐⭐
├── 03_data_structures/     # 阶段 4: 数据结构 (19 个脚本) ⭐⭐⭐
├── 04_text_processing/     # 阶段 5: 文本处理 (23 个脚本) ⭐⭐⭐⭐
├── 05_system_programming/  # 阶段 6: 系统编程 (35 个脚本) ⭐⭐⭐⭐
├── 06_real_world/          # 阶段 7: 实战项目 (49 个脚本) ⭐⭐⭐⭐⭐
├── README.md               # 🏠 项目介绍
├── SHELL_GUIDE.md          # 📖 完整学习指南
└── SHELL_GUIDE_BASE.md     # 📋 基础速查表
```

---

## 📊 统计

| 指标 | 数量 |
|------|------|
| **总脚本数** | **226 个** ✅ |
| **代码行数** | **24,242 行** |
| **学习阶段** | **7 个** |
| **学习天数** | **90 天** |
| **实战项目** | **49 个** |
| **平均脚本行数** | **107 行** |
| **最长脚本** | **~500 行** |
| **最短脚本** | **~10 行** |

---

## 💡 学习建议

### 新手（0 基础）
1. 从 `00_quickstart/` 开始
2. 每天 1-2 个脚本
3. 先理解，再模仿，最后自己写
4. 遇到语法问题查阅 `SHELL_GUIDE_BASE.md`

### 进阶（有基础）
1. 直接挑战 `04_text_processing/` 和 `05_system_programming/`
2. 重点学习实战项目
3. 参考脚本优化自己的工作脚本

### 高手
1. 贡献代码，优化现有脚本
2. 分享实战经验
3. 帮助新手解决问题

---

## 🤝 参与贡献

欢迎提交 Issue、PR 或建议！

- 🐛 发现 Bug？提交 Issue
- 💡 有好想法？提 PR
- 📝 想改进文档？欢迎贡献

---

## 📜 许可证

[MIT 许可证](LICENSE) - 自由使用、修改和分发。

---

**开始你的 Shell 编程之旅！** 🚀

**仓库地址**：https://github.com/hjs2015/shell-notes
