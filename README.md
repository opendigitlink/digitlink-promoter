# DigitLink推广Agent v2.0

基于 **Harness Engineering** 工程化方法论的 AI 社交媒体推广系统。

## 核心特性

| 特性 | 说明 |
|------|------|
| **渐进披露** | SOUL.md 拆分为多个模块，Agent 按需读取 |
| **状态外部化** | 任务状态写入 `state/` 目录，断了也能接着做 |
| **完成验证** | 不是 Agent 说"完成了"就算完，必须通过验证 |
| **证据链** | 所有操作生成证据文件，可追溯可复盘 |

## 目录结构

```
digitlink-promoter/
├── SOUL.md              # 入口人格定义
├── soul/                # 渐进披露文档
│   ├── 00-core.md       # 核心人格（必读）
│   ├── 01-skills.md     # 技能规范
│   └── 02-platform-rules.md  # 平台规则
├── config.yaml          # 模型配置
├── cron/
│   └── tasks.yaml       # 定时任务（带状态追踪）
├── state/               # 任务状态外部化
│   ├── README.md
│   ├── template.json    # 状态模板
│   └── state_manager.sh # 状态管理脚本
├── verification/        # 完成验证机制
│   └── README.md
├── evidence/           # 证据存储
├── data/               # 竞品数据
├── logs/               # 操作日志
└── reports/            # 报告输出
```

## 五大子系统

```
┌─────────────────────────────────────────────────────┐
│                    Harness System                    │
├─────────────────────────────────────────────────────┤
│  指令 (Instructions)  → soul/ 渐进披露文档          │
│  工具 (Tools)        → digitlink/playwright        │
│  环境 (Environment)  → ~/.hermes 执行上下文         │
│  状态 (State)        → state/ 外部化状态文件        │
│  反馈 (Feedback)     → verification/ 验证机制        │
└─────────────────────────────────────────────────────┘
```

## 状态管理流程

```
1. 任务开始 → 创建 state/{task_type}/{date}.json
2. 任务执行 → 更新 updated_at + evidence
3. 任务完成 → 写入 completed_at + 通过验证
4. 失败 → 记录 blocking_issues + 保留证据
```

## 完成判定清单

- [ ] 构建完成（无错误）
- [ ] 验证通过（evidence 存在）
- [ ] 交接写入（状态外部化）
- [ ] 清洁退出（临时文件清理）

## 诊断6问

当任务失败时，检查：

1. saw_rules — Agent 看到规则了吗？
2. had_tools — Agent 有可执行工具吗？
3. had_env — Agent 有可复现环境吗？
4. had_state — Agent 有持续状态吗？
5. had_feedback — Agent 有验证反馈吗？
6. clean_exit — Agent 清洁退出了吗？

## 安装

```bash
# 一键安装
hermes profile install digitlink-promoter

# 或手动安装
tar -xzf digitlink-promoter-v2.0.0.tar.gz
cd digitlink-promoter
cp .env.example .env
# 编辑 .env 填入账号密码
```

## 配置

编辑 `.env` 文件：

```bash
DIGITLINK_EMAIL=your@email.com
DIGITLINK_PASSWORD=your_password
OPENAI_API_KEY=sk-...
```

## 使用

```bash
# 查看任务状态
./state/state_manager.sh show competitor_watch 2026-05-24

# 手动触发竞品监控
hermes cron run competitor_watch
```

## 更新日志

### v2.0.0 (2026-05-24)
- 基于 Harness Engineering 重构
- SOUL.md 拆分为渐进披露结构
- 增加状态外部化系统
- 增加完成验证机制
- 增加证据存储系统

### v1.0.0 (2026-05-22)
- 初始版本
