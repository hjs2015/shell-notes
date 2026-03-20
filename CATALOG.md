# 📚 Shell 脚本案例清单

> 完整的 226 个 Shell 脚本案例索引，按 7 个学习阶段 (226 个脚本)分类

---

## 阶段 1: 快速开始 (00_quickstart)

**脚本数量**: 3 个 | **难度**: ⭐ | **学习时长**: 第 1 天

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_hello_world.sh` | ⭐ | 第一个 Shell 脚本，echo 输出 |
| 2 | `02_special_variables.sh` | ⭐ | 特殊变量：`$0`, `$1`, `$#`, `$@`, `$*`, `$?`, `$$` |
| 3 | `05_wildcards_and_echo.sh` | ⭐ | 通配符 `*`, `?`, `[]` 与 echo |

---

## 阶段 2: Bash 基础 (01_basics)

**脚本数量**: 12 个 | **难度**: ⭐⭐ | **学习时长**: 第 2-7 天

### 01_variables - 变量

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_hello_world.sh` | ⭐ | 变量定义与使用 |
| 2 | `02_special_variables.sh` | ⭐⭐ | 特殊变量详解 |
| 3 | `06_shell_execution_modes.sh` | ⭐⭐ | Shell 执行模式 |
| 4 | `06_variable_operations.sh` | ⭐⭐⭐ | 变量操作：长度、截取、替换 |
| 5 | `07_boolean_and_logic.sh` | ⭐⭐ | 布尔值与逻辑运算 |
| 6 | `08_wildcards_detailed.sh` | ⭐⭐ | 通配符详解 |

### 02_operators - 运算符

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `07_arithmetic.sh` | ⭐⭐ | 算术运算：`+`, `-`, `*`, `/`, `%` |

### 03_io - 输入输出

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_name_phone_age.sh` | ⭐⭐ | read 命令基础 |
| 2 | `02_note_search.sh` | ⭐⭐⭐ | 笔记查找工具 |
| 3 | `03_file_exist_check.sh` | ⭐⭐ | 文件存在性检查 |
| 4 | `04_ping_check.sh` | ⭐⭐ | Ping 连通性检查 |
| 5 | `05_user_info_complete.sh` | ⭐⭐⭐ | 完整用户信息输入 |

---

## 阶段 3: 流程控制 (02_control_flow)

**脚本数量**: 44 个 | **难度**: ⭐⭐⭐ | **学习时长**: 第 8-28 天

### 01_condition - 条件判断

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_logic_operation.sh` | ⭐⭐ | 逻辑运算：`&&`, `||`, `!` |
| 2 | `02_file_type_check.sh` | ⭐⭐⭐ | 文件类型判断：`-f`, `-d`, `-l` |
| 3 | `03_file_permission_check.sh` | ⭐⭐⭐ | 文件权限检查：`-r`, `-w`, `-x` |
| 4 | `04_dead_link_check.sh` | ⭐⭐⭐⭐ | 死链接判断：`readlink` |
| 5 | `06_string_comparison.sh` | ⭐⭐ | 字符串比较 |
| 6 | `07_c_style_comparison.sh` | ⭐⭐ | C 风格比较 |

### 02_loops - 循环结构

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_recursive_echo.sh` | ⭐⭐ | 递归执行 |
| 2 | `02_multiplication_table.sh` | ⭐⭐⭐ | 九九乘法表 |
| 3 | `03_countdown_2018.sh` | ⭐⭐⭐ | 倒计时程序 |
| 4 | `04_for_c_style.sh` | ⭐⭐ | C 风格 for 循环 |
| 5 | `04_for_loop_basic.sh` | ⭐⭐ | for 循环基础 |
| 6 | `04_until_loop.sh` | ⭐⭐ | until 循环 |
| 7 | `05_break_continue.sh` | ⭐⭐ | break 和 continue |
| 8 | `05_for_array.sh` | ⭐⭐ | 数组遍历 |
| 9 | `05_sum_odd_numbers.sh` | ⭐⭐ | 奇数求和 |
| 10 | `06_delete_users.sh` | ⭐⭐⭐ | 批量删除用户 |
| 11 | `07_rdate_monitor.sh` | ⭐⭐⭐⭐ | 时间同步监控 |
| 12 | `08_guess_number_game.sh` | ⭐⭐⭐ | 猜数字游戏 |
| 13 | `09_nested_loop_pattern.sh` | ⭐⭐⭐⭐ | 嵌套循环打印 |
| 14 | `10_find_dead_links.sh` | ⭐⭐⭐ | 查找死链接 |
| 15 | `11_su_command_test.sh` | ⭐⭐ | su 命令测试 |
| 16 | `12_prime_numbers.sh` | ⭐⭐⭐⭐ | 求质数 |
| 17 | `14_copy_conf_files.sh` | ⭐⭐⭐ | 复制配置文件 |
| 18 | `15_copy_index_html.sh` | ⭐⭐ | 复制文件 |
| 19 | `16_generate_phone_numbers.sh` | ⭐⭐ | 生成手机号 |
| 20 | `17_lucky_draw.sh` | ⭐⭐⭐⭐ | 幸运抽奖 |
| 21 | `18_fake_login_screen.sh` | ⭐⭐⭐ | 伪造登录界面 |

