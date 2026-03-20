# 🔒 安全检查清单

**提交前必查！**

## ⚠️ 禁止提交

- ❌ 真实 IP 地址
- ❌ 真实主机名
- ❌ 密码/密钥
- ❌ 真实邮箱
- ❌ API Key/Token

## ✅ 使用示例值

- IP: 192.168.1.100, 10.0.0.50
- 主机名：web-server-01
- 邮箱：user@example.com
- Token: your-token-here

## 🔍 自检命令

```bash
# 检查 IP
grep -r "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" --include="*.md" .

# 检查 Token
grep -r "ghp_[a-zA-Z0-9]" --include="*.md" .
```

**详细指南**：[CONTRIBUTING_DETAILED.md](../guides/CONTRIBUTING_DETAILED.md)
