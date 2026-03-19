#!/bin/bash
# Shell Notes 目录重组迁移脚本
# 执行时间：2026-03-19

set -e

echo "🚀 开始迁移脚本..."

# 阶段 1: 快速开始 (从 01_basic 选择最简单的)
echo "📦 迁移 00_quickstart..."
cp 01_basic/01_hello_world.sh 00_quickstart/
cp 01_basic/02_special_variables.sh 00_quickstart/

# 阶段 2: 基础篇
echo "📦 迁移 01_basics..."
# 01_variables
cp 01_basic/*.sh 01_basics/01_variables/ 2>/dev/null || true
cp 02_variable/*.sh 01_basics/01_variables/ 2>/dev/null || true

# 02_operators (从 02_variable 提取)
cp 02_variable/*.sh 01_basics/02_operators/ 2>/dev/null || true

# 03_io (从 02_input 迁移)
cp 02_input/*.sh 01_basics/03_io/ 2>/dev/null || true

# 阶段 3: 流程控制
echo "📦 迁移 02_control_flow..."
# 01_condition
cp 03_condition/*.sh 02_control_flow/01_condition/ 2>/dev/null || true

# 02_loops
cp 04_loop/*.sh 02_control_flow/02_loops/ 2>/dev/null || true

# 03_case
cp 05_case/*.sh 02_control_flow/03_case/ 2>/dev/null || true

# 04_functions
cp 10_function/*.sh 02_control_flow/04_functions/ 2>/dev/null || true

# 阶段 4: 数据结构
echo "📦 迁移 03_data_structures..."
# 从 04_loop 提取数组相关
cp 04_loop/*array*.sh 03_data_structures/01_indexed_arrays/ 2>/dev/null || true
# 从 07_system 提取关联数组
cp 07_system/16_associative_arrays.sh 03_data_structures/02_associative_arrays/ 2>/dev/null || true
# 字符串操作从 07_system 提取
cp 07_system/14_variable_advanced.sh 03_data_structures/03_strings/ 2>/dev/null || true

# 阶段 5: 文本处理
echo "📦 迁移 04_text_processing..."
cp 06_text/13_grep_advanced.sh 04_text_processing/01_grep/ 2>/dev/null || true
cp 06_text/14_sed_advanced.sh 04_text_processing/02_sed/ 2>/dev/null || true
cp 06_text/15_awk_advanced.sh 04_text_processing/03_awk/ 2>/dev/null || true
# 复制 AWK 脚本
cp 06_text/*.awk 04_text_processing/03_awk/ 2>/dev/null || true

# 阶段 6: 系统编程
echo "📦 迁移 05_system_programming..."
# 01_shell_init
cp 07_system/10_shell_initialization.sh 05_system_programming/01_shell_init/ 2>/dev/null || true
# 02_job_control
cp 07_system/13_job_control.sh 05_system_programming/02_job_control/ 2>/dev/null || true
# 03_signals (从 08_concurrency 提取)
cp 08_concurrency/*signal*.sh 05_system_programming/03_signals/ 2>/dev/null || true
# 04_concurrency
cp 08_concurrency/*.sh 05_system_programming/04_concurrency/ 2>/dev/null || true
# 05_shortcuts
cp 07_system/15_keyboard_shortcuts.md 05_system_programming/05_shortcuts/ 2>/dev/null || true

# 阶段 7: 实战项目
echo "📦 迁移 06_real_world..."
# 08_devops_tools
cp 09_devops/*.sh 06_real_world/08_devops_tools/ 2>/dev/null || true

echo "✅ 迁移完成!"
