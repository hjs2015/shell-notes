# 📚 Shell 编程笔记与实战案例

> 从零基础到实战的完整 Shell 脚本学习资源 | **226 个脚本** + **7 个学习阶段** + **完整学习路径**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Shell Scripts](https://img.shields.io/badge/scripts-226-green.svg)](LEARNING_PATH.md)
[![Stages](https://img.shields.io/badge/stages-7-orange.svg)](LEARNING_PATH.md)
[![Last Commit](https://img.shields.io/github/last-commit/hjs2015/shell-notes/main.svg)](../../commits/main)
[![Issues](https://img.shields.io/github/issues/hjs2015/shell-notes.svg)](../../issues)

---

## 🎯 简介

本仓库包含 **226 个经典脚本案例**，按照 **7 个学习阶段** 科学组织，涵盖从基础语法到实战项目的完整学习路径。所有案例都来自实际运维场景，适合：

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
- 🚀 **完整项目** - 49 个实战项目
- 📚 **学习路径** - 详细的学习计划和检查点

---

## 🗺️ 学习路径

| 阶段 | 名称 | 时间 | 难度 | 目录 | 脚本数 |
|:---:|:---:|:---:|:---:|:---|:---:|
| 1 | 快速开始 | 第 1 天 | ⭐ | `00_quickstart/` | **5** |
| 2 | 基础篇 | 第 2-7 天 | ⭐⭐ | `01_basics/` | **28** |
| 3 | 流程控制 | 第 8-21 天 | ⭐⭐⭐ | `02_control_flow/` | **67** |
| 4 | 数据结构 | 第 22-28 天 | ⭐⭐⭐ | `03_data_structures/` | **19** |
| 5 | 文本处理 | 第 29-42 天 | ⭐⭐⭐⭐ | `04_text_processing/` | **23** |
| 6 | 系统编程 | 第 43-58 天 | ⭐⭐⭐⭐ | `05_system_programming/` | **35** |
| 7 | 实战项目 | 第 59-90 天 | ⭐⭐⭐⭐⭐ | `06_real_world/` | **49** |
| **总计** | **90 天** | **12 周** | **-** | **7 个目录** | **226** ✅ |

**📖 详细学习路径请查看**: [LEARNING_PATH.md](LEARNING_PATH.md)

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

## 📚 文档导航

本仓库包含 **8 个核心文档**，分类清晰，快速查找：

| 类别 | 文档 | 说明 | 适合人群 |
|------|------|------|----------|
| **🗺️ 学习路径** | [LEARNING_PATH.md](LEARNING_PATH.md) | 90 天详细学习路径 | 👶 新手 |
| **📚 学习指南** | [docs/guides/LEARNING_GUIDE.md](docs/guides/LEARNING_GUIDE.md) | 7 阶段详解 +21 个练习 | 👶 新手 |
| **📖 完全指南** | [docs/guides/SHELL_GUIDE.md](docs/guides/SHELL_GUIDE.md) | 226 个脚本详解 | 📖 所有阶段 |
| **📋 脚本清单** | [docs/catalog/CATALOG.md](docs/catalog/CATALOG.md) | 完整目录 | 🔍 查找脚本 |
| **🔖 语法速查** | [docs/reference/CHEATSHEET.md](docs/reference/CHEATSHEET.md) | 200+ 命令速查 | ⚡ 日常开发 |
| **❓ 常见问题** | [docs/support/FAQ.md](docs/support/FAQ.md) | 20+ 个问题解答 | 🛠️ 遇到问题 |
| **🤝 贡献指南** | [CONTRIBUTING.md](CONTRIBUTING.md) | 代码规范、提交流程 | 👨‍💻 贡献者 |

**👉 完整文档索引**: [docs/README.md](docs/README.md)

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
├── docs/                   # 📚 文档中心
│   ├── catalog/            # 📋 脚本清单
│   ├── guides/             # 📚 学习指南
│   ├── reference/          # 🔖 快速参考
│   ├── support/            # ❓ 支持文档
│   └── archive/            # 🗄️ 历史文档
├── README.md               # 🏠 项目介绍
├── LEARNING_PATH.md        # 🗺️ 学习路径
└── CONTRIBUTING.md         # 🤝 贡献指南
```

---

## 📊 统计信息

| 指标 | 数量 |
|------|------|
| **总脚本数** | **226 个** ✅ |
| **代码行数** | **24,242 行** |
| **学习阶段** | **7 个** |
| **学习天数** | **90 天** |
| **子目录** | **7 个** |
| **实战项目** | **49 个** |
| **核心文档** | **8 个** |

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

[开始学习](LEARNING_PATH.md) | [查看文档](docs/README.md) | [贡献指南](CONTRIBUTING.md)
