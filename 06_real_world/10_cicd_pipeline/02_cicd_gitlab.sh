#!/bin/bash
# ============================================================================
# 脚本名称：02_cicd_gitlab.sh
# 功能描述：CI/CD 流水线实战 - GitLab CI 配置、自动构建、自动部署
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：GitLab CI、CI/CD 流水线、自动构建、自动部署、Docker 集成
# 使用方法：bash 02_cicd_gitlab.sh
# 依赖命令：git, docker, curl
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 CI/CD 流水线实战 - GitLab CI"

# ------------------------------------------------------------------------------
# 1. GitLab CI 简介
# ------------------------------------------------------------------------------
print_header "🔹 GitLab CI 简介"

cat << 'EOF'
GitLab CI/CD 是 GitLab 内置的持续集成和持续部署工具。

核心概念：
- .gitlab-ci.yml：CI/CD 配置文件
- Runner：执行 CI/CD 任务的代理
- Pipeline：流水线，包含多个阶段
- Job：作业，流水线中的单个任务
- Stage：阶段，组织作业的逻辑分组

基本流程：
代码提交 → 触发 Pipeline → 执行 Jobs → 部署/测试 → 结果反馈
EOF
echo ""

# ------------------------------------------------------------------------------
# 2. .gitlab-ci.yml 基础示例
# ------------------------------------------------------------------------------
print_header "🔹 .gitlab-ci.yml 基础示例"

cat > /tmp/gitlab-ci-basic.yml << 'EOF'
# 基础 CI/CD 配置示例

stages:
  - build
  - test
  - deploy

# 构建阶段
build_job:
  stage: build
  script:
    - echo "开始构建..."
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week

# 测试阶段
test_job:
  stage: test
  script:
    - echo "开始测试..."
    - npm run test
  dependencies:
    - build_job

# 部署阶段
deploy_job:
  stage: deploy
  script:
    - echo "开始部署..."
    - ./deploy.sh
  only:
    - main
  environment:
    name: production
    url: https://example.com
EOF

echo -e "${YELLOW}【基础配置示例】${NC}"
cat /tmp/gitlab-ci-basic.yml
echo ""

# ------------------------------------------------------------------------------
# 3. 多环境部署
# ------------------------------------------------------------------------------
print_header "🔹 多环境部署"

cat > /tmp/gitlab-ci-multi-env.yml << 'EOF'
# 多环境部署配置

stages:
  - build
  - test
  - deploy:dev
  - deploy:staging
  - deploy:prod

# 开发环境
deploy_dev:
  stage: deploy:dev
  script:
    - echo "部署到开发环境"
    - ./deploy.sh dev
  only:
    - develop
  environment:
    name: development
    url: https://dev.example.com

