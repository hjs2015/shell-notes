# Shell 脚本分类索引

> 按知识点分类的脚本索引 | 55 个脚本 + 9 个目录 README

## 📁 目录结构

| 分类 | 目录 | 脚本数 | README | 难度 | 知识点 |
|------|------|--------|--------|------|--------|
| 基础输出 | `01_basic/` | 2 | ✅ | ⭐ | echo, printf, 特殊变量 |
| 交互式输入 | `02_input/` | 5 | ✅ | ⭐⭐ | read, 输入验证，文件检查 |
| 条件判断 | `03_condition/` | 4 | ✅ | ⭐⭐ | if/else, 逻辑运算，文件测试 |
| 循环结构 | `04_loop/` | 20 | ✅ | ⭐⭐⭐ | for, while, until, break, continue |
| 选择结构 | `05_case/` | 12 | ✅ | ⭐⭐⭐ | case, 模式匹配，菜单系统 |
| 文本处理 | `06_text/` | 3(AWK) | ✅ | ⭐⭐⭐⭐ | awk, grep, 数据分析 |
| 系统管理 | `07_system/` | 1 | ✅ | ⭐⭐⭐⭐ | 系统信息，服务监控 |
| 综合练习 | `08_practice/` | 3 | ✅ | ⭐⭐⭐⭐⭐ | 游戏开发，用户系统 |
| DevOps 实战 | `09_devops/` | 5 | ✅ | ⭐⭐⭐⭐⭐ | 运维自动化，备份恢复 |

**总计**: 55 个脚本（52 Shell + 3 AWK），9 个目录 README

---

## 📝 脚本详细列表

