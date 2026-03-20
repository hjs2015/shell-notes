#!/bin/bash
# ============================================================================
# 脚本名称：03_docker_swarm.sh
# 功能描述：Docker Swarm 集群管理 - 初始化、节点管理、服务部署、扩缩容
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：Docker Swarm、集群管理、服务部署、负载均衡
# 使用方法：bash 03_docker_swarm.sh
# 依赖命令：docker
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }

check_docker() {
    if ! command -v docker &>/dev/null; then
        print_error "Docker 未安装"
        exit 1
    fi
}

print_header "🐳 Docker Swarm 集群管理"

# 菜单
show_menu() {
    echo ""
    echo "请选择操作："
    echo "1. 初始化 Swarm 集群"
    echo "2. 查看集群信息"
    echo "3. 查看节点列表"
    echo "4. 加入节点（Worker）"
    echo "5. 加入节点（Manager）"
    echo "6. 部署服务"
    echo "7. 查看服务列表"
    echo "8. 扩展服务"
    echo "9. 删除服务"
    echo "10. 查看服务日志"
    echo "11. 离开集群"
    echo "0. 退出"
    echo ""
}

# 初始化集群
init_swarm() {
    print_header "初始化 Swarm 集群"
    
    read -p "请输入管理节点 IP（默认自动检测）： " advertise_addr
    
    if [ -z "$advertise_addr" ]; then
        advertise_addr=$(hostname -I | awk '{print $1}')
        echo "自动检测到 IP: $advertise_addr"
    fi
    
    docker swarm init --advertise-addr "$advertise_addr"
    
    if [ $? -eq 0 ]; then
        print_success "Swarm 集群初始化成功"
        echo ""
        echo "Worker 节点加入命令："
        docker swarm join-token worker -q
    else
        print_error "初始化失败"
    fi
}

# 查看集群信息
cluster_info() {
    print_header "集群信息"
    
    echo "=== 集群基本信息 ==="
    docker info 2>/dev/null | grep -A 10 "Swarm:"
    
    echo ""
    echo "=== 集群节点统计 ==="
    local nodes=$(docker node ls 2>/dev/null | tail -n +2 | wc -l)
    local managers=$(docker node ls 2>/dev/null | grep Manager | wc -l)
    local workers=$(docker node ls 2>/dev/null | grep Worker | wc -l)
    
    echo "总节点数：$nodes"
    echo "Manager 节点：$managers"
    echo "Worker 节点：$workers"
}

# 查看节点列表
node_list() {
    print_header "节点列表"
    
    echo ""
    docker node ls 2>/dev/null || print_error "无法获取节点列表（可能未加入集群）"
    
    echo ""
    echo "=== 节点详细信息 ==="
    docker node ls -q 2>/dev/null | while read node_id; do
        echo ""
        echo "节点：$node_id"
        docker node inspect --format 'Hostname: {{.Description.Hostname}}' "$node_id" 2>/dev/null
        docker node inspect --format 'Role: {{.Spec.Role}}' "$node_id" 2>/dev/null
        docker node inspect --format 'Status: {{.Status.State}}' "$node_id" 2>/dev/null
    done
}

# Worker 节点加入
join_worker() {
    print_header "Worker 节点加入集群"
    
    read -p "请输入 Manager 节点 IP: " manager_ip
    read -p "请输入端口（默认 2377）： " port
    port=${port:-2377}
    
    read -p "请输入 Worker Token： " token
    
    docker swarm join --token "$token" "$manager_ip:$port"
    
    if [ $? -eq 0 ]; then
        print_success "成功加入集群（Worker）"
    else
        print_error "加入失败"
    fi
}

# Manager 节点加入
join_manager() {
    print_header "Manager 节点加入集群"
    
    read -p "请输入现有 Manager 节点 IP: " manager_ip
    read -p "请输入端口（默认 2377）： " port
    port=${port:-2377}
    
    read -p "请输入 Manager Token： " token
    
    docker swarm join --token "$token" "$manager_ip:$port"
    
    if [ $? -eq 0 ]; then
        print_success "成功加入集群（Manager）"
    else
        print_error "加入失败"
    fi
}

# 部署服务
deploy_service() {
    print_header "部署服务"
    
    read -p "请输入服务名称： " service_name
    read -p "请输入镜像名称： " image
    read -p "请输入副本数（默认 1）： " replicas
    replicas=${replicas:-1}
    read -p "请输入容器端口： " container_port
    read -p "请输入主机端口： " host_port
    
    docker service create \
        --name "$service_name" \
        --replicas "$replicas" \
        -p "$host_port:$container_port" \
        "$image"
    
    if [ $? -eq 0 ]; then
        print_success "服务部署成功：$service_name"
    else
        print_error "部署失败"
    fi
}

# 查看服务列表
service_list() {
    print_header "服务列表"
    
    echo ""
    docker service ls 2>/dev/null || print_error "无法获取服务列表"
    
    echo ""
    echo "=== 服务任务详情 ==="
    docker service ps $(docker service ls -q 2>/dev/null) 2>/dev/null | head -20
}

# 扩展服务
scale_service() {
    print_header "扩展服务"
    
    read -p "请输入服务名称： " service_name
    read -p "请输入目标副本数： " replicas
    
    docker service scale "$service_name=$replicas"
    
    if [ $? -eq 0 ]; then
        print_success "服务已扩展到 $replicas 个副本"
    else
        print_error "扩展失败"
    fi
}

# 删除服务
remove_service() {
    print_header "删除服务"
    
    read -p "请输入服务名称： " service_name
    
    read -p "确认删除 $service_name？(y/n): " confirm
    if [ "$confirm" != "y" ]; then
        print_warning "取消删除"
        return
    fi
    
    docker service rm "$service_name"
    
    if [ $? -eq 0 ]; then
        print_success "服务已删除：$service_name"
    else
        print_error "删除失败"
    fi
}

# 查看服务日志
service_logs() {
    print_header "查看服务日志"
    
    read -p "请输入服务名称： " service_name
    
    read -p "显示多少行日志（默认 50）： " lines
    lines=${lines:-50}
    
    docker service logs --tail "$lines" "$service_name"
}

# 离开集群
leave_cluster() {
    print_header "离开集群"
    
    read -p "确认离开 Swarm 集群？(y/n): " confirm
    if [ "$confirm" != "y" ]; then
        print_warning "取消操作"
        return
    fi
    
    docker swarm leave --force 2>/dev/null || docker swarm leave
    
    if [ $? -eq 0 ]; then
        print_success "已离开集群"
    else
        print_error "离开失败"
    fi
}

# 主循环
check_docker

while true; do
    show_menu
    read -p "请选择操作（0-11）： " choice
    
    case $choice in
        1) init_swarm ;;
        2) cluster_info ;;
        3) node_list ;;
        4) join_worker ;;
        5) join_manager ;;
        6) deploy_service ;;
        7) service_list ;;
        8) scale_service ;;
        9) remove_service ;;
        10) service_logs ;;
        11) leave_cluster ;;
        0)
            print_success "退出"
            exit 0
            ;;
        *)
            print_error "无效选择"
            ;;
    esac
    
    echo ""
    read -p "按回车键继续..."
done
