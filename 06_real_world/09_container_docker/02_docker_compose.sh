#!/bin/bash
# ============================================================================
# 脚本名称：02_docker_compose.sh
# 功能描述：Docker Compose 实战 - 多容器编排、服务管理、生产部署
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：Docker Compose、服务编排、网络配置、数据卷、生产部署
# 使用方法：bash 02_docker_compose.sh
# 依赖命令：docker, docker-compose
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================================================${NC}"
}

print_header "📌 Docker Compose 实战 - 多容器编排"

# ------------------------------------------------------------------------------
# 1. Docker Compose 简介
# ------------------------------------------------------------------------------
print_header "🔹 Docker Compose 简介"

cat << 'EOF'
Docker Compose 是用于定义和运行多容器 Docker 应用的工具。
使用 YAML 文件配置应用服务，然后一条命令创建所有服务。

核心概念：
- Service（服务）：应用的组件（如 web、db）
- Network（网络）：服务间通信
- Volume（数据卷）：持久化数据
- Environment（环境变量）：配置参数
EOF
echo ""

# 检查 Docker Compose
if command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}【Docker Compose 版本】${NC}"
    docker-compose --version
    echo ""
elif docker compose version &> /dev/null; then
    echo -e "${YELLOW}【Docker Compose 版本】${NC}"
    docker compose version
    echo ""
else
    echo -e "${RED}⚠️  Docker Compose 未安装${NC}"
    echo "安装：pip install docker-compose"
    echo ""
fi

# ------------------------------------------------------------------------------
# 2. docker-compose.yml 示例
# ------------------------------------------------------------------------------
print_header "🔹 docker-compose.yml 示例"

COMPOSE_DIR="/tmp/docker_compose_demo"
mkdir -p "$COMPOSE_DIR"

cat > "$COMPOSE_DIR/docker-compose.yml" << 'EOF'
version: '3.8'

services:
  # Web 服务（Nginx）
  web:
    image: nginx:alpine
    container_name: my_web
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html:ro
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    networks:
      - app_network
    depends_on:
      - api
    restart: unless-stopped

  # API 服务（Python Flask）
  api:
    build: ./api
    container_name: my_api
    environment:
      - FLASK_ENV=production
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
    networks:
      - app_network
    depends_on:
      - db
    restart: unless-stopped

  # 数据库服务（PostgreSQL）
  db:
    image: postgres:13-alpine
    container_name: my_db
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - app_network
    restart: unless-stopped

  # 缓存服务（Redis）
  cache:
    image: redis:6-alpine
    container_name: my_cache
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - app_network
    restart: unless-stopped

networks:
  app_network:
    driver: bridge

volumes:
  postgres_data:
  redis_data:
EOF

echo -e "${YELLOW}【创建示例 docker-compose.yml】${NC}"
echo "路径：$COMPOSE_DIR/docker-compose.yml"
echo ""
echo "文件内容："
cat "$COMPOSE_DIR/docker-compose.yml"
echo ""

# ------------------------------------------------------------------------------
# 3. 常用命令
# ------------------------------------------------------------------------------
print_header "🔹 常用命令"

cat << 'EOF'
# 启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 重启服务
docker-compose restart

# 停止所有服务
docker-compose down

# 停止并删除数据卷
docker-compose down -v

# 重新构建并启动
docker-compose up -d --build

# 查看资源使用
docker-compose top

# 进入容器
docker-compose exec api bash

# 查看服务配置
docker-compose config
EOF
echo ""

# ------------------------------------------------------------------------------
# 4. 环境变量管理
# ------------------------------------------------------------------------------
print_header "🔹 环境变量管理"

cat > "$COMPOSE_DIR/.env" << 'EOF'
# 应用配置
APP_ENV=production
APP_DEBUG=false

# 数据库配置
DB_HOST=db
DB_PORT=5432
DB_USER=user
DB_PASSWORD=secure_password_here
DB_NAME=mydb

# Redis 配置
REDIS_HOST=cache
REDIS_PORT=6379

# Nginx 配置
NGINX_PORT=8080
EOF

echo -e "${YELLOW}【创建 .env 文件】${NC}"
echo "路径：$COMPOSE_DIR/.env"
echo ""
cat "$COMPOSE_DIR/.env"
echo ""

cat << 'EOF'
在 docker-compose.yml 中使用环境变量：
${APP_ENV}
${DB_HOST}
${DB_PORT}
EOF
echo ""

# ------------------------------------------------------------------------------
# 5. 网络配置
# ------------------------------------------------------------------------------
print_header "🔹 网络配置"

cat << 'EOF'
Docker Compose 网络类型：

1. bridge（默认）
   - 容器在同一桥接网络上可互相访问
   - 通过服务名 DNS 解析

