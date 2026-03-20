#!/bin/bash
# =============================================================================
# 脚本：03_job_control.sh
# 功能：演示前后台作业控制
# 难度：⭐⭐⭐
# 知识点：
#   - & 后台运行
#   - nohup 退出终端继续运行
#   - jobs 查看作业
#   - fg/bg 切换前台后台
#   - Ctrl+Z 暂停
#   - kill 终止进程
# 使用方法：
#   ./03_job_control.sh
# =============================================================================

echo "=========================================="
echo "【1】& 后台运行"
echo "=========================================="

echo "启动 3 个后台任务..."
for i in 1 2 3; do
    sleep 10 &
    echo "✅ 启动任务 $i (PID: $!)"
done

echo ""
echo "当前作业列表："
jobs -l

echo ""
echo "=========================================="
echo "【2】nohup 退出终端继续运行"
echo "=========================================="

echo "使用 nohup 启动任务（关闭终端后仍运行）"
nohup sleep 30 &>/dev/null &
echo "✅ 启动 nohup 任务 (PID: $!)"

echo ""
echo "查看 nohup.out 文件（如果有输出）："
ls -lh nohup.out 2>/dev/null || echo "(无输出文件)"

echo ""
echo "=========================================="
echo "【3】jobs 命令详解"
echo "=========================================="

echo "查看所有作业："
jobs

echo ""
echo "查看作业详细信息："
jobs -l

echo ""
echo "查看运行中的作业："
jobs -r

echo ""
echo "查看暂停的作业："
jobs -s

echo ""
echo "=========================================="
echo "【4】fg 和 bg 命令"
echo "=========================================="

echo "启动一个后台任务..."
sleep 20 &
job_pid=$!
echo "✅ 任务已启动 (PID: $job_pid)"

echo ""
echo "暂停它（模拟 Ctrl+Z）："
kill -STOP $job_pid
echo "任务已暂停"

echo ""
echo "后台继续运行："
kill -CONT $job_pid
echo "任务已恢复"

echo ""
echo "=========================================="
echo "【5】kill 终止进程"
echo "=========================================="

echo "启动测试进程..."
sleep 100 &
test_pid=$!
echo "✅ 测试进程 (PID: $test_pid)"

echo ""
echo "终止进程..."
kill $test_pid
echo "已发送 TERM 信号"

sleep 1
if ps -p $test_pid > /dev/null 2>&1; then
    echo "⚠️  进程仍在运行，使用 SIGKILL"
    kill -9 $test_pid
fi

echo ""
echo "验证进程已终止："
ps -p $test_pid 2>/dev/null || echo "✅ 进程已终止"

echo ""
echo "=========================================="
echo "【6】实战技巧"
echo "=========================================="

echo "技巧 1：批量启动后台任务"
for i in {1..3}; do
    {
        echo "任务 $i 开始"
        sleep 2
        echo "任务 $i 完成"
    } &
done
wait
echo "✅ 所有任务完成"

echo ""
echo "技巧 2：限制并发数（简单版）"
echo "最多同时运行 2 个任务"
for i in {1..5}; do
    {
        echo "任务 $i 开始"
        sleep 1
        echo "任务 $i 完成"
    } &
    
    # 每 2 个任务等待一次
    if [ $((i % 2)) -eq 0 ]; then
        wait
    fi
done
wait

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
rm -f nohup.out 2>/dev/null
