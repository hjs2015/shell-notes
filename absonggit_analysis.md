# 📋 absonggit/test 脚本分析报告

**仓库**: https://github.com/absonggit/test  
**分析时间**: 2026-03-19  
**目的**: 学习优秀写法，优化 shell-notes 仓库

---

## ✅ 值得学习的优点

### 1. 函数化组织 ⭐⭐⭐⭐⭐

**特点**: 每个功能封装成独立函数

```bash
# check.sh 示例
ip_check () {
    echo "外网 IP:$(curl -s ip.sb)"
    # ...
}

netstat_check () {
    # ...
}

hosts_check () {
    # ...
}

# 主程序调用
ip_check
netstat_check
hosts_check
```

**优点**:
- ✅ 结构清晰，一目了然
- ✅ 函数可复用
- ✅ 易于测试和维护
- ✅ 可以按需调用特定函数

**我们的现状**:
- 部分脚本使用了函数（如 09_devops/）
- 但很多基础脚本还是线性结构
- 需要加强函数化组织

---

### 2. 格式化输出 ⭐⭐⭐⭐⭐

**特点**: 使用 printf 进行对齐输出

```bash
printf "%-15s %-15s %-30s %-15s\n" 状态 端口 配置文件 Server_Name
printf "%-15s %-10s %-30s %-15s\n" 已监听 ${port} ${conf} ${server_name}
```

**输出效果**:
```
状态            端口            配置文件                       Server_Name
已监听          80             vhost.conf                    example.com|www.example.com
未监听          443            vhost_ssl.conf                secure.example.com
```

**优点**:
- ✅ 输出整齐美观
- ✅ 易于阅读和对比
- ✅ 专业感强

**我们的现状**:
- 大部分用 echo 输出
- 缺少格式化对齐
- 需要引入 printf 格式化

---

### 3. 分区检测标题 ⭐⭐⭐⭐

**特点**: 使用【】标记检测模块

```bash
echo "【对外放开的服务端口及防火墙规则】"
echo "------------------------------------"

echo "【审计检测】"
echo "-----------------------"

echo "【连接检测】"
echo "-----------------------"
```

**输出效果**:
```
【对外放开的服务端口及防火墙规则】
------------------------------------
端口：80    未添加防火墙规则    nginx

【审计检测】
-----------------------
exe=/usr/sbin/sshd

【连接检测】
-----------------------
tcp  0  0 127.0.0.1:6379  ESTABLISHED
```

**优点**:
- ✅ 模块清晰
- ✅ 视觉分隔明显
- ✅ 便于快速定位信息

**我们的现状**:
- 部分脚本有类似设计
- 但不够统一
- 需要标准化

---

### 4. 实用检测逻辑 ⭐⭐⭐⭐⭐

**特点**: 来自真实运维场景的检测

#### 4.1 防火墙规则检测
```bash
if firewall-cmd --state &> /dev/null
then
    data=($(firewall-cmd --list-port | ...))
else
    data=($(netstat -ntlup | ...))
fi
```

**优点**: 兼容不同防火墙工具

#### 4.2 系统版本判断
```bash
if [[ $(awk -F"[ .]" '{print $4}' /etc/redhat-release) == 7 ]]
then
    # CentOS 7
else
    # CentOS 6
fi
```

**优点**: 自动适配系统版本

#### 4.3 项目文件检测
```bash
for path in $(find /home/wwwroot -mindepth 1 -maxdepth 1 -type d)
do
    file_count=$(find $path -path "$path/runtime" -prune -o -type f -print | wc -l)
    find $path ! -path "$path/runtime/*" -mtime 0 -type f
done
```

**优点**: 实用的项目巡检逻辑

---

### 5. 数组和循环处理 ⭐⭐⭐⭐

**特点**: 批量处理数据

```bash
array=($(egrep -r "^[[:space:]]+listen" /usr/local/nginx/conf/vhost | \
    awk -F"[ :;]+" '$2!="#listen" {print ...}' | xargs))

for i in ${array[@]}
do
    port=$(echo $i | cut -d":" -f 2)
    conf=$(echo $i | cut -d":" -f 1)
    # ...
done
```

**优点**:
- ✅ 高效处理批量数据
- ✅ 代码简洁
- ✅ 性能好

---

### 6. 条件忽略检测 ⭐⭐⭐⭐

**特点**: 排除干扰项

```bash
find / \
    ! -path "/proc/*" \
    ! -path "/sys/*" \
    ! -path "/var/log/*" \
    ! -path "/var/lib/docker/*" \
    -type f -mtime 0
```

**优点**:
- ✅ 排除系统目录
- ✅ 聚焦关键文件
- ✅ 减少噪音

---

## 📊 优化建议

### 优先级 1: 函数化改造 ⭐⭐⭐⭐⭐

