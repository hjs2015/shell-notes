#!/bin/bash
# =============================================================================
# 脚本名称：15_container_manager.sh
# 功能描述：Docker 容器管理脚本（部署、监控、清理、备份）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - Docker 容器管理
#   - 镜像管理
#   - 容器监控
#   - 批量操作
#   - 自动清理
# 使用方法：
#   sudo ./15_container_manager.sh --list              # 列出容器
#   sudo ./15_container_manager.sh --deploy nginx      # 部署容器
#   sudo ./15_container_manager.sh --monitor           # 监控容器
#   sudo ./15_container_manager.sh --cleanup           # 清理资源
# 代码说明：
#   - 需要 Docker 环境
#   - 支持容器全生命周期管理
#   - 自动清理无用资源
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
DOCKER_DATA_DIR="/var/lib/docker"
BACKUP_DIR="/backup/docker"
LOG_FILE="/var/log/container_manager.log"

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "========================================"
}

# 打印结果
print_result() {
    local status=$1
    local message=$2
    
    case $status in
        "OK")
            echo -e "${GREEN}✓${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}⚠${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}✗${NC} $message"
            ;;
        "INFO")
            echo -e "${CYAN}ℹ${NC} $message"
            ;;
    esac
}

# 记录日志
log_action() {
    local message=$1
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

# =============================================================================
# 检查 Docker
# =============================================================================
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_result "ERROR" "未安装 Docker"
        exit 1
    fi
    
    if ! docker info &>/dev/null; then
        print_result "ERROR" "Docker 服务未运行"
        exit 1
    fi
    
    print_result "OK" "Docker 服务正常"
    log_action "CHECK: Docker service running"
}

# =============================================================================
# 列出容器
# =============================================================================
list_containers() {
    print_header "容器列表"
    
    echo ""
    echo "运行中的容器:"
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null
    
    echo ""
    echo "已停止的容器:"
    docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" 2>/dev/null
    
    # 统计
    local running=$(docker ps -q 2>/dev/null | wc -l)
    local stopped=$(docker ps -a --filter "status=exited" -q 2>/dev/null | wc -l)
    local total=$(docker ps -a -q 2>/dev/null | wc -l)
    
    echo ""
    echo "容器统计:"
    echo "  运行中：$running"
    echo "  已停止：$stopped"
    echo "  总计：$total"
    
    log_action "LIST: $running running, $stopped stopped, $total total"
}

# =============================================================================
# 容器详情
# =============================================================================
container_details() {
    local container_name=$1
    
    print_header "容器详情：$container_name"
    
    if ! docker inspect "$container_name" &>/dev/null; then
        print_result "ERROR" "容器不存在：$container_name"
        return 1
    fi
    
    # 基本信息
    echo "基本信息:"
    docker inspect --format '
名称：{{.Name}}
ID: {{.Id}}
镜像：{{.Config.Image}}
状态：{{.State.Status}}
运行时间：{{.State.StartedAt}}
' "$container_name" 2>/dev/null
    
    # 资源限制
    echo ""
    echo "资源限制:"
    docker inspect --format '
CPU 限制：{{.HostConfig.CpuShares}}
内存限制：{{.HostConfig.Memory}}
重启策略：{{.HostConfig.RestartPolicy.Name}}
' "$container_name" 2>/dev/null
    
    # 网络信息
    echo ""
    echo "网络信息:"
    docker inspect --format '
网络模式：{{.HostConfig.NetworkMode}}
IP 地址：{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}
网关：{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}
' "$container_name" 2>/dev/null
    
    # 端口映射
    echo ""
    echo "端口映射:"
    docker port "$container_name" 2>/dev/null || echo "  无端口映射"
    
    log_action "DETAILS: Show details for $container_name"
}

# =============================================================================
# 部署容器
# =============================================================================
deploy_container() {
    local image_name=$1
    local container_name=${2:-$image_name}
    local port=${3:-""}
    local volume=${4:-""}
    
    print_header "部署容器"
    
    echo "部署信息:"
    echo "  镜像：$image_name"
    echo "  容器名：$container_name"
    [[ -n "$port" ]] && echo "  端口：$port"
    [[ -n "$volume" ]] && echo "  卷：$volume"
    echo ""
    
    # 检查镜像
    if ! docker image inspect "$image_name" &>/dev/null; then
        print_result "INFO" "镜像不存在，正在拉取..."
        docker pull "$image_name"
        if [[ $? -ne 0 ]]; then
            print_result "ERROR" "拉取镜像失败"
            return 1
        fi
        print_result "OK" "镜像拉取成功"
    fi
    
    # 停止并删除旧容器
    if docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        print_result "WARN" "容器已存在，正在删除..."
        docker stop "$container_name" 2>/dev/null
        docker rm "$container_name" 2>/dev/null
        log_action "DEPLOY: Removed old container $container_name"
    fi
    
    # 构建运行命令
    local run_cmd="docker run -d"
    run_cmd="$run_cmd --name $container_name"
    run_cmd="$run_cmd --restart unless-stopped"
    
    [[ -n "$port" ]] && run_cmd="$run_cmd -p $port"
    [[ -n "$volume" ]] && run_cmd="$run_cmd -v $volume"
    
    run_cmd="$run_cmd $image_name"
    
    echo ""
    echo "执行命令：$run_cmd"
    echo ""
    
    # 运行容器
    if eval "$run_cmd"; then
        print_result "OK" "容器部署成功"
        log_action "DEPLOY: Container $container_name deployed"
        
        # 显示状态
        echo ""
        docker ps --filter "name=$container_name" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    else
        print_result "ERROR" "容器部署失败"
        log_action "DEPLOY: Failed to deploy $container_name"
        return 1
    fi
}