### 03_case - 选择结构

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_char_type_check.sh` | ⭐⭐ | 字符类型判断 |
| 2 | `02_menu_system.sh` | ⭐⭐⭐ | 多级菜单系统 |
| 3 | `03_service_price.sh` | ⭐⭐⭐ | 服务价格查询 |
| 4 | `04_phone_brand_menu.sh` | ⭐⭐⭐ | 手机品牌菜单 |
| 5 | `05_select_os.sh` | ⭐⭐ | select 菜单 |
| 6 | `06_sysv_init_script.sh` | ⭐⭐⭐⭐ | SysV init 脚本 |
| 7 | `07_sysv_init_advanced.sh` | ⭐⭐⭐⭐⭐ | 高级 SysV init |
| 8 | `08_number_to_words.sh` | ⭐⭐⭐ | 数字转英文 |
| 9 | `09_find_dead_links_recursive.sh` | ⭐⭐⭐⭐ | 递归查找死链接 |
| 10 | `10_usb_mount_menu.sh` | ⭐⭐⭐⭐ | USB 挂载菜单 |
| 11 | `11_generate_phone_all.sh` | ⭐⭐ | 生成所有号段 |
| 12 | `12_tetris_game.sh` | ⭐⭐⭐⭐⭐ | 俄罗斯方块游戏 |

### 04_functions - 函数

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_function_basics.sh` | ⭐⭐ | 函数基础 |
| 2 | `02_function_parameters.sh` | ⭐⭐ | 函数参数 |
| 3 | `03_local_variables.sh` | ⭐⭐ | 局部变量 |
| 4 | `04_return_values.sh` | ⭐⭐ | 返回值 |

---

## 阶段 4: 数据结构 (03_data_structures)

**脚本数量**: 4 个 | **难度**: ⭐⭐⭐ | **学习时长**: 第 22-28 天

### 01_indexed_arrays - 索引数组

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `05_for_array.sh` | ⭐⭐ | 数组遍历 |
| 2 | `09_arrays.sh` | ⭐⭐⭐ | 数组操作 |

### 02_associative_arrays - 关联数组

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `16_associative_arrays.sh` | ⭐⭐⭐ | 关联数组 |

### 03_strings - 字符串

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `14_variable_advanced.sh` | ⭐⭐⭐ | 字符串高级操作 |

---

## 阶段 5: 文本处理 (04_text_processing)

**脚本数量**: 3 个 | **难度**: ⭐⭐⭐⭐ | **学习时长**: 第 29-42 天

### 01_grep - Grep 搜索

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `13_grep_advanced.sh` | ⭐⭐⭐⭐ | Grep 高级用法 |

### 02_sed - Sed 编辑

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `14_sed_advanced.sh` | ⭐⭐⭐⭐ | Sed 高级用法 |

### 03_awk - Awk 分析

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `15_awk_advanced.sh` | ⭐⭐⭐⭐ | Awk 高级用法 |

---

## 阶段 6: 系统编程 (05_system_programming)

**脚本数量**: 10 个 | **难度**: ⭐⭐⭐⭐ | **学习时长**: 第 43-58 天