**目标**: 将线性脚本改为函数化结构

**改造示例**:

**改造前** (01_basic/02_special_variables.sh):
```bash
#!/bin/bash
echo "脚本名称：$0"
echo "参数个数：$#"
echo "所有参数：$*"
```

**改造后**:
```bash
#!/bin/bash
# =============================================================================
# 脚本名称：02_special_variables.sh
# 功能描述：演示 Shell 特殊变量的使用
# 难度等级：⭐⭐
# =============================================================================

print_script_info() {
    echo "=== 脚本信息 ==="
    echo "脚本名称：$0"
    echo "参数个数：$#"
}

print_arguments() {
    echo "=== 参数列表 ==="
    echo "所有参数 (使用\$*): $*"
    echo "所有参数 (使用\$@): $@"
}

print_process_info() {
    echo "=== 进程信息 ==="
    echo "当前进程 PID: $$"
    echo "上一个命令退出码：$?"
}

# 主程序
print_script_info
print_arguments
print_process_info
```

---

### 优先级 2: 格式化输出 ⭐⭐⭐⭐

**目标**: 引入 printf 格式化

**改造示例**:

**改造前**:
```bash
echo "文件名：$name 大小：$size 修改时间：$mtime"
```

**改造后**:
```bash
printf "%-30s %10s %20s\n" "文件名" "大小 (KB)" "修改时间"
printf "%-30s %10s %20s\n" "$name" "$size" "$mtime"
```

**输出**:
```
文件名                              大小 (KB)           修改时间
config.txt                               128      2026-03-19 10:30
data.log                                2048      2026-03-19 09:15
```

---

### 优先级 3: 统一分区标题 ⭐⭐⭐⭐

**目标**: 标准化输出格式

**规范**:
```bash
echo "【模块名称】"
echo "------------------------------------"
# 内容...
echo ""
```

**示例**:
```bash
echo "【系统信息检测】"
echo "------------------------------------"
# 检测内容...
echo ""

echo "【网络连接检测】"
echo "------------------------------------"
# 检测内容...
echo ""
```

---

### 优先级 4: 增强实用检测 ⭐⭐⭐⭐

**目标**: 添加真实运维场景检测

**新增脚本建议**:

1. **09_devops/06_server_inspection.sh** - 服务器巡检
   - IP 检测
   - 端口检测
   - 防火墙规则检测
   - 进程检测
   - 文件修改检测

2. **09_devops/07_project_check.sh** - 项目巡检
   - 项目文件统计
   - 24 小时修改文件
   - 配置文件检查

3. **09_devops/08_security_audit.sh** - 安全审计
   - sudoers 检查
   - 登录日志检查
   - 异常进程检测

---

## 🎯 行动计划

### 第一阶段：学习吸收 (1-2 天)
- [ ] 分析 absonggit/test 所有脚本
- [ ] 提取可复用的代码片段
- [ ] 设计函数化模板

### 第二阶段：优化现有脚本 (3-5 天)
- [ ] 09_devops 目录优先函数化
- [ ] 添加 printf 格式化输出
- [ ] 统一分区标题格式

### 第三阶段：新增实用脚本 (2-3 天)
- [ ] 服务器巡检脚本
- [ ] 项目检查脚本
- [ ] 安全审计脚本

### 第四阶段：文档更新 (1 天)
- [ ] 更新 09_devops/README.md
- [ ] 添加函数化编程最佳实践
- [ ] 更新示例代码

---

## 📝 代码片段收集

### 1. IP 检测函数
```bash
ip_check () {
    echo "外网 IP:$(curl -s ip.sb)"
    if [[ $(awk -F"[ .]" '{print $4}' /etc/redhat-release) == 7 ]]
    then
        echo "内网 IP:$(ifconfig ens5 | grep inet | grep -v inet6 | awk '$2!="127.0.0.1"{print $2}')"
    else
        echo "内网 IP:$(ifconfig ens5 | grep inet | grep -v inet6 | awk -F"[ :]+" '$4!="127.0.0.1"{print $4}')"
    fi
}
```

### 2. 格式化输出模板
```bash
print_table_header() {
    printf "%-15s %-15s %-30s %-15s\n" "$1" "$2" "$3" "$4"
}

print_table_row() {
    printf "%-15s %-15s %-30s %-15s\n" "$1" "$2" "$3" "$4"
}
```

### 3. 文件检测模板
```bash
check_recent_files() {
    local search_path=$1
    local exclude_pattern=$2
    
    find "$search_path" \
        ! -path "$exclude_pattern" \
        ! -path "/proc/*" \
        ! -path "/sys/*" \
        -type f -mtime 0
}
```

---

**分析完成时间**: 2026-03-19  
**下一步**: 开始优化 09_devops 目录脚本