# =============================================================================
# 容器监控
# =============================================================================
monitor_containers() {
    print_header "容器监控"
    
    echo "容器资源使用:"
    echo ""
    
    # 实时统计
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}" 2>/dev/null
    
    echo ""
    echo "容器健康状态:"
    
    # 检查每个运行中的容器
    docker ps --format '{{.Names}}' 2>/dev/null | while read -r container; do
        local health=$(docker inspect --format '{{.State.Health.Status}}' "$container" 2>/dev/null)
        
        if [[ "$health" == "healthy" ]]; then
            print_result "OK" "$container - 健康"
        elif [[ "$health" == "unhealthy" ]]; then
            print_result "ERROR" "$container - 不健康"
        else
            print_result "INFO" "$container - 无健康检查"
        fi
    done
    
    log_action "MONITOR: Container health check completed"
}

# =============================================================================
# 查看日志
# =============================================================================
view_logs() {
    local container_name=$1
    local lines=${2:-100}
    local follow=${3:-false}
    
    print_header "容器日志：$container_name"
    
    if [[ "$follow" == "true" ]]; then
        docker logs -f --tail "$lines" "$container_name" 2>&1
    else
        docker logs --tail "$lines" "$container_name" 2>&1
    fi
}

# =============================================================================
# 清理资源
# =============================================================================
cleanup_resources() {
    print_header "清理 Docker 资源"
    
    local cleaned=0
    
    # 清理已停止的容器
    echo "清理已停止的容器:"
    local stopped_count=$(docker ps -a --filter "status=exited" -q 2>/dev/null | wc -l)
    
    if [[ $stopped_count -gt 0 ]]; then
        if docker container prune -f &>/dev/null; then
            print_result "OK" "已清理 $stopped_count 个已停止容器"
            ((cleaned++))
            log_action "CLEANUP: Removed $stopped_count stopped containers"
        fi
    else
        print_result "OK" "无已停止容器"
    fi
    
    # 清理悬空镜像
    echo ""
    echo "清理悬空镜像:"
    local dangling_count=$(docker images --filter "dangling=true" -q 2>/dev/null | wc -l)
    
    if [[ $dangling_count -gt 0 ]]; then
        if docker image prune -f &>/dev/null; then
            print_result "OK" "已清理 $dangling_count 个悬空镜像"
            ((cleaned++))
            log_action "CLEANUP: Removed $dangling_count dangling images"
        fi
    else
        print_result "OK" "无悬空镜像"
    fi
    
    # 清理未使用镜像
    echo ""
    echo "清理未使用镜像:"
    read -p "是否清理未使用的镜像？(y/n): " confirm
    
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        local unused_count=$(docker images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | wc -l)
        if docker image prune -a -f &>/dev/null; then
            print_result "OK" "已清理未使用镜像"
            ((cleaned++))
            log_action "CLEANUP: Removed unused images"
        fi
    fi
    
    # 清理卷
    echo ""
    echo "清理未使用卷:"
    read -p "是否清理未使用的卷？(y/n): " confirm
    
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        if docker volume prune -f &>/dev/null; then
            print_result "OK" "已清理未使用卷"
            ((cleaned++))
            log_action "CLEANUP: Removed unused volumes"
        fi
    fi
    
    # 清理网络
    echo ""
    echo "清理未使用网络:"
    if docker network prune -f &>/dev/null; then
        print_result "OK" "已清理未使用网络"
        ((cleaned++))
        log_action "CLEANUP: Removed unused networks"
    fi
    
    # 显示磁盘空间
    echo ""
    echo "Docker 磁盘使用:"
    docker system df
    
    echo ""
    echo "清理完成：$cleaned 项"
    
    log_action "CLEANUP: Total $cleaned items cleaned"
}

