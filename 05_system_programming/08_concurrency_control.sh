#!/bin/bash
# =============================================================================
# 脚本：08_concurrency_control.sh
# 功能：演示并发控制
# 难度：⭐⭐⭐⭐
# 知识点：
#   - 文件描述符锁
#   - flock 命令
#   - 信号量控制并发数
#   - wait 命令
# 使用方法：
#   ./08_concurrency_control.sh
# =============================================================================

echo "=========================================="
echo "【1】简单并发（无控制）"
echo "=========================================="

echo "启动 5 个任务（无并发控制）："
for i in {1..5}; do
    {
        echo "任务 $i 开始"
        sleep 1
        echo "任务 $i 完成"
    } &
done
wait
echo "✅ 所有任务完成"

echo ""
echo "=========================================="
echo "【2】使用 flock 文件锁"
echo "=========================================="

lockfile="/tmp/test.lock"
rm -f $lockfile

echo "启动 5 个任务（使用文件锁）："
for i in {1..5}; do
    {
        (
            flock -x 200
            echo "任务 $i 获取锁，开始执行"
            sleep 1
            echo "任务 $i 释放锁"
        ) 200>$lockfile
    } &
done
wait
rm -f $lockfile
echo "✅ 所有任务完成"

echo ""
echo "=========================================="
echo "【3】控制并发数（信号量）"
echo "=========================================="

max_jobs=3
current_jobs=0

echo "最多同时运行 $max_jobs 个任务："
for i in {1..6}; do
    {
        echo "任务 $i 开始"
        sleep 1
        echo "任务 $i 完成"
    } &
    
    ((current_jobs++))
    
    # 达到最大并发数时等待
    if [ $current_jobs -ge $max_jobs ]; then
        wait -n 2>/dev/null || wait
        ((current_jobs--))
    fi
done
wait
echo "✅ 所有任务完成"

echo ""
echo "=========================================="
echo "【4】使用命名管道控制并发"
echo "=========================================="

fifo="/tmp/fifo_$$"
mkfifo $fifo
exec 3<>$fifo

max_concurrent=3

# 初始化管道（放入 max_concurrent 个令牌）
for ((i=0; i<max_concurrent; i++)); do
    echo >&3
done

echo "使用命名管道控制并发（最多 $max_concurrent 个）："
for i in {1..6}; do
    {
        # 获取令牌
        read -u3
        
        echo "任务 $i 开始"
        sleep 1
        echo "任务 $i 完成"
        
        # 归还令牌
        echo >&3
    } &
done

wait
exec 3>&-
rm -f $fifo
echo "✅ 所有任务完成"

echo ""
echo "=========================================="
echo "【5】实战：批量下载（控制并发）"
echo "=========================================="

echo "模拟批量下载（最多 3 个并发）："

download() {
    local url=$1
    local output=$2
    echo "下载：$url -> $output"
    sleep 1
    echo "完成：$output"
}

max_jobs=3
job_count=0

urls=("url1" "url2" "url3" "url4" "url5")

for url in "${urls[@]}"; do
    download "$url" "file_${url}" &
    ((job_count++))
    
    if [ $job_count -ge $max_jobs ]; then
        wait -n 2>/dev/null || wait
        ((job_count--))
    fi
done

wait
echo "✅ 所有下载完成"

echo ""
echo "=========================================="
echo "【6】实战：数据库备份（防止冲突）"
echo "=========================================="

backup_lock="/tmp/backup.lock"

echo "使用锁防止备份冲突："
(
    flock -n 200 || {
        echo "⚠️  已有备份在运行，跳过"
        exit 1
    }
    
    echo "开始备份..."
    sleep 2
    echo "备份完成"
    
) 200>$backup_lock

rm -f $backup_lock

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="