### 01_shell_init - Shell 初始化

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_log_rotation.sh` | ⭐⭐⭐⭐ | 日志轮转 |
| 2 | `01_return_code_and_logic.sh` | ⭐⭐ | 返回码与逻辑 |
| 3 | `02_boolean_and_special_vars.sh` | ⭐⭐ | 布尔与特殊变量 |
| 4 | `04_redirection_and_pipe.sh` | ⭐⭐⭐ | 重定向与管道 |
| 5 | `10_shell_initialization.sh` | ⭐⭐⭐ | Shell 初始化文件 |

### 02_job_control - 作业控制

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `03_job_control.sh` | ⭐⭐⭐ | 作业控制基础 |
| 2 | `13_job_control.sh` | ⭐⭐⭐ | 作业控制进阶 |

### 04_concurrency - 并发控制

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `08_concurrency_control.sh` | ⭐⭐⭐⭐ | 并发控制 |

### 05_shortcuts - 快捷键与别名

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `11_command_history.sh` | ⭐⭐ | 命令历史 |
| 2 | `12_alias_function.sh` | ⭐⭐ | 别名与函数 |

---

## 阶段 7: 实战项目 (06_real_world)

**脚本数量**: 24 个 | **难度**: ⭐⭐⭐⭐⭐ | **学习时长**: 第 59-90 天

### 07_security_tools - 安全工具

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_password_validator.sh` | ⭐⭐⭐ | 密码验证器 |
| 2 | `02_user_register.sh` | ⭐⭐⭐⭐ | 用户注册系统 |
| 3 | `03_user_login.sh` | ⭐⭐⭐⭐ | 用户登录系统 |

### 08_devops_tools - DevOps 工具

| 序号 | 文件名 | 难度 | 知识点 |
|------|--------|------|--------|
| 1 | `01_system_info_check.sh` | ⭐⭐⭐ | 系统信息检查 |
| 2 | `02_batch_user_manager.sh` | ⭐⭐⭐⭐ | 批量用户管理 |
| 3 | `03_service_monitor.sh` | ⭐⭐⭐⭐ | 服务监控 |
| 4 | `04_log_cleaner.sh` | ⭐⭐⭐ | 日志清理 |
| 5 | `05_backup_automation.sh` | ⭐⭐⭐⭐⭐ | 备份自动化 |
| 6 | `06_server_inspection.sh` | ⭐⭐⭐ | 服务器巡检 |
| 7 | `07_project_check.sh` | ⭐⭐ | 项目检查 |
| 8 | `08_security_audit.sh` | ⭐⭐⭐⭐ | 安全审计 |
| 9 | `09_network_diagnosis.sh` | ⭐⭐⭐ | 网络诊断 |
| 10 | `10_performance_monitor.sh` | ⭐⭐⭐ | 性能监控 |
| 11 | `11_daily_inspection.sh` | ⭐⭐⭐ | 日常巡检 |
| 12 | `12_auto_deploy.sh` | ⭐⭐⭐⭐ | 自动部署 |
| 13 | `13_security_hardening.sh` | ⭐⭐⭐⭐ | 安全加固 |
| 14 | `14_log_analysis.sh` | ⭐⭐⭐ | 日志分析 |
| 15 | `15_container_manager.sh` | ⭐⭐⭐⭐ | 容器管理 |
| 16 | `16_database_backup.sh` | ⭐⭐⭐ | 数据库备份 |
| 17 | `17_ssl_monitor.sh` | ⭐⭐⭐ | SSL 证书监控 |
| 18 | `18_resource_cleanup.sh` | ⭐⭐ | 资源清理 |
| 19 | `19_bandwidth_monitor.sh` | ⭐⭐⭐ | 带宽监控 |
| 20 | `20_file_sync.sh` | ⭐⭐⭐ | 文件同步 |
| 21 | `21_security_baseline.sh` | ⭐⭐⭐⭐ | 安全基线检查 |

---

## 📊 统计信息

### 总体统计

| 指标 | 数量 |
|------|------|
| **总脚本数** | 103 个 |
| **学习阶段** | 7 个 |
| **子目录** | 25 个 |
| **代码行数** | ~20,000 行 |
| **预计学习时间** | 90 天 |

### 难度分布

| 难度 | 脚本数 | 占比 |
|------|--------|------|
| ⭐ 入门 | 3 | 3% |
| ⭐⭐ 初级 | 35 | 34% |
| ⭐⭐⭐ 中级 | 37 | 36% |
| ⭐⭐⭐⭐ 高级 | 20 | 19% |
| ⭐⭐⭐⭐⭐ 专家 | 8 | 8% |

### 阶段分布

| 阶段 | 脚本数 | 学习时长 |
|------|--------|----------|
| 快速开始 | 3 | 1 天 |
| Bash 基础 | 12 | 6 天 |
| 流程控制 | 44 | 21 天 |
| 数据结构 | 4 | 7 天 |
| 文本处理 | 3 | 14 天 |
| 系统编程 | 10 | 16 天 |
| 实战项目 | 24 | 32 天 |

---

**最后更新**: 2026-03-21  
**脚本总数**: 103 个  
**GitHub**: https://github.com/hjs2015/shell-notes
