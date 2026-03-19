# 📚 Shell 编程笔记与实战案例

> 从零基础到实战的完整 Shell 脚本学习资源 | **100 个脚本** + **7 个学习阶段** + **完整学习路径**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Shell Scripts](https://img.shields.io/badge/scripts-100-green.svg)](LEARNING_PATH.md)
[![Stages](https://img.shields.io/badge/stages-7-orange.svg)](LEARNING_PATH.md)
[![Last Commit](https://img.shields.io/github/last-commit/hjs2015/shell-notes/main.svg)](../../commits/main)
[![Issues](https://img.shields.io/github/issues/hjs2015/shell-notes.svg)](../../issues)

---

## 🎯 简介

本仓库包含 **100 个经典脚本案例**，按照 **7 个学习阶段** 科学组织，涵盖从基础语法到实战项目的完整学习路径。所有案例都来自实际运维场景，适合：

- ✅ Shell 编程初学者
- ✅ 需要提升脚本能力的开发者
- ✅ Linux 系统管理员
- ✅ DevOps 工程师
- ✅ 计算机专业学生

### ✨ 特色

- 📝 **详细注释** - 每个脚本都有完整的中文注释
- 🎓 **循序渐进** - 7 个阶段从入门到实战
- 💼 **实战导向** - 所有案例来自真实运维场景
- 📊 **难度分级** - ⭐ 入门 到 ⭐⭐⭐⭐⭐ 专家
- 🔧 **开箱即用** - 克隆即可运行，无需配置
- 🚀 **完整项目** - 24 个实战项目
- 📚 **学习路径** - 详细的学习计划和检查点

---

## 🗺️ 学习路径

```
第 1 天      第 2-7 天     第 8-21 天    第 22-28 天   第 29-42 天   第 43-58 天   第 59-90 天
  ↓           ↓           ↓           ↓           ↓           ↓           ↓
快速开始  →  基础篇  →  流程控制  →  数据结构  →  文本处理  →  系统编程  →  实战项目
  ⭐          ⭐⭐         ⭐⭐⭐        ⭐⭐⭐        ⭐⭐⭐⭐       ⭐⭐⭐⭐       ⭐⭐⭐⭐⭐
  1 天        1 周        2 周        1 周        2 周        2 周        4 周
  3 脚本      12 脚本      44 脚本      4 脚本      3 脚本      10 脚本      24 脚本
```

**📖 详细学习路径请查看**: [LEARNING_PATH.md](LEARNING_PATH.md)

---

## 📁 目录结构

### 🚀 阶段 1: 快速开始 (第 1 天)
```
00_quickstart/          (3 个脚本) ⭐
├── 01_hello_world.sh
├── 02_special_variables.sh
└── 05_wildcards_and_echo.sh
```

### 📚 阶段 2: 基础篇 (第 2-7 天)
```
01_basics/              (12 个脚本) ⭐⭐
├── 01_variables/       # 变量定义 (5 个)
├── 02_operators/       # 运算符 (4 个)
└── 03_io/              # 输入输出 (3 个)
```

### 🔄 阶段 3: 流程控制 (第 8-21 天)
```
02_control_flow/        (44 个脚本) ⭐⭐⭐
├── 01_condition/       # 条件判断 (7 个)
├── 02_loops/           # 循环结构 (22 个)
├── 03_case/            # 选择结构 (12 个)
└── 04_functions/       # 函数定义 (4 个)
```

### 🗂️ 阶段 4: 数据结构 (第 22-28 天)
```
03_data_structures/     (4 个脚本) ⭐⭐⭐
├── 01_indexed_arrays/  # 索引数组 (2 个)
├── 02_associative_arrays/ # 关联数组 (1 个)
└── 03_strings/         # 字符串操作 (1 个)
```

### 📝 阶段 5: 文本处理 (第 29-42 天)
```
04_text_processing/     (6 个脚本) ⭐⭐⭐⭐
├── 01_grep/            # grep 搜索 (1 个)
├── 02_sed/             # sed 编辑 (1 个)
└── 03_awk/             # awk 分析 (4 个)
```

### ⚙️ 阶段 6: 系统编程 (第 43-58 天)
```
05_system_programming/  (10 个脚本) ⭐⭐⭐⭐
├── 01_shell_init/      # Shell 初始化 (4 个)
├── 02_job_control/     # 作业控制 (2 个)
├── 04_concurrency/     # 并发控制 (2 个)
└── 05_shortcuts/       # 快捷键 (2 个文档)
```

### 🚀 阶段 7: 实战项目 (第 59-90 天)
```
06_real_world/          (24 个脚本) ⭐⭐⭐⭐⭐
├── 07_security_tools/  # 安全工具 (3 个)
└── 08_devops_tools/    # DevOps 工具 (21 个)
```

### 📖 文档
```
appendices/
├── cheatsheet.md       # 快速参考
├── faq.md              # 常见问题
└── resources.md        # 学习资源
```

---

## 📖 文档导航

### 核心文档（根目录）
| 文档 | 说明 |
|------|------|
| [README.md](README.md) | 🏠 项目介绍和快速开始 |
| [LEARNING_PATH.md](LEARNING_PATH.md) | 🗺️ 90 天学习路径 |
| [CONTRIBUTING.md](CONTRIBUTING.md) | 🤝 贡献指南 |

### 完整文档库（docs/）
| 类别 | 文档 |
|------|------|
| 📋 脚本清单 | [docs/catalog/CATALOG.md](docs/catalog/CATALOG.md) |
| 📖 快速参考 | [docs/reference/CHEATSHEET.md](docs/reference/CHEATSHEET.md) |
| 📚 学习指南 | [docs/guides/LEARNING_GUIDE.md](docs/guides/LEARNING_GUIDE.md) |
| ❓ 常见问题 | [docs/support/FAQ.md](docs/support/FAQ.md) |
| 🗄️ 历史文档 | [docs/archive/](docs/archive/) |

👉 **访问 [docs/README.md](docs/README.md) 查看完整文档索引**

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/hjs2015/shell-notes.git
cd shell-notes
```

### 2. 运行第一个脚本

```bash
# 给脚本添加执行权限
chmod +x 00_quickstart/01_hello_world.sh

# 运行脚本
./00_quickstart/01_hello_world.sh

# 输出：
# Hello World!
```

### 3. 开始学习

按照 [LEARNING_PATH.md](LEARNING_PATH.md) 的顺序学习：

```bash
# 第 1 天：快速开始
cd 00_quickstart
./01_hello_world.sh
./02_special_variables.sh

# 第 2-7 天：基础篇
cd ../01_basics/01_variables
ls
```

---

## 📊 统计信息

| 指标 | 数量 |
|------|------|
| **总脚本数** | 100 个 |
| **代码行数** | 19,124 行 |
| **学习阶段** | 7 个 |
| **子目录** | 25 个 |
| **文档数** | 10+ 个 |
| **实战项目** | 24 个 |
| **预计学习时间** | 90 天 |

---

## 🎓 学习建议

### ✅ 推荐做法
1. **按顺序学习** - 每个阶段建立在前一阶段基础上
2. **动手实践** - 每个脚本都要亲自运行和修改
3. **做笔记** - 记录关键知识点和心得
4. **完成练习** - 每个阶段后的练习项目必做
5. **重复练习** - 不理解的地方多看多练

### ❌ 避免做法
1. **跳过基础** - 基础不牢，地动山摇
2. **只看不练** - 编程是实践技能
3. **死记硬背** - 理解原理更重要
4. **急于求成** - 循序渐进效果最好

---

## 📖 文档导航

| 文档 | 说明 |
|------|------|
| [LEARNING_PATH.md](LEARNING_PATH.md) | 📚 详细学习路径和计划 |
| [CATALOG.md](CATALOG.md) | 📋 完整脚本清单 |
| [CHEATSHEET.md](CHEATSHEET.md) | 🔖 快速参考手册 |
| [FAQ.md](FAQ.md) | ❓ 常见问题解答 |
| [CONTRIBUTING.md](CONTRIBUTING.md) | 🤝 贡献指南 |
| [REORGANIZATION_PLAN.md](REORGANIZATION_PLAN.md) | 🏗️ 目录重组说明 |

---

## 🏆 学习成果

完成所有阶段后，你将能够:

### ✅ 基础能力
- 编写 100-500 行的 Shell 脚本
- 使用所有基本语法结构
- 进行文本处理和数据分析

### ✅ 进阶能力
- 开发系统管理工具
- 自动化日常任务
- 解决实际问题

### ✅ 实战能力
- 独立开发完整项目
- 编写生产级代码
- 遵循最佳实践

---

## 📅 更新日志

### 2026-03-19 - 第七轮优化完成 🎉
- ✅ 目录结构重组 - 7 个学习阶段
- ✅ 新增学习路径文档
- ✅ 总脚本数突破 100 个
- ✅ 知识点覆盖达 97%

### 2026-03-18 - 第六轮优化完成
- ✅ 新增 12 个系统管理脚本
- ✅ 完善文本处理三剑客

### 2026-03-17 - 第五轮优化完成
- ✅ 新增 DevOps 实战脚本
- ✅ 完善安全规范

---

## 🤝 参与贡献

欢迎贡献代码、文档或建议！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解如何参与。

### 贡献方式
- 🐛 报告 Bug
- 💡 提出新功能建议
- 📝 改进文档
- 🔧 提交新脚本
- ✨ 优化现有代码

---

## 📜 许可证

本仓库采用 [MIT 许可证](LICENSE) - 自由使用、修改和分发。

---

## 🙏 致谢

感谢所有为本项目做出贡献的开发者！

特别感谢：
- cnblogs Shell 指南 - 技术参考
- Bash 官方文档 - 权威资料
- 社区贡献者 - 代码和建议

---

## 📮 联系方式

- **GitHub**: https://github.com/hjs2015/shell-notes
- **Issues**: https://github.com/hjs2015/shell-notes/issues
- **作者**: hjs

---

**祝你学习顺利！** 🚀

[开始学习](LEARNING_PATH.md) | [查看脚本清单](CATALOG.md) | [快速参考](CHEATSHEET.md)
