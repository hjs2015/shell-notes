# 📝 提交信息指南

> 规范的 Commit Message 格式

**详细指南**：[CONTRIBUTING_DETAILED.md](../guides/CONTRIBUTING_DETAILED.md)

---

## 📋 格式规范

### 基本格式

```
<type>: <subject>

[optional body]

[optional footer]
```

### 示例

```bash
feat: 添加用户登录脚本

- 实现用户名密码验证
- 添加错误处理
- 包含使用示例

Fixes #123
```

---

## 🎯 Type 类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat: 添加密码验证器脚本` |
| `fix` | Bug 修复 | `fix: 修复文件权限检查错误` |
| `docs` | 文档更新 | `docs: 更新 README 学习路径` |
| `style` | 代码格式 | `style: 格式化缩进和空格` |
| `refactor` | 代码重构 | `refactor: 优化循环结构` |
| `test` | 测试相关 | `test: 添加脚本测试用例` |
| `chore` | 构建/工具 | `chore: 更新.gitignore` |
| `perf` | 性能优化 | `perf: 优化字符串处理速度` |
| `ci` | CI/CD | `ci: 添加 GitHub Actions 配置` |

---

## ✍️ Subject 规则

### 必须遵守

- ✅ 使用祈使句："add" 而不是 "added" 或 "adds"
- ✅ 首字母小写
- ✅ 结尾不加句号
- ✅ 简洁明了（50 字符以内）

### 示例对比

```bash
# ✅ 正确
feat: 添加密码验证器脚本
fix: 修复文件权限检查的逻辑错误
docs: 更新 README 中的学习资源
refactor: 优化幸运抽奖的代码结构

# ❌ 错误
feat: 添加了密码验证器脚本
feat: 密码验证器脚本
feat: 添加密码验证器脚本。
更新
修改了一些东西
```

---

## 📚 相关资源

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Commit Message Guide](https://chris.beams.io/posts/git-commit/)

---

**返回快速指南**：[CONTRIBUTING.md](../../CONTRIBUTING.md)