### 01_basic - 基础输出 ⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_hello_world.sh` | Hello World - 最简单的脚本 | echo, shebang | 15 |
| 2 | `02_special_variables.sh` | 特殊变量 ($0, $1, $$, $#, $*, $@) | 变量，参数 | 45 |

**📖 目录说明**: `01_basic/README.md`

### 02_input - 交互式输入 ⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_name_phone_age.sh` | read 命令 (-p, -s, -n, -t) | read, 输入 | 35 |
| 2 | `02_note_search.sh` | 笔记查找工具 (grep, cut, sort) | grep, 搜索 | 68 |
| 3 | `03_file_exist_check.sh` | 文件存在性检查 (-e) | if, 文件测试 | 42 |
| 4 | `04_ping_check.sh` | IP 连通性检查 (ping) | ping, 网络 | 38 |
| 5 | `05_user_info_complete.sh` | 完整用户信息输入 (性别、年龄验证) | 验证，循环 | 95 |

**📖 目录说明**: `02_input/README.md`

### 03_condition - 条件判断 ⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_logic_operation.sh` | 逻辑运算 (-o, -a, !) | 逻辑运算符 | 52 |
| 2 | `02_file_type_check.sh` | 文件类型判断 (目录、链接、设备等) | 文件测试 | 78 |
| 3 | `03_file_permission_check.sh` | 文件权限检查 (可读、可写、可执行) | 权限检查 | 85 |
| 4 | `04_dead_link_check.sh` | 死链接判断 (readlink) | 符号链接 | 92 |

**📖 目录说明**: `03_condition/README.md`

### 04_loop - 循环结构 ⭐⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_recursive_echo.sh` | 递归执行脚本 | 递归 | 28 |
| 2 | `02_multiplication_table.sh` | 99 乘法表 | 嵌套循环 | 45 |
| 3 | `03_countdown_2018.sh` | 倒计时到 2018 年元旦 | 日期计算 | 52 |
| 4 | `04_for_loop_basic.sh` | for 循环基础 (seq, 大括号展开) | for | 38 |
| 5 | `05_sum_odd_numbers.sh` | 1-100 奇数求和 | 算术运算 | 32 |
| 6 | `06_delete_users.sh` | 批量删除用户 (userdel, groupdel) | 用户管理 | 68 |
| 7 | `07_rdate_monitor.sh` | 时间同步监控 (while, mail) | while, 监控 | 85 |
| 8 | `08_guess_number_game.sh` | 猜数字游戏 (while, break) | 游戏逻辑 | 72 |
| 9-20 | ... | 更多循环练习 | 循环进阶 | ... |

**📖 目录说明**: `04_loop/README.md`

### 05_case - 选择结构 ⭐⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_day_of_week.sh` | 根据数字输出星期 | case | 42 |
| 2 | `02_grade_converter.sh` | 分数转等级 (A/B/C/D/F) | 模式匹配 | 48 |
| 3 | `03_color_menu.sh` | 彩色菜单选择 | 菜单系统 | 65 |
| 4-12 | ... | 更多选择结构练习 | case 进阶 | ... |

**📖 目录说明**: `05_case/README.md`

### 06_text - 文本处理 ⭐⭐⭐⭐ (AWK)

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_field_extractor.awk` | 字段提取基础 | AWK 基础 | 45 |
| 2 | `02_data_analyzer.awk` | 数据分析统计 | AWK 统计 | 78 |
| 3 | `03_report_generator.awk` | 报告生成 | AWK 格式化 | 125 |

**📖 目录说明**: `06_text/README.md`

### 07_system - 系统管理 ⭐⭐⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_system_info.sh` | 系统信息收集 | 系统命令，彩色输出 | 125 |

**📖 目录说明**: `07_system/README.md`

### 08_practice - 综合练习 ⭐⭐⭐⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_russian_tetris.sh` | 俄罗斯方块游戏 | 游戏开发，光标控制 | 285 |
| 2 | `02_user_register.sh` | 用户注册系统 (密码隐藏输入、验证) | 用户系统，加密 | 168 |
| 3 | `03_user_login.sh` | 用户登录系统 (验证码、10 秒限时) | 登录验证，超时 | 195 |

**📖 目录说明**: `08_practice/README.md`

### 09_devops - DevOps 实战 ⭐⭐⭐⭐⭐

| 序号 | 文件 | 描述 | 知识点 | 行数 |
|------|------|------|--------|------|
| 1 | `01_system_info_check.sh` | 系统信息检查 (彩色输出) | 系统监控 | 95 |
| 2 | `02_batch_user_manager.sh` | 批量用户管理 (创建/删除) | 用户管理 | 188 |
| 3 | `03_service_monitor.sh` | 服务监控 (自动重启) | 服务管理 | 223 |
| 4 | `04_log_cleaner.sh` | 日志清理 (释放空间) | 日志管理 | 202 |
| 5 | `05_backup_automation.sh` | 备份自动化 (数据库/文件/轮换) | 备份恢复 | 365 |

**📖 目录说明**: `09_devops/README.md`

---

## 🎯 学习路径推荐

### 初级 (⭐ ~ ⭐⭐)
1. `01_basic/01_hello_world.sh` - Hello World
2. `01_basic/02_special_variables.sh` - 特殊变量
3. `02_input/01_name_phone_age.sh` - read 输入
4. `03_condition/01_logic_operation.sh` - 逻辑运算

**目标**: 掌握基础语法和简单交互

### 中级 (⭐⭐⭐)
1. `04_loop/02_multiplication_table.sh` - 嵌套循环
2. `04_loop/08_guess_number_game.sh` - 游戏逻辑
3. `05_case/01_day_of_week.sh` - case 语句
4. `05_case/04_file_manager.sh` - 菜单系统

**目标**: 掌握流程控制和选择结构

### 高级 (⭐⭐⭐⭐)
1. `06_text/01_field_extractor.awk` - AWK 基础
2. `06_text/02_data_analyzer.awk` - 数据分析
3. `07_system/01_system_info.sh` - 系统管理

**目标**: 掌握文本处理和系统管理

### 专家 (⭐⭐⭐⭐⭐)
1. `08_practice/01_russian_tetris.sh` - 游戏开发
2. `08_practice/02_user_register.sh` - 用户系统
3. `09_devops/05_backup_automation.sh` - 备份自动化

**目标**: 能够开发完整的实际应用

---

## 🔍 按知识点查找

### echo/printf
- `01_basic/01_hello_world.sh`
- `01_basic/02_special_variables.sh`

### read 输入
- `02_input/01_name_phone_age.sh`
- `02_input/05_user_info_complete.sh`
- `08_practice/02_user_register.sh`

### if/else 条件
- `03_condition/` 目录下所有脚本
- `02_input/03_file_exist_check.sh`

### for 循环
- `04_loop/04_for_loop_basic.sh`
- `04_loop/02_multiplication_table.sh`
- `04_loop/` 目录下 20 个脚本

### while 循环
- `04_loop/07_rdate_monitor.sh`
- `04_loop/08_guess_number_game.sh`

### case 选择
- `05_case/` 目录下所有脚本

### AWK 文本处理
- `06_text/01_field_extractor.awk`
- `06_text/02_data_analyzer.awk`
- `06_text/03_report_generator.awk`

### 系统管理
- `07_system/01_system_info.sh`
- `09_devops/01_system_info_check.sh`

### 用户管理
- `04_loop/06_delete_users.sh`
- `09_devops/02_batch_user_manager.sh`
- `08_practice/02_user_register.sh`

### 服务监控
- `09_devops/03_service_monitor.sh`
- `04_loop/07_rdate_monitor.sh`

### 备份恢复
- `09_devops/05_backup_automation.sh`

---

## 📖 使用建议

1. **先读 README**: 每个目录都有 README.md，先阅读了解知识点
2. **按顺序学习**: 从 01_basic 开始，循序渐进
3. **运行示例**: 所有脚本都可运行，边学边练
4. **完成练习**: 每个目录 README 都有练习任务
5. **查阅索引**: 需要特定知识点时，使用本索引查找

---

**最后更新**: 2026-03-18  
**最新提交**: a7910c8 - docs: 为所有目录添加 README 说明文档  
**作者**: hjs2015
