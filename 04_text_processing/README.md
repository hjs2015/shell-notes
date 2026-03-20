# 📝 文本处理工具

**难度等级**：⭐⭐⭐⭐  
**学习时间**：第 29-42 天  
**脚本数量**：11 个

---

## 📚 本章概述

文本处理是 Shell 脚本的核心能力之一。本章介绍常用的文本处理工具，包括 grep、sed、awk 以及基础工具 cut、sort、uniq、tr、wc、head/tail、xargs 等。

---

## 📋 脚本清单

### grep/sed/awk（核心三剑客）

| 脚本 | 名称 | 难度 | 知识点 |
|------|------|------|--------|
| 01_grep/*.sh | grep 系列 | ⭐⭐⭐ | 文本搜索、正则匹配 |
| 02_sed/*.sh | sed 系列 | ⭐⭐⭐⭐ | 流编辑、批量替换 |
| 03_awk/*.sh | awk 系列 | ⭐⭐⭐⭐⭐ | 文本分析、报表生成 |

### 基础工具

| 脚本 | 名称 | 难度 | 知识点 |
|------|------|------|--------|
| 04_cut/01_cut_basics.sh | cut 基础 | ⭐⭐ | 按列提取字段 |
| 04_cut/02_cut_advanced.sh | cut 进阶 | ⭐⭐⭐ | 复杂场景应用 |
| 05_sort/01_sort_basics.sh | sort 基础 | ⭐⭐ | 文本排序 |
| 06_uniq/01_uniq_basics.sh | uniq 基础 | ⭐⭐ | 去重统计 |
| 07_tr/01_tr_basics.sh | tr 基础 | ⭐⭐ | 字符转换 |
| 08_wc/01_wc_basics.sh | wc 基础 | ⭐ | 统计行数/字数 |
| 09_head_tail/01_head_tail_basics.sh | head/tail | ⭐ | 查看文件头尾 |
| 11_xargs/01_xargs_basics.sh | xargs 基础 | ⭐⭐⭐ | 构建命令参数 |

---

## 🎯 学习目标

- ✅ 掌握 grep 进行文本搜索
- ✅ 使用 sed 进行流编辑
- ✅ 使用 awk 进行复杂文本分析
- ✅ 熟练使用 cut、sort、uniq 等基础工具
- ✅ 组合多个工具处理复杂文本

---

## 💡 实战建议

1. **先学基础工具**：cut、sort、uniq、wc、head/tail
2. **再学三剑客**：grep → sed → awk
3. **多练习组合**：管道组合多个工具
4. **实战场景**：日志分析、数据提取、报表生成

---

## 🔗 相关资源

- [grep 正则表达式指南](https://www.gnu.org/software/grep/manual/grep.html)
- [sed 流编辑器手册](https://www.gnu.org/software/sed/manual/sed.html)
- [awk 编程语言指南](https://www.gnu.org/software/gawk/manual/gawk.html)