# =============================================================================
# 备份容器
# =============================================================================
backup_container() {
    local container_name=$1
    
    print_header "备份容器"
    
    if [[ -z "$container_name" ]]; then
        print_result "ERROR" "请指定容器名"
        return 1
    fi
    
    if ! docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        print_result "ERROR" "容器不存在：$container_name"
        return 1
    fi
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="${BACKUP_DIR}/${container_name}_${timestamp}.tar"
    
    mkdir -p "$BACKUP_DIR"
    
    echo "备份信息:"
    echo "  容器：$container_name"
    echo "  备份文件：$backup_file"
    echo ""
    
    # 导出容器
    echo "正在导出容器..."
    if docker export "$container_name" > "$backup_file"; then
        local size=$(du -h "$backup_file" | cut -f1)
        print_result "OK" "容器备份成功：$size"
        log_action "BACKUP: Container $container_name backed up to $backup_file"
    else
        print_result "ERROR" "容器备份失败"
        log_action "BACKUP: Failed to backup $container_name"
        return 1
    fi
    
    # 保存配置
    local config_file="${BACKUP_DIR}/${container_name}_${timestamp}_config.json"
    docker inspect "$container_name" > "$config_file"
    print_result "OK" "配置已保存：$config_file"
}

# =============================================================================
# 容器重启
# =============================================================================
restart_container() {
    local container_name=$1
    
    print_header "重启容器"
    
    if [[ -z "$container_name" ]]; then
        print_result "ERROR" "请指定容器名"
        return 1
    fi
    
    if ! docker ps --format '{{.Names}}' | grep -q "^${container_name}$"; then
        print_result "ERROR" "容器未运行：$container_name"
        return 1
    fi
    
    echo "重启容器：$container_name"
    
    if docker restart "$container_name"; then
        print_result "OK" "容器重启成功"
        log_action "RESTART: Container $container_name restarted"
    else
        print_result "ERROR" "容器重启失败"
        log_action "RESTART: Failed to restart $container_name"
        return 1
    fi
}

# =============================================================================
# 容器统计
# =============================================================================
container_stats() {
    print_header "Docker 统计"
    
    # 镜像统计
    echo "镜像统计:"
    local image_count=$(docker images -q 2>/dev/null | wc -l)
    local image_size=$(docker images --format "{{.Size}}" 2>/dev/null | awk '{sum+=$1} END {print sum}')
    echo "  镜像数量：$image_count"
    echo "  总大小：$image_size"
    echo ""
    
    # 容器统计
    echo "容器统计:"
    local running=$(docker ps -q 2>/dev/null | wc -l)
    local stopped=$(docker ps -a --filter "status=exited" -q 2>/dev/null | wc -l)
    local paused=$(docker ps --filter "status=paused" -q 2>/dev/null | wc -l)
    echo "  运行中：$running"
    echo "  已停止：$stopped"
    echo "  已暂停：$paused"
    echo ""
    
    # 卷统计
    echo "卷统计:"
    local volume_count=$(docker volume ls -q 2>/dev/null | wc -l)
    echo "  卷数量：$volume_count"
    echo ""
    
    # 网络统计
    echo "网络统计:"
    local network_count=$(docker network ls -q 2>/dev/null | wc -l)
    echo "  网络数量：$network_count"
    echo ""
    
    # 磁盘使用
    echo "磁盘使用:"
    docker system df
    
    log_action "STATS: Docker system statistics"
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  --list               列出所有容器"
    echo "  --details NAME       显示容器详情"
    echo "  --deploy IMAGE       部署容器"
    echo "  --monitor            监控容器"
    echo "  --logs NAME          查看容器日志"
    echo "  --restart NAME       重启容器"
    echo "  --cleanup            清理资源"
    echo "  --backup NAME        备份容器"
    echo "  --stats              显示统计信息"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 --list"
    echo "  $0 --deploy nginx:latest -p 80:80"
    echo "  $0 --monitor"
    echo "  $0 --cleanup"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local action=""
    local container_name=""
    local image_name=""
    local port=""
    local volume=""
    local lines=100
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --list)
                action="list"
                shift
                ;;
            --details)
                action="details"
                container_name="$2"
                shift 2
                ;;
            --deploy)
                action="deploy"
                image_name="$2"
                shift 2
                ;;
            -p|--port)
                port="$2"
                shift 2
                ;;
            -v|--volume)
                volume="$2"
                shift 2
                ;;
            --monitor)
                action="monitor"
                shift
                ;;
            --logs)
                action="logs"
                container_name="$2"
                shift 2
                ;;
            --restart)
                action="restart"
                container_name="$2"
                shift 2
                ;;
            --cleanup)
                action="cleanup"
                shift
                ;;
            --backup)
                action="backup"
                container_name="$2"
                shift 2
                ;;
            --stats)
                action="stats"
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "未知选项：$1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # 检查 Docker
    check_docker
    
    # 执行操作
    case $action in
        "list")
            list_containers
            ;;
        "details")
            container_details "$container_name"
            ;;
        "deploy")
            deploy_container "$image_name" "$container_name" "$port" "$volume"
            ;;
        "monitor")
            monitor_containers
            ;;
        "logs")
            view_logs "$container_name" "$lines"
            ;;
        "restart")
            restart_container "$container_name"
            ;;
        "cleanup")
            cleanup_resources
            ;;
        "backup")
            backup_container "$container_name"
            ;;
        "stats")
            container_stats
            ;;
        *)
            show_help
            ;;
    esac
}

# 执行主程序
main "$@"
