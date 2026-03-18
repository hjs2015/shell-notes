# 06_text - 文本处理

## 📝 知识点
- grep 文本搜索
- awk 文本分析
- sed 文本替换
- cut 字段提取
- sort 排序
- uniq 去重
- 管道组合

## 📁 文件列表

### 教程文件
| 文件 | 描述 | 内容 |
|------|------|------|
| `shell04.txt` | awk 基础教程 | awk 语法、字段操作、与 cut 对比 |
| `shell05.txt` | awk 脚本教程 | awk 脚本结构、BEGIN/END 块 |

### awk 脚本示例
| 文件 | 描述 |
|------|------|
| `1.awk` | 提取第一字段 |
| `2.awk` | 条件统计 |
| `3.awk` | 字段处理 |

## 💡 awk 基础

### 两种调用方式

**方式 1: 命令行**
```bash
awk -F":" '{print $1}' /etc/passwd
```

**方式 2: 脚本文件**
```bash
awk -f script.awk /etc/passwd
```

### awk 脚本结构
```awk
BEGIN {
    FS=":"  # 设置分隔符
    sum=0   # 初始化变量
}
{
    # 主处理块，每行执行
    print $1
}
END {
    # 结束时执行
    print "Total:", sum
}
```

### 常用命令对比

| 命令 | 用途 | 示例 |
|------|------|------|
| `cut` | 字段提取 | `cut -d: -f1 /etc/passwd` |
| `awk` | 文本分析 | `awk -F: '{print $1}' /etc/passwd` |
| `grep` | 文本搜索 | `grep "root" /etc/passwd` |
| `sed` | 文本替换 | `sed 's/old/new/g' file` |
| `sort` | 排序 | `sort -n file.txt` |
| `uniq` | 去重 | `uniq -c file.txt` |

### 管道组合示例
```bash
# 统计每个用户登录次数
who | awk '{print $1}' | sort | uniq -c

# 查找错误日志
grep "error" /var/log/messages | awk '{print $1, $2}'

# 提取 IP 地址
ifconfig eth0 | grep Bcast | awk -F: '{print $2}' | awk '{print $1}'
```

## 📚 学习资源
- shell04.txt - awk 与 cut 对比详解
- shell05.txt - awk 脚本编写指南
