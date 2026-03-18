# 📚 Shell 编程笔记与实战案例

> 从零基础到实战的完整 Shell 脚本学习资源

## 🎯 简介

本仓库包含 **45 个经典 Shell 脚本案例** 和 **3 个 awk 脚本**，涵盖从基础语法到综合实战的完整学习路径。所有案例都来自实际运维场景，适合 Shell 编程初学者和需要提升脚本能力的开发者。

## 📁 目录结构

```
shell-notes/
├── 01_basic/           # 基础输出 (2 个脚本)
├── 02_input/           # 交互式输入 (5 个脚本)
├── 03_condition/       # 条件判断 (4 个脚本)
├── 04_loop/            # 循环结构 (18 个脚本)
├── 05_case/            # 选择结构 (12 个脚本)
├── 06_text/            # 文本处理 (教程+awk 脚本)
├── 07_system/          # 系统管理 (1 个脚本)
├── 08_practice/        # 综合练习 (3 个脚本)
├── README.md           # 本文件
├── CATALOG.md          # 脚本详细清单
├── LEARNING_GUIDE.md   # 学习指南
└── STATS.md            # 统计报告
```

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/hjs2015/shell-notes.git
cd shell-notes
```

### 2. 运行第一个脚本

```bash
# 给脚本添加执行权限
chmod +x 01_basic/01_hello_world.sh

# 运行脚本
./01_basic/01_hello_world.sh
```

### 3. 学习路径

推荐按以下顺序学习：

1. **基础阶段** (2-3 天)
   - `01_basic/` - Hello World 和特殊变量
   - `02_input/` - read 命令和用户交互
   - `03_condition/` - if 条件判断

2. **进阶阶段** (3-5 天)
   - `04_loop/` - for/while/until 循环
   - `05_case/` - case 选择结构

3. **高级阶段** (2-3 天)
   - `06_text/` - awk 文本处理
   - `07_system/` - 系统管理脚本

4. **实战阶段** (2-3 天)
   - `08_practice/` - 用户管理系统

## 📖 核心知识点

### 基础语法

| 主题 | 文件示例 | 说明 |
|------|----------|------|
| Hello World | `01_basic/01_hello_world.sh` | 第一个脚本 |
| 变量 | `01_basic/02_special_variables.sh` | 特殊变量 $0, $1, $$ 等 |
| 输入 | `02_input/01_name_phone_age.sh` | read -p, -s, -n, -t |

### 流程控制

| 主题 | 文件示例 | 说明 |
|------|----------|------|
| if 判断 | `03_condition/02_file_type_check.sh` | 文件类型判断 |
| for 循环 | `04_loop/04_for_loop_basic.sh` | for in, seq, 大括号展开 |
| while 循环 | `04_loop/08_guess_number_game.sh` | 猜数字游戏 |
| case 选择 | `05_case/01_char_type_check.sh` | 字符类型判断 |

### 实用技巧

| 主题 | 文件示例 | 说明 |
|------|----------|------|
| 文本处理 | `06_text/shell04.txt` | awk 基础教程 |
| 日志轮转 | `07_system/01_log_rotation.sh` | date, mkdir, mv, mail |
| 用户注册 | `08_practice/02_user_register.sh` | 密码隐藏输入 |
| 用户登录 | `08_practice/03_user_login.sh` | 验证码、限时输入 |

## 🎮 趣味项目

- **猜数字游戏** - `04_loop/08_guess_number_game.sh`
- **99 乘法表** - `04_loop/02_multiplication_table.sh`
- **幸运抽奖** - `04_loop/17_lucky_draw.sh`
- **俄罗斯方块** - `05_case/12_tetris_game.sh` (完整游戏！)

## 📚 学习资源

### 推荐教程

- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)

### 练习平台

- [Exercism - Bash](https://exercism.org/tracks/bash)
- [HackerRank - Shell](https://www.hackerrank.com/domains/shell)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 👤 作者

- **GitHub**: [@hjs2015](https://github.com/hjs2015)
- **学校**: Xiangtan University

---

**祝你学习愉快！** 🎉
