# 🤝 贡献指南

感谢你对 shell-notes 项目的关注！欢迎贡献你的力量和智慧。

---

## 🎯 快速开始

### 贡献流程

```bash
# 1. Fork 仓库
在 GitHub 上点击 Fork 按钮

# 2. 克隆到本地
git clone https://github.com/YOUR_USERNAME/shell-notes.git
cd shell-notes

# 3. 创建分支
git checkout -b feature/your-feature-name

# 4. 开发和测试
# 编写代码并测试

# 5. 提交更改
git add .
git commit -m "feat: 添加 xxx 脚本"
git push origin feature/your-feature-name

# 6. 创建 Pull Request
在 GitHub 上创建 PR
```

---

## 📝 核心规范

### 1. 脚本命名

```bash
# ✅ 正确
01_hello_world.sh
02_special_variables.sh

# ❌ 错误
1.shell
test.sh
```

**规则**：
- 语义化命名
- 两位数字前缀（01, 02, 03...）
- 下划线分隔单词
- 全部小写

### 2. 注释要求

每个脚本必须包含：

```bash
#!/bin/bash
# =============================================================================
# 脚本名称：xxx.sh
# 功能描述：一句话描述
# 难度等级：⭐ ~ ⭐⭐⭐⭐⭐
# 知识点：
#   - 知识点 1
#   - 知识点 2
# 使用方法：
#   chmod +x xxx.sh
#   ./xxx.sh
# =============================================================================
```

### 3. 提交信息

```bash
# ✅ 正确
feat: 添加密码验证器脚本
fix: 修复文件权限检查错误
docs: 更新 README 学习路径

# ❌ 错误
更新
修改了一些东西
```

**类型**：`feat` | `fix` | `docs` | `style` | `refactor` | `chore`

### 4. 安全要求

**⚠️ 禁止提交敏感信息**：

- ❌ 真实 IP 地址
- ❌ 真实主机名
- ❌ 密码/密钥
- ❌ 真实邮箱/手机号
- ❌ API Key/Token

**使用示例值**：
- IP：`192.168.1.100`, `10.0.0.50`
- 主机名：`web-server-01`
- 邮箱：`user@example.com`

---

## 📚 详细文档

| 文档 | 说明 |
|------|------|
| [docs/guides/CONTRIBUTING_DETAILED.md](docs/guides/CONTRIBUTING_DETAILED.md) | 详细贡献指南（开发环境/代码规范/安全规范/PR 流程） |
| [docs/reference/SECURITY_CHECKLIST.md](docs/reference/SECURITY_CHECKLIST.md) | 安全检查清单（提交前必查） |
| [docs/reference/COMMIT_MESSAGE_GUIDE.md](docs/reference/COMMIT_MESSAGE_GUIDE.md) | 提交信息完整指南 |

---

## ❓ 常见问题

**Q: 我可以添加自己的脚本吗？**  
A: 当然可以！只要有学习价值，遵循规范即可。

**Q: 注释需要多详细？**  
A: 越详细越好，想象你在教一个完全不懂 Shell 的人。

**Q: PR 多久会被审查？**  
A: 通常 1-3 个工作日。

---

## 🙏 致谢

感谢所有贡献者！你的每一份贡献都让这个项目变得更好。

---

**详细指南**：[docs/guides/CONTRIBUTING_DETAILED.md](docs/guides/CONTRIBUTING_DETAILED.md)  
**安全检查**：[docs/reference/SECURITY_CHECKLIST.md](docs/reference/SECURITY_CHECKLIST.md)
