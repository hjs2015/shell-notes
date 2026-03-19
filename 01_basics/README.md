# 📚 基础篇 (Basics)

> **学习第 2-7 天** | 难度：⭐⭐ | 12 个脚本

---

## 📖 简介

基础篇是 Shell 编程的**核心基础**，掌握变量、运算符和输入输出。

**目标**：
- ✅ 掌握变量定义和引用
- ✅ 理解特殊变量的用途
- ✅ 进行算术和逻辑运算
- ✅ 与用户交互（输入输出）

**预计时间**：6 天，每天 1-2 小时

---

## 📁 子目录

```
01_basics/
├── 01_variables/       # 变量定义 (6 个脚本)
├── 02_operators/       # 运算符 (1 个脚本)
└── 03_io/              # 输入输出 (5 个脚本)
```

---

## 🎯 学习目标

完成本阶段后，你将能够：

### 变量操作
- ✅ 定义和使用变量
- ✅ 理解 `$VAR` 和 `${VAR}` 的区别
- ✅ 使用特殊变量 (`$0`, `$1`, `$#`, `$@`, `$*`)
- ✅ 理解变量作用域

### 运算符
- ✅ 算术运算（加减乘除）
- ✅ 逻辑运算（与或非）
- ✅ 字符串操作（拼接、长度）

### 输入输出
- ✅ 使用 `read` 获取用户输入
- ✅ 使用 `echo` 和 `printf` 格式化输出
- ✅ 文件存在性检查
- ✅ 网络连通性测试

---

## 📝 学习路径

### 第 2 天：变量基础

**脚本**：
- [01_variables/01_hello_world.sh](01_variables/01_hello_world.sh) - Hello World 复习
- [01_variables/02_special_variables.sh](01_variables/02_special_variables.sh) - 特殊变量
- [01_variables/06_shell_execution_modes.sh](01_variables/06_shell_execution_modes.sh) - Shell 执行方式

**练习**：
```bash
# 定义变量
name="World"
echo "Hello, $name!"

# 特殊变量
./script.sh arg1 arg2
echo "参数个数：$#"
```

---

### 第 3 天：变量高级操作

**脚本**：
- [01_variables/06_variable_operations.sh](01_variables/06_variable_operations.sh) - 变量操作
- [01_variables/07_boolean_and_logic.sh](01_variables/07_boolean_and_logic.sh) - 布尔逻辑
- [01_variables/08_wildcards_detailed.sh](01_variables/08_wildcards_detailed.sh) - 通配符详解

**练习**：
```bash
# 变量替代
echo "${VAR:-默认值}"

# 布尔运算
[[ true && false ]] && echo "真" || echo "假"
```

---

### 第 4 天：算术运算

**脚本**：
- [02_operators/07_arithmetic.sh](02_operators/07_arithmetic.sh) - 算术运算

**练习**：
```bash
# 算术运算
a=10
b=3
echo $((a + b))  # 13
echo $((a / b))  # 3
echo $((a % b))  # 1

# 自增自减
((a++))
echo $a  # 11
```

---

### 第 5 天：用户输入

**脚本**：
- [03_io/01_name_phone_age.sh](03_io/01_name_phone_age.sh) - 收集用户信息
- [03_io/02_note_search.sh](03_io/02_note_search.sh) - 笔记搜索

**练习**：
```bash
# 读取用户输入
read -p "请输入姓名：" name
read -p "请输入年龄：" age
echo "你好，$name！你今年$age 岁。"
```

---

### 第 6 天：文件和网络检查

**脚本**：
- [03_io/03_file_exist_check.sh](03_io/03_file_exist_check.sh) - 文件检查
- [03_io/04_ping_check.sh](03_io/04_ping_check.sh) - 网络检查

**练习**：
```bash
# 文件存在性检查
if [[ -f "/etc/passwd" ]]; then
    echo "文件存在"
fi

# 网络连通性测试
if ping -c 1 www.baidu.com &>/dev/null; then
    echo "网络正常"
fi
```

---

### 第 7 天：综合练习

**脚本**：
- [03_io/05_user_info_complete.sh](03_io/05_user_info_complete.sh) - 完整用户信息

**项目**：
创建一个个人信息收集脚本：
```bash
#!/bin/bash
# 收集用户姓名、年龄、邮箱
# 验证输入格式
# 保存到文件
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 定义和使用变量（包括特殊变量）
- [ ] 进行算术和逻辑运算
- [ ] 使用 `read` 获取用户输入
- [ ] 使用 `echo` 和 `printf` 格式化输出
- [ ] 检查文件存在性
- [ ] 测试网络连通性
- [ ] 编写 50 行以上的脚本

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[02_control_flow/](../02_control_flow/)** - 流程控制（第 8-21 天）

你将学习：
- 条件判断（if/else）
- 循环结构（for/while/until）
- 选择结构（case）
- 函数定义和调用

---

## 💡 小贴士

1. **变量命名** - 使用有意义的变量名，如 `user_name` 而非 `a`
2. **引用变量** - 始终用双引号包裹变量：`"$VAR"`
3. **算术运算** - 使用 `$(())` 而非 `let`
4. **输入验证** - 始终验证用户输入
5. **错误处理** - 检查命令返回值

---

## 📚 参考资源

- [Bash 变量指南](https://www.gnu.org/software/bash/manual/)
- [算术运算详解](https://www.runoob.com/linux/linux-shell.html)
- [快速参考手册](../appendices/cheatsheet.md)
- [常见问题](../appendices/faq.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-学习路径) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)
