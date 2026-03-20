#!/bin/bash
# =============================================================================
# 脚本名称：01_docker_basics.sh
# 功能描述：Docker 容器管理基础 - 容器与镜像操作
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 7 - 实战项目
# 知识点：
#   - docker ps 查看容器
#   - docker images 查看镜像
#   - docker run 运行容器
#   - docker exec 进入容器
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "Docker 容器管理基础演示"
print_separator

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    print_color YELLOW "\n⚠️  Docker 未安装，显示模拟输出"
    echo ""
    echo "【命令】docker --version"
    echo "Docker version 24.0.7, build afdd53b"
    echo ""
    echo "【命令】docker ps -a"
    echo "CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS   NAMES"
    echo ""
    echo "【命令】docker images"
    echo "REPOSITORY   TAG       IMAGE ID   CREATED   SIZE"
    echo ""
else
    print_color YELLOW "\n【示例 1】查看 Docker 版本"
    echo "命令：docker --version"
    docker --version
    
    print_color YELLOW "\n【示例 2】查看运行中的容器"
    echo "命令：docker ps"
    docker ps
    
    print_color YELLOW "\n【示例 3】查看所有容器（包括停止的）"
    echo "命令：docker ps -a"
    docker ps -a
    
    print_color YELLOW "\n【示例 4】查看本地镜像"
    echo "命令：docker images"
    docker images
fi

print_color YELLOW "\n【示例 5】常用 Docker 命令速查"
cat << 'EOF'
docker run -d nginx              # 后台运行 nginx 容器
docker stop <container_id>       # 停止容器
docker start <container_id>      # 启动容器
docker rm <container_id>         # 删除容器
docker rmi <image_id>            # 删除镜像
docker exec -it <id> bash        # 进入容器
docker logs <container_id>       # 查看日志
docker inspect <container_id>    # 查看详细信息
docker-compose up -d             # 启动 compose 服务
docker-compose down              # 停止 compose 服务
EOF

print_color GREEN "\n演示完成！"
print_separator
