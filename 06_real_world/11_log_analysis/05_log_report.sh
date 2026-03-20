#!/bin/bash
# =============================================================================
# 脚本名称：日志分析
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 所属阶段：阶段 7 - 实战项目
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "日志分析演示"; print_separator
LOG="/var/log/syslog"
if [ -f "$LOG" ]; then
  echo "日志文件：$LOG"
  echo "最后 10 行："
  tail -10 $LOG
  echo -e "\n错误日志："
  grep -i error $LOG | tail -5
else
  echo "创建测试日志..."
  echo -e "INFO: Started\nERROR: Failed\nWARN: Timeout" > /tmp/test.log
  echo "错误日志："
  grep -i error /tmp/test.log
fi
print_color GREEN "演示完成！"
