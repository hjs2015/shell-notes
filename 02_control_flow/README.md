# 🔄 流程控制 (Control Flow)

> **学习第 8-21 天** | 难度：⭐⭐⭐ | 44 个脚本

---

## 📖 简介

流程控制是 Shell 编程的**核心**，让脚本能够做决策和重复执行。

**目标**：
- ✅ 掌握条件判断（if/else）
- ✅ 掌握循环结构（for/while/until）
- ✅ 掌握选择结构（case）
- ✅ 掌握函数定义和调用

**预计时间**：2 周，每天 1-2 小时

---

## 📁 子目录

```
02_control_flow/
├── 01_condition/       # 条件判断 (7 个脚本)
├── 02_loops/           # 循环结构 (22 个脚本)
├── 03_case/            # 选择结构 (12 个脚本)
└── 04_functions/       # 函数定义 (4 个脚本)
```

---

## 🎯 学习目标

### 条件判断
- ✅ if/else 语句
- ✅ 字符串比较
- ✅ 数值比较（传统和 C 风格）
- ✅ 文件测试

### 循环结构
- ✅ for 循环（传统和 C 风格）
- ✅ while 循环
- ✅ until 循环
- ✅ break 和 continue
- ✅ 嵌套循环

### 选择结构
- ✅ case 语句
- ✅ 模式匹配
- ✅ 菜单系统

### 函数
- ✅ 函数定义和调用
- ✅ 函数参数
- ✅ 局部变量
- ✅ 返回值

---

## 📝 学习路径

### 第 8-10 天：条件判断

**重点脚本**：
- `01_condition/01_logic_operation.sh` - 逻辑运算
- `01_condition/06_string_comparison.sh` - 字符串比较
- `01_condition/07_c_style_comparison.sh` - C 风格比较

**示例**：
```bash
# if/else
if [[ $age -ge 18 ]]; then
    echo "成年人"
else
    echo "未成年人"
fi

# 字符串比较
[[ "$str1" == "$str2" ]] && echo "相同"
```

---

### 第 11-16 天：循环结构

**重点脚本**：
- `02_loops/01_recursive_echo.sh` - for 循环基础
- `02_loops/02_multiplication_table.sh` - 嵌套循环
- `02_loops/04_for_c_style.sh` - C 风格 for
- `02_loops/05_break_continue.sh` - 循环控制
- `02_loops/08_guess_number_game.sh` - 综合练习

**示例**：
```bash
# for 循环
for i in {1..10}; do
    echo $i
done

# while 循环
while [[ $count -lt 10 ]]; do
    ((count++))
done

# break/continue
for i in {1..10}; do
    [[ $i -eq 5 ]] && continue
    [[ $i -eq 8 ]] && break
    echo $i
done
```

---

### 第 17-19 天：选择结构

**重点脚本**：
- `03_case/01_char_type_check.sh` - 字符类型检查
- `03_case/02_menu_system.sh` - 菜单系统
- `03_case/12_tetris_game.sh` - 俄罗斯方块（综合）

**示例**：
```bash
# case 语句
case $choice in
    1) echo "选项 1" ;;
    2) echo "选项 2" ;;
    *) echo "无效选项" ;;
esac
```

---

### 第 20-21 天：函数

**重点脚本**：
- `04_functions/01_function_basics.sh` - 函数基础
- `04_functions/02_function_parameters.sh` - 函数参数
- `04_functions/03_local_variables.sh` - 局部变量
- `04_functions/04_return_values.sh` - 返回值

**示例**：
```bash
# 函数定义
function greet() {
    local name=$1
    echo "Hello, $name!"
}

# 调用函数
greet "World"

# 返回值
function add() {
    return $(($1 + $2))
}
add 3 5
echo $?  # 8
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 使用 if/else 做条件判断
- [ ] 使用 for/while/until 循环
- [ ] 使用 break 和 continue 控制循环
- [ ] 使用 case 创建菜单
- [ ] 定义和调用函数
- [ ] 使用局部变量
- [ ] 编写 100 行以上的脚本

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[03_data_structures/](../03_data_structures/)** - 数据结构（第 22-28 天）

你将学习：
- 索引数组
- 关联数组
- 字符串高级操作

---

## 💡 小贴士

1. **条件测试** - 优先使用 `[[ ]]` 而非 `[ ]`
2. **循环性能** - 大量数据时避免在循环中调用外部命令
3. **函数命名** - 使用动词开头，如 `calculate_sum()`
4. **局部变量** - 函数内始终使用 `local` 声明变量
5. **错误处理** - 检查函数返回值

---

## 📚 参考资源

- [Bash 流程控制](https://www.gnu.org/software/bash/manual/)
- [循环最佳实践](https://www.runoob.com/linux/linux-shell.html)
- [快速参考手册](../appendices/cheatsheet.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-学习路径) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)
