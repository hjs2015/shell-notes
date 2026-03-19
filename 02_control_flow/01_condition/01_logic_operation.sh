#!/bin/bash
# =============================================================================
# 脚本名称：01_logic_operation.sh
# 功能描述：演示逻辑运算符的使用
# 难度等级：⭐⭐ 入门
# 知识点：
#   - if-else 条件判断
#   - -gt 大于 (greater than)
#   - -o 逻辑或 (or)
#   - ! 逻辑非 (not)
#   - -e 文件是否存在
# 使用方法：
#   chmod +x 01_logic_operation.sh
#   ./01_logic_operation.sh
# 逻辑运算符：
#   -a 与 (and) - 两个条件都为真时结果为真
#   -o 或 (or)  - 只要有一个条件为真结果就为真
#   !  非 (not) - 取反
# 整数比较：
#   -eq 等于 (equal)
#   -ne 不等于 (not equal)
#   -gt 大于 (greater than)
#   -lt 小于 (less than)
#   -ge 大于等于 (greater or equal)
#   -le 小于等于 (less or equal)
# =============================================================================

# 条件判断：1 大于 2 或者 /etc/fstab 文件不存在
# -gt 表示"大于"
# -o 表示"或"（or），只要有一个条件为真即可
# ! 表示"非"（not），取反
# -e 测试文件是否存在
if [ 1 -gt 2 -o ! -e /etc/fstab ]; then
	echo "true"
else
	echo "false"
fi

# 说明：
# 1. 1 -gt 2 为假（1 不大于 2）
# 2. ! -e /etc/fstab 取决于文件是否存在（通常/etc/fstab 是存在的，所以为假）
# 3. 假 -o 假 = 假，所以输出 "false"
# 4. 如果改为 -a（与），则两个条件都必须为真
