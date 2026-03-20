#!/bin/bash
# ============================================================================
# 脚本名称：03_cicd_jenkins.sh
# 功能描述：Jenkins CI/CD 流水线 - 自动化构建、测试、部署
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：Jenkins、CI/CD、流水线、自动化部署
# 使用方法：bash 03_cicd_jenkins.sh
# 依赖命令：curl, docker, git
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

print_header "🚀 Jenkins CI/CD 流水线管理"

# 配置
JENKINS_URL="http://localhost:8080"
JENKINS_USER="admin"
JENKINS_TOKEN=""

# 菜单
show_menu() {
    echo ""
    echo "请选择操作："
    echo "1. 安装 Jenkins（Docker）"
    echo "2. 启动 Jenkins"
    echo "3. 停止 Jenkins"
    echo "4. 查看 Jenkins 状态"
    echo "5. 获取初始管理员密码"
    echo "6. 创建 Job"
    echo "7. 触发构建"
    echo "8. 查看构建状态"
    echo "9. 查看构建日志"
    echo "10. 备份 Jenkins 配置"
    echo "0. 退出"
    echo ""
}

# 安装 Jenkins
install_jenkins() {
    print_header "安装 Jenkins（Docker）"
    
    echo "拉取 Jenkins 镜像..."
    docker pull jenkins/jenkins:lts
    
    echo ""
    echo "创建 Jenkins 数据目录..."
    mkdir -p /opt/jenkins_home
    chmod 777 /opt/jenkins_home
    
    echo ""
    echo "启动 Jenkins 容器..."
    docker run -d \
        --name jenkins \
        -p 8080:8080 \
        -p 50000:50000 \
        -v /opt/jenkins_home:/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        jenkins/jenkins:lts
    
    if [ $? -eq 0 ]; then
        print_success "Jenkins 安装成功"
        echo ""
        echo "访问地址：http://localhost:8080"
        echo "初始密码查看：bash $0 获取初始管理员密码"
    else
        print_error "安装失败"
    fi
}

# 启动 Jenkins
start_jenkins() {
    print_header "启动 Jenkins"
    
    docker start jenkins
    
    if [ $? -eq 0 ]; then
        print_success "Jenkins 已启动"
    else
        print_error "启动失败"
    fi
}

# 停止 Jenkins
stop_jenkins() {
    print_header "停止 Jenkins"
    
    docker stop jenkins
    
    if [ $? -eq 0 ]; then
        print_success "Jenkins 已停止"
    else
        print_error "停止失败"
    fi
}

# 查看状态
jenkins_status() {
    print_header "Jenkins 状态"
    
    echo "=== 容器状态 ==="
    docker ps -a | grep jenkins
    
    echo ""
    echo "=== 端口监听 ==="
    netstat -tuln | grep 8080 || ss -tuln | grep 8080
    
    echo ""
    echo "=== 资源使用 ==="
    docker stats jenkins --no-stream 2>/dev/null
}

# 获取初始密码
get_initial_password() {
    print_header "初始管理员密码"
    
    echo "密码文件位置：/opt/jenkins_home/secrets/initialAdminPassword"
    echo ""
    
    if [ -f /opt/jenkins_home/secrets/initialAdminPassword ]; then
        echo "初始密码："
        cat /opt/jenkins_home/secrets/initialAdminPassword
    else
        print_error "未找到密码文件"
        echo "尝试从容器获取："
        docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null
    fi
}

# 创建 Job
create_job() {
    print_header "创建 Jenkins Job"
    
    read -p "请输入 Job 名称： " job_name
    read -p "请输入 Git 仓库 URL： " git_url
    read -p "请输入分支（默认 master）： " branch
    branch=${branch:-master}
    
    # 创建 Job 配置
    cat > /tmp/job_config.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <description>Auto created by shell script</description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>$git_url</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/$branch</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
  </scm>
  <builders/>
  <publishers/>
  <buildWrappers/>
</project>
EOF
    
    echo ""
    print_warning "手动创建步骤："
    echo "1. 访问 Jenkins Web 界面"
    echo "2. 点击'新建任务'"
    echo "3. 输入名称：$job_name"
    echo "4. 选择'Freestyle project'"
    echo "5. 在'Source Code Management'选择 Git"
    echo "6. 输入仓库 URL: $git_url"
    echo "7. 在'Build Triggers'选择'Poll SCM'"
    echo "8. 在'Build Steps'添加构建步骤"
    
    rm -f /tmp/job_config.xml
}

# 触发构建
trigger_build() {
    print_header "触发构建"
    
    read -p "请输入 Job 名称： " job_name
    
    if [ -z "$JENKINS_TOKEN" ]; then
        read -p "请输入 Jenkins API Token： " JENKINS_TOKEN
    fi
    
    curl -X POST "$JENKINS_URL/job/$job_name/build" \
        --user "$JENKINS_USER:$JENKINS_TOKEN" \
        -v
    
    if [ $? -eq 0 ]; then
        print_success "构建已触发"
    else
        print_error "触发失败"
    fi
}

# 查看构建状态
build_status() {
    print_header "构建状态"
    
    read -p "请输入 Job 名称： " job_name
    
    echo "最近 5 次构建："
    curl -s "$JENKINS_URL/job/$job_name/api/json?tree=builds[number,result,timestamp,duration]" \
        --user "$JENKINS_USER:$JENKINS_TOKEN" 2>/dev/null | \
        python3 -m json.tool 2>/dev/null || echo "无法获取构建状态"
}

# 查看构建日志
build_logs() {
    print_header "构建日志"
    
    read -p "请输入 Job 名称： " job_name
    read -p "请输入构建编号（默认最后一次）： " build_num
    
    if [ -z "$build_num" ]; then
        build_num="lastBuild"
    fi
    
    echo "日志内容："
    curl -s "$JENKINS_URL/job/$job_name/$build_num/consoleText" \
        --user "$JENKINS_USER:$JENKINS_TOKEN" 2>/dev/null | tail -50
}

# 备份配置
backup_jenkins() {
    print_header "备份 Jenkins 配置"
    
    local backup_dir="/backup/jenkins"
    local backup_file="$backup_dir/jenkins_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    mkdir -p "$backup_dir"
    
    echo "正在备份..."
    tar -czf "$backup_file" -C /opt/jenkins_home .
    
    if [ $? -eq 0 ]; then
        print_success "备份成功"
        echo "备份文件：$backup_file"
        echo "文件大小：$(du -h "$backup_file" | cut -f1)"
    else
        print_error "备份失败"
    fi
}

# 主循环
while true; do
    show_menu
    read -p "请选择操作（0-10）： " choice
    
    case $choice in
        1) install_jenkins ;;
        2) start_jenkins ;;
        3) stop_jenkins ;;
        4) jenkins_status ;;
        5) get_initial_password ;;
        6) create_job ;;
        7) trigger_build ;;
        8) build_status ;;
        9) build_logs ;;
        10) backup_jenkins ;;
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
