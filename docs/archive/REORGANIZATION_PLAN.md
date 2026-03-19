# 🏗️ Shell Notes 目录重组计划

**执行时间**: 2026-03-19  
**方案**: A - 彻底重组目录结构  
**目标**: 创建清晰的学习路径，从入门到实战

---

## 📁 新目录结构

### 阶段 1: 快速开始 (入门第 1 天)
```
00_quickstart/          (5 个脚本) ⭐
```

### 阶段 2: 基础篇 (入门第 2-7 天)
```
01_basics/              (20 个脚本) ⭐⭐
├── 01_variables/       # 变量 (8 个)
├── 02_operators/       # 运算符 (6 个)
└── 03_io/              # 输入输出 (6 个)
```

### 阶段 3: 流程控制 (入门第 8-21 天)
```
02_control_flow/        (25 个脚本) ⭐⭐⭐
├── 01_condition/       # 条件判断 (7 个)
├── 02_loops/           # 循环 (10 个)
├── 03_case/            # 选择结构 (3 个)
└── 04_functions/       # 函数 (5 个)
```

### 阶段 4: 数据结构 (入门第 22-28 天)
```
03_data_structures/     (12 个脚本) ⭐⭐⭐
├── 01_indexed_arrays/  # 索引数组 (5 个)
├── 02_associative_arrays/ # 关联数组 (4 个)
└── 03_strings/         # 字符串操作 (3 个)
```

### 阶段 5: 文本处理 (进阶第 1-14 天)
```
04_text_processing/     (15 个脚本) ⭐⭐⭐⭐
├── 01_grep/            # grep (5 个)
├── 02_sed/             # sed (5 个)
└── 03_awk/             # awk (5 个)
```

### 阶段 6: 系统编程 (进阶第 15-30 天)
```
05_system_programming/  (18 个脚本) ⭐⭐⭐⭐
├── 01_shell_init/      # Shell 初始化 (3 个)
├── 02_job_control/     # 作业控制 (4 个)
├── 03_signals/         # 信号处理 (3 个)
├── 04_concurrency/     # 并发控制 (5 个)
└── 05_shortcuts/       # 快捷键 (1 个文档 +2 个脚本)
```

### 阶段 7: 实战项目 (实战第 1-30 天)
```
06_real_world/          (15 个项目) ⭐⭐⭐⭐⭐
├── 01_system_monitor/  # 系统监控工具
├── 02_backup_automation/ # 备份自动化
├── 03_log_analyzer/    # 日志分析器
├── 04_user_manager/    # 用户管理工具
├── 05_deploy_script/   # 自动化部署
├── 06_network_tools/   # 网络工具
├── 07_security_tools/  # 安全工具
└── 08_devops_tools/    # DevOps 工具
```

### 附录
```
appendices/
├── cheatsheet.md
├── faq.md
└── resources.md
```

---

## 📋 迁移映射表

### 旧 → 新 目录映射

| 旧目录 | 新目录 | 说明 |
|--------|--------|------|
| 01_basic/ | 00_quickstart/ + 01_basics/01_variables/ | 拆分 |
| 02_variable/ | 01_basics/01_variables/ + 01_basics/02_operators/ | 拆分 |
| 03_condition/ | 02_control_flow/01_condition/ | 直接迁移 |
| 04_loop/ | 02_control_flow/02_loops/ | 直接迁移 |
| 05_case/ | 02_control_flow/03_case/ | 直接迁移 |
| 10_function/ | 02_control_flow/04_functions/ | 提前 |
| 07_system/ (数组) | 03_data_structures/ | 提取 |
| 06_text/ | 04_text_processing/ | 直接迁移 |
| 07_system/ (系统) | 05_system_programming/ | 提取 |
| 08_concurrency/ | 05_system_programming/04_concurrency/ | 合并 |
| 09_devops/ | 06_real_world/08_devops_tools/ | 重组 |

---

## 🎯 执行步骤

### 步骤 1: 创建新目录结构
```bash
mkdir -p 00_quickstart
mkdir -p 01_basics/{01_variables,02_operators,03_io}
mkdir -p 02_control_flow/{01_condition,02_loops,03_case,04_functions}
mkdir -p 03_data_structures/{01_indexed_arrays,02_associative_arrays,03_strings}
mkdir -p 04_text_processing/{01_grep,02_sed,03_awk}
mkdir -p 05_system_programming/{01_shell_init,02_job_control,03_signals,04_concurrency,05_shortcuts}
mkdir -p 06_real_world/{01_system_monitor,02_backup_automation,03_log_analyzer,04_user_manager,05_deploy_script,06_network_tools,07_security_tools,08_devops_tools}
mkdir -p appendices
```

### 步骤 2: 迁移脚本 (保持向后兼容)
- 复制脚本到新目录
- 保留原目录 (添加迁移通知)
- 创建符号链接 (可选)

### 步骤 3: 更新文档
- 更新 README.md
- 创建学习路径文档
- 更新所有目录 README

### 步骤 4: Git 提交
- 分阶段提交
- 清晰的提交信息
- 保留 Git 历史

---

## ⚠️ 注意事项

1. **保持向后兼容**: 保留原目录 6 个月
2. **更新引用**: 更新所有文档中的路径引用
3. **测试脚本**: 确保迁移后脚本仍可运行
4. **通知用户**: 在 README 添加迁移通知

---

**预计完成时间**: 2-3 小时  
**风险**: 低 (保留原目录)  
**收益**: 高 (清晰的学习路径)