# 预发布环境
deploy_staging:
  stage: deploy:staging
  script:
    - echo "部署到预发布环境"
    - ./deploy.sh staging
  only:
    - release/*
  environment:
    name: staging
    url: https://staging.example.com

# 生产环境
deploy_prod:
  stage: deploy:prod
  script:
    - echo "部署到生产环境"
    - ./deploy.sh production
  only:
    - main
  when: manual  # 手动触发
  environment:
    name: production
    url: https://example.com
EOF

echo -e "${YELLOW}【多环境配置】${NC}"
cat /tmp/gitlab-ci-multi-env.yml
echo ""

# ------------------------------------------------------------------------------
# 4. Docker 集成
# ------------------------------------------------------------------------------
print_header "🔹 Docker 集成"

cat > /tmp/gitlab-ci-docker.yml << 'EOF'
# Docker 集成配置

image: docker:latest

services:
  - docker:dind

variables:
  DOCKER_HOST: tcp://docker:2375
  DOCKER_TLS_CERTDIR: ""

stages:
  - build
  - test
  - deploy

# 构建 Docker 镜像
build_image:
  stage: build
  script:
    - docker build -t myapp:$CI_COMMIT_SHA .
    - docker tag myapp:$CI_COMMIT_SHA registry.example.com/myapp:$CI_COMMIT_SHA
  only:
    - main
    - develop

# 推送镜像
push_image:
  stage: test
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker push registry.example.com/myapp:$CI_COMMIT_SHA
  dependencies:
    - build_image

# 部署容器
deploy_container:
  stage: deploy
  script:
    - docker pull registry.example.com/myapp:$CI_COMMIT_SHA
    - docker stop myapp || true
    - docker rm myapp || true
    - docker run -d --name myapp -p 80:80 registry.example.com/myapp:$CI_COMMIT_SHA
  only:
    - main
EOF

echo -e "${YELLOW}【Docker 集成配置】${NC}"
cat /tmp/gitlab-ci-docker.yml
echo ""

# ------------------------------------------------------------------------------
# 5. 缓存和依赖
# ------------------------------------------------------------------------------
print_header "🔹 缓存和依赖"

cat > /tmp/gitlab-ci-cache.yml << 'EOF'
# 缓存配置示例

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/
    - .npm/

stages:
  - install
  - build
  - test

# 安装依赖
install_deps:
  stage: install
  script:
    - npm ci --cache .npm
  cache:
    key: npm-cache
    paths:
      - node_modules/
      - .npm/

# 构建
build:
  stage: build
  script:
    - npm run build
  dependencies:
    - install_deps

# 测试
test:
  stage: test
  script:
    - npm test
  dependencies:
    - build
EOF

echo -e "${YELLOW}【缓存配置】${NC}"
cat /tmp/gitlab-ci-cache.yml
echo ""

# ------------------------------------------------------------------------------
# 6. 变量和密钥管理
# ------------------------------------------------------------------------------
print_header "🔹 变量和密钥管理"

cat > /tmp/gitlab-ci-variables.yml << 'EOF'
# 变量管理示例

variables:
  NODE_ENV: production
  APP_VERSION: "1.0.0"

stages:
  - build
  - deploy

build_job:
  stage: build
  script:
    - echo "构建版本：$APP_VERSION"
    - echo "环境：$NODE_ENV"
    # 使用 CI/CD 变量（在 GitLab UI 中配置）
    - echo "API Key: $API_KEY"
    - echo "Database URL: $DATABASE_URL"

deploy_job:
  stage: deploy
  script:
    - echo "部署到：$DEPLOY_ENV"
  only:
    - main
  variables:
    DEPLOY_ENV: production
EOF

echo -e "${YELLOW}【变量管理】${NC}"
cat /tmp/gitlab-ci-variables.yml
echo ""

echo -e "${YELLOW}【配置 CI/CD 变量】${NC}"
echo "1. 进入 GitLab 项目 → Settings → CI/CD"
echo "2. 展开 Variables"
echo "3. 添加变量（如 API_KEY, DATABASE_URL）"
echo "4. 选择是否保护变量（仅保护分支可用）"
echo ""

# ------------------------------------------------------------------------------
# 7. 流水线优化
# ------------------------------------------------------------------------------
print_header "🔹 流水线优化"

cat > /tmp/gitlab-ci-optimized.yml << 'EOF'
# 优化配置示例

stages:
  - lint
  - test
  - build
  - deploy

# 并行测试
test_unit:
  stage: test
  script:
    - npm run test:unit
  parallel: 3  # 并行 3 个作业

test_integration:
  stage: test
  script:
    - npm run test:integration

# 条件执行
deploy_prod:
  stage: deploy
  script:
    - ./deploy.sh
  only:
    - main
  when: manual
  allow_failure: false

# 超时设置
long_running_job:
  stage: build
  script:
    - ./build.sh
  timeout: 30 minutes  # 超时时间

# 重试机制
flaky_job:
  stage: test
  script:
    - ./flaky_test.sh
  retry: 2  # 失败重试 2 次
EOF

echo -e "${YELLOW}【优化配置】${NC}"
cat /tmp/gitlab-ci-optimized.yml
echo ""

# ------------------------------------------------------------------------------
# 8. 实用脚本模板
# ------------------------------------------------------------------------------
print_header "🔹 实用脚本模板"

cat << 'EOF'
#!/bin/bash
# CI/CD 部署脚本模板

deploy() {
    local env=$1
    echo "🚀 部署到 $env 环境"
    
    case $env in
        dev)
            echo "部署到开发环境"
            # docker-compose -f docker-compose.dev.yml up -d
            ;;
        staging)
            echo "部署到预发布环境"
            # docker-compose -f docker-compose.staging.yml up -d
            ;;
        prod)
            echo "部署到生产环境"
            # docker-compose -f docker-compose.prod.yml up -d
            ;;
        *)
            echo "未知环境：$env"
            exit 1
            ;;
    esac
}

rollback() {
    local env=$1
    echo "⏪ 回滚 $env 环境"
    # 实现回滚逻辑
}

case "$1" in
    deploy) deploy $2 ;;
    rollback) rollback $2 ;;
    *) echo "Usage: $0 {deploy|rollback} {dev|staging|prod}" ;;
esac
EOF

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/gitlab-ci-*.yml
print_example "清理完成" "rm -f /tmp/gitlab-ci-*.yml"

print_header "✅ CI/CD 流水线实战学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "1. 使用 .gitlab-ci.yml 定义流水线"
echo "2. 配置 GitLab Runner 执行作业"
echo "3. 使用变量管理敏感信息"
echo "4. 多环境部署提高安全性"
echo ""
