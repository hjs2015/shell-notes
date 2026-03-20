#!/bin/bash
# =============================================================================
# 脚本名称：01_cicd_basics.sh
# 功能描述：CI/CD 流水线基础 - 持续集成与部署概念
# 难度等级：⭐⭐⭐⭐ 高级
# 所属阶段：阶段 7 - 实战项目
# 知识点：
#   - CI/CD 基本概念
#   - Jenkins Pipeline 示例
#   - GitLab CI 示例
#   - 自动化部署流程
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "CI/CD 流水线基础演示"
print_separator

print_color YELLOW "\n【知识点 1】CI/CD 基本概念"
cat << 'EOF'
CI (持续集成):
  - 代码频繁合并到主干
  - 自动构建和测试
  - 快速发现问题

CD (持续部署):
  - 自动部署到测试环境
  - 自动部署到生产环境
  - 减少人工干预
EOF

print_color YELLOW "\n【知识点 2】典型 CI/CD 流程"
cat << 'EOF'
1. 开发者推送代码到 Git
2. 触发 CI 流水线
3. 自动构建项目
4. 运行单元测试
5. 代码质量检查 (SonarQube)
6. 构建 Docker 镜像
7. 推送到镜像仓库
8. 部署到测试环境
9. 自动化测试
10. 部署到生产环境
EOF

print_color YELLOW "\n【示例 3】Jenkins Pipeline 示例"
cat << 'EOF'
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/user/repo.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
EOF

print_color YELLOW "\n【示例 4】GitLab CI 示例 (.gitlab-ci.yml)"
cat << 'EOF'
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - mvn clean package

test_job:
  stage: test
  script:
    - mvn test

deploy_job:
  stage: deploy
  script:
    - ./deploy.sh
  only:
    - main
EOF

print_color YELLOW "\n【示例 5】Shell 自动化部署脚本示例"
cat << 'EOF'
#!/bin/bash
# deploy.sh - 自动化部署脚本

set -e  # 遇到错误立即退出

echo "【1/4】拉取最新代码..."
git pull origin main

echo "【2/4】安装依赖..."
npm install

echo "【3/4】构建项目..."
npm run build

echo "【4/4】重启服务..."
sudo systemctl restart myapp

echo "部署完成！"
EOF

print_color GREEN "\n演示完成！"
print_separator
