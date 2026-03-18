# Shell 脚本分类索引

## 📁 目录结构

| 分类 | 目录 | 脚本数 | 知识点 |
|------|------|--------|--------|
| 基础输出 | `01_basic/` | 2 | echo, printf |
| 交互式输入 | `02_input/` | 5 | read, 变量 |
| 条件判断 | `03_condition/` | 8 | if, else, elif, 文件测试 |
| 循环结构 | `04_loop/` | 20 | for, while, until |
| 选择结构 | `05_case/` | 12 | case, select |
| 文本处理 | `06_text/` | 2 | grep, awk, sed, cut |
| 系统管理 | `07_system/` | 2 | mail, logger, 日志轮转 |
| 综合练习 | `08_practice/` | - | 综合应用 |

---

## 📝 脚本详细列表

### 01_basic - 基础输出

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `1.shell` | 基础 echo 输出 | echo |
| `5.shell` | Shell 特殊变量 ($0, $1, $$, $#, $*, $@) | 变量 |

### 02_input - 交互式输入

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `2.shell` | read 输入 (名字、手机号、年龄) | read -p, -s, -n, -t |
| `4.shell` | 笔记查找工具 | read, cd, grep |
| `6.shell` | 文件存在性检查 | read, if -e |
| `8.shell` | IP 连通性检查 | read, ping |
| `12.shell` | 用户信息输入 (姓名、性别、年龄) | read, while, if |

### 03_condition - 条件判断

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `7.shell` | 逻辑运算 (-o, !) | if, -o, ! |
| `9.shell` | 文件类型判断 | if, -L, -d, -S, -p, -c, -b |
| `10.shell` | 文件权限判断 | if, -r, -w, -x |
| `11.shell` | 死链接判断 | if, -L, -e |

### 04_loop - 循环结构

(从 shell02 目录整理，共 20 个脚本)

### 05_case - 选择结构

(从 shell03 目录整理，共 12 个脚本)

### 06_text - 文本处理

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `13.shell` | 网络检查脚本 | grep, cut, awk |
| `14.shell` | 笔记查找工具 (参数版) | if, case, grep |

### 07_system - 系统管理

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `3.shell` | 日志轮转脚本 | date, mkdir, mv, mail, logger |

### 08_practice - 综合练习

| 文件 | 描述 | 知识点 |
|------|------|--------|
| `17.shell` | 用户注册系统 | read, if, 密码验证 |
| `18.shell` | 完整用户登录系统 | 函数，验证码，登录 |
| `19.shell` | 用户注册与登录 | 综合应用 |

---

## 🎯 学习路径

### 初级 (⭐)
1. `01_basic/1.shell` - Hello World
2. `01_basic/5.shell` - 特殊变量
3. `02_input/2.shell` - read 输入

### 中级 (⭐⭐)
1. `03_condition/7.shell` - 逻辑运算
2. `03_condition/9.shell` - 文件类型判断
3. `03_condition/10.shell` - 文件权限判断

### 高级 (⭐⭐⭐)
1. `07_system/3.shell` - 日志轮转
2. `08_practice/17.shell` - 用户注册
3. `08_practice/18.shell` - 登录系统

---

**最后更新**: 2026-03-18  
**作者**: hjs2015