2. host
   - 容器使用主机网络
   - 性能更好，但端口可能冲突

3. none
   - 无网络
   - 完全隔离

4. external
   - 使用已存在的网络
   - 适合多 compose 文件共享

示例：
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
  external_network:
    external: true
EOF
echo ""

# ------------------------------------------------------------------------------
# 6. 数据卷管理
# ------------------------------------------------------------------------------
print_header "🔹 数据卷管理"

cat << 'EOF'
数据卷类型：

1. 命名卷（推荐）
   volumes:
     - db_data:/var/lib/mysql
   volumes:
     db_data:

2. 绑定挂载
   volumes:
     - ./data:/var/lib/mysql

3. 临时卷
   volumes:
     - type: tmpfs
       target: /tmp

数据卷命令：
- docker volume ls          # 列出所有卷
- docker volume inspect     # 查看卷详情
- docker volume rm          # 删除卷
- docker-compose volume ls  # Compose 管理的卷
EOF
echo ""

# ------------------------------------------------------------------------------
# 7. 健康检查
# ------------------------------------------------------------------------------
print_header "🔹 健康检查配置"

cat << 'EOF'
在 docker-compose.yml 中添加健康检查：

services:
  db:
    image: postgres:13
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  api:
    build: ./api
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

查看健康状态：
docker-compose ps
docker inspect --format='{{.State.Health.Status}}' container_name
EOF
echo ""

# ------------------------------------------------------------------------------
# 8. 多环境配置
# ------------------------------------------------------------------------------
print_header "🔹 多环境配置"

cat << 'EOF'
使用多个 compose 文件：

# 开发环境
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# 生产环境
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

docker-compose.dev.yml 示例：
version: '3.8'
services:
  api:
    environment:
      - FLASK_ENV=development
    volumes:
      - ./api:/app
    ports:
      - "5000:5000"

docker-compose.prod.yml 示例：
version: '3.8'
services:
  api:
    environment:
      - FLASK_ENV=production
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
EOF
echo ""

# ------------------------------------------------------------------------------
# 9. 生产部署最佳实践
# ------------------------------------------------------------------------------
print_header "🔹 生产部署最佳实践"

cat << 'EOF'
✅ 推荐做法：

1. 使用具体版本号
   image: nginx:1.21-alpine  # 而非 latest

2. 添加健康检查
   healthcheck:
     test: ["CMD", "curl", "-f", "http://localhost/health"]

3. 限制资源使用
   deploy:
     resources:
       limits:
         cpus: '0.5'
         memory: 512M

4. 使用命名卷持久化数据
   volumes:
     - db_data:/var/lib/mysql

5. 配置日志驱动
   logging:
     driver: json-file
     options:
       max-size: "10m"
       max-file: "3"

6. 使用 restart 策略
   restart: unless-stopped

7. 敏感信息用 secrets
   secrets:
     - db_password

8. 多阶段构建减小镜像
   FROM node:14 AS builder
   FROM alpine:3.14
EOF
echo ""

# ------------------------------------------------------------------------------
# 10. 实用脚本模板
# ------------------------------------------------------------------------------
print_header "🔹 实用脚本模板"

cat << 'EOF'
#!/bin/bash
# Docker Compose 部署脚本

deploy() {
    echo "🚀 开始部署..."
    docker-compose pull
    docker-compose up -d --build
    docker-compose ps
}

backup() {
    echo "💾 备份数据卷..."
    docker run --rm \
        -v $(docker volume ls -q -f name=postgres_data):/source \
        -v $(pwd):/backup \
        alpine tar czf /backup/db_backup.tar.gz -C /source .
}

restore() {
    echo "📥 恢复数据卷..."
    docker-compose down
    docker run --rm \
        -v $(docker volume ls -q -f name=postgres_data):/target \
        -v $(pwd):/backup \
        alpine tar xzf /backup/db_backup.tar.gz -C /target
    docker-compose up -d
}

logs() {
    docker-compose logs -f --tail=100 "$@"
}

case "$1" in
    deploy) deploy ;;
    backup) backup ;;
    restore) restore ;;
    logs) logs $2 ;;
    *) echo "Usage: $0 {deploy|backup|restore|logs}" ;;
esac
EOF

# ------------------------------------------------------------------------------
# 清理测试环境
# ------------------------------------------------------------------------------
print_header "🧹 清理测试环境"
rm -rf "$COMPOSE_DIR"
echo "已删除：$COMPOSE_DIR"

print_header "✅ Docker Compose 实战学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "1. 开发环境使用绑定挂载便于调试"
echo "2. 生产环境使用命名卷保证数据持久化"
echo "3. 务必配置健康检查和资源限制"
echo "4. 敏感信息使用 secrets 或环境变量"
echo ""
