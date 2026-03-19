# 🤝 贡献指南

感谢你对 shell-notes 项目的关注！欢迎贡献你的力量和智慧。

## 📋 目录

- [贡献方式](#贡献方式)
- [开发环境设置](#开发环境设置)
- [代码规范](#代码规范)
- [安全规范](#安全规范) 🔒
- [提交规范](#提交规范)
- [Pull Request 流程](#pull-request-流程)

---

## 🎯 贡献方式

你可以通过以下方式贡献：

### 1. 添加新脚本

- 创建新的 Shell 脚本案例
- 确保脚本有实际应用价值
- 添加详细的中文注释
- 遵循现有的目录结构

### 2. 改进注释

- 完善现有脚本的注释
- 修正错误的说明
- 添加更多使用示例
- 补充知识点说明

### 3. 修复 Bug

- 修复脚本中的错误
- 改进代码的可读性
- 优化性能

### 4. 改进文档

- 更新 README.md
- 完善学习指南
- **为目录添加/更新 README.md** 🆕
- 添加新的学习资源
- 修正文档错误

**目录 README 规范**:
- 包含脚本清单表格
- 列出学习目标
- 详解知识点
- 提供示例代码
- 设计练习任务
- 说明最佳实践
- 列出常见错误
- 提供扩展阅读

### 5. 提出建议

- 提交 Issue 提出改进建议
- 参与讨论
- 分享使用心得

---

## 💻 开发环境设置

### 1. Fork 仓库

```bash
# 在 GitHub 上 Fork 本仓库
# 访问 https://github.com/hjs2015/shell-notes
# 点击右上角的 Fork 按钮
```

### 2. 克隆到本地

```bash
# 克隆你的 Fork
git clone https://github.com/YOUR_USERNAME/shell-notes.git
cd shell-notes

# 添加上游仓库
git remote add upstream https://github.com/hjs2015/shell-notes.git
```

### 3. 创建分支

```bash
# 创建新分支
git checkout -b feature/your-feature-name

# 或者修复 Bug
git checkout -b fix/bug-fix-name
```

### 4. 开发和测试

```bash
# 编写代码
# 测试脚本功能
chmod +x your_script.sh
./your_script.sh

# 确保没有语法错误
bash -n your_script.sh
```

### 5. 提交更改

```bash
# 添加更改
git add .

# 提交（遵循提交规范）
git commit -m "feat: 添加 xxx 脚本"

# 推送到远程
git push origin feature/your-feature-name
```

### 6. 创建 Pull Request

```bash
# 在 GitHub 上创建 Pull Request
# 访问 https://github.com/hjs2015/shell-notes/pulls
# 点击 "New Pull Request"
```

---

## 📝 代码规范

### 脚本命名

```bash
# ✅ 好的命名
01_hello_world.sh
02_special_variables.sh
08_guess_number_game.sh

# ❌ 不好的命名
1.shell
test.sh
aaa.sh
```

**规则：**
- 使用语义化命名
- 两位数字前缀（01, 02, 03...）
- 单词间用下划线分隔
- 全部小写

### 注释规范

每个脚本必须包含以下注释：

```bash
#!/bin/bash
# =============================================================================
# 脚本名称：xxx.sh
# 功能描述：一句话描述脚本功能
# 难度等级：⭐ ~ ⭐⭐⭐⭐⭐
# 知识点：
#   - 知识点 1
#   - 知识点 2
# 使用方法：
#   chmod +x xxx.sh
#   ./xxx.sh
# 代码说明：
#   # 详细解释关键代码
# =============================================================================

# 代码内容...
```

### 代码风格

```bash
# ✅ 好的风格
if [ -f "$file" ]; then
    echo "文件存在"
fi

# 使用有意义的变量名
user_name="John"
user_age=25

# 适当的空行分隔逻辑块

# ❌ 不好的风格
if [ -f $file ];then echo "文件存在";fi

# 无意义的变量名
a="John"
b=25
```

### 错误处理

```bash
# ✅ 添加错误检查
if [ ! -f "$config_file" ]; then
    echo "错误：配置文件不存在"
    exit 1
fi

# 检查命令执行结果
command || {
    echo "命令执行失败"
    exit 1
}
```

---

## 🔒 安全规范

**⚠️ 极其重要：禁止提交敏感信息！**

### 禁止提交的内容

**绝对不要提交**：

- ❌ 真实 IP 地址（公网/内网）
- ❌ 真实主机名
- ❌ 真实密码/密钥
- ❌ 真实域名
- ❌ 真实邮箱地址
- ❌ 真实手机号
- ❌ AWS/GCP/Azure 凭证
- ❌ GitHub Token
- ❌ 数据库连接字符串
- ❌ API Key/Secret

### 示例代码规范

**必须使用示例值**：

```bash
# ✅ 正确 - 使用示例 IP
外网 IP: 192.168.1.100 (示例)
内网 IP: 10.0.0.50 (示例)
主机名：web-server-01

# ✅ 正确 - 使用占位符
数据库地址：${DB_HOST}
API Key: ${API_KEY}

# ❌ 错误 - 使用真实信息
外网 IP: 116.24.66.xxx (示例格式)
内网 IP: 10.128.0.xxx (示例格式)
主机名：your-hostname
密码：your-password
```

### 推荐示例值

| 类型 | 示例值 |
|------|--------|
| 公网 IP | `192.168.1.100`, `203.0.113.50` |
| 内网 IP | `10.0.0.50`, `172.16.0.100` |
| 主机名 | `web-server-01`, `db-master`, `cache-01` |
| 域名 | `example.com`, `test.local` |
| 邮箱 | `user@example.com` |
| 端口 | `8080`, `3306`, `5432` |

### Pre-commit 检查

项目包含 pre-commit 钩子，自动检查敏感信息：

```bash
# 钩子会自动检查：
# - IP 地址
# - 主机名
# - 密码/密钥
# - Token
```

### 泄露处理

如果不慎提交敏感信息：

1. **立即删除** - 修改文件移除敏感信息
2. **强制推送** - `git push -f` 清除历史
3. **更换凭证** - 如已泄露立即更换
4. **报告事件** - 创建安全事件报告

---

## 📋 提交规范

### Commit Message 格式

```
<type>: <subject>

[optional body]
```

### Type 类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat: 添加用户登录脚本` |
| `fix` | Bug 修复 | `fix: 修复猜数字游戏的边界问题` |
| `docs` | 文档更新 | `docs: 更新 README 学习路径` |
| `style` | 代码格式 | `style: 格式化缩进` |
| `refactor` | 代码重构 | `refactor: 优化循环结构` |
| `test` | 测试相关 | `test: 添加脚本测试用例` |
| `chore` | 构建/工具 | `chore: 更新.gitignore` |

### Subject 规则

- 使用祈使句："add" 而不是 "added" 或 "adds"
- 首字母小写
- 结尾不加句号
- 简洁明了（50 字符以内）

### 示例

```bash
# ✅ 好的提交
feat: 添加密码验证器脚本
fix: 修复文件权限检查的逻辑错误
docs: 更新 README 中的学习资源
refactor: 优化幸运抽奖的代码结构

# ❌ 不好的提交
更新
修改了一些东西
添加了新功能
```

---

## 🔄 Pull Request 流程

### 1. 创建 PR

- 访问你的 Fork 仓库
- 点击 "Pull requests" → "New pull request"
- 选择分支并创建 PR

### 2. 填写 PR 描述

```markdown
## 描述
简要描述你的更改

## 相关 Issue
Fixes #123

## 更改类型
- [ ] 新功能
- [ ] Bug 修复
- [ ] 文档更新
- [ ] 代码重构
- [ ] 其他

## 测试
- [ ] 已测试脚本功能
- [ ] 已检查语法错误
- [ ] 已更新文档

## 截图（如适用）
添加截图展示更改效果
```

### 3. Code Review

- 等待维护者审查
- 根据反馈修改代码
- 通过审查后合并

### 4. 合并后

- 删除特性分支
- 同步上游仓库

```bash
# 同步上游仓库
git fetch upstream
git checkout main
git merge upstream/main
```

---

## 📚 资源

- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Bash 最佳实践](https://google.github.io/styleguide/shellguide.html)

---

## ❓ 常见问题

### Q: 我可以添加自己的脚本吗？

A: 当然可以！只要脚本有学习价值，遵循代码规范，欢迎提交。

### Q: 注释需要多详细？

A: 越详细越好。想象你在教一个完全不懂 Shell 的人。

### Q: 如何测试我的脚本？

A: 在多个 Linux 发行版上测试（Ubuntu, CentOS, Debian 等）。

### Q: PR 多久会被审查？

A: 通常在 1-3 个工作日内。请耐心等待。

### Q: 如何为目录添加 README？

A: 参考现有目录 README 的格式（如 `09_devops/README.md`），包含：
- 脚本清单表格
- 学习目标
- 知识点详解
- 示例代码
- 练习任务
- 最佳实践
- 常见错误
- 扩展阅读

---

## 🙏 致谢

感谢所有贡献者！你的每一份贡献都让这个项目变得更好。

**特别感谢**: 为目录 README 文档做出贡献的开发者们 🆕

[返回顶部](#-贡献指南)

---

**最后更新**: 2026-03-18  
**最新提交**: a7910c8 - docs: 为所有目录添加 README 说明文档
