# DigitLink推广专家 - 任务状态管理

## 状态文件结构

任务状态必须外部化到文件系统，路径格式：
```
state/{task_type}/{YYYY-MM-DD}.json
```

## 状态文件格式

```json
{
  "task_id": "competitor_watch_2026-05-24_001",
  "task_type": "competitor_watch",
  "status": "in_progress|completed|failed",
  "started_at": "2026-05-24T08:00:00Z",
  "updated_at": "2026-05-24T08:15:00Z",
  "completed_at": "2026-05-24T08:30:00Z",
  "evidence": {
    "files_written": ["data/competitors_2026-05-24.json"],
    "metrics": {"accounts_checked": 10, "videos_found": 45}
  },
  "handoff": {
    "next_action": "review_report",
    "blocking_issues": []
  },
  "diagnostic": {
    "saw_rules": true,
    "had_tools": true,
    "had_env": true,
    "had_state": true,
    "had_feedback": true,
    "clean_exit": true
  }
}
```

## 任务类型

| 类型 | 说明 |
|------|------|
| `competitor_watch` | 竞品监控 |
| `posting` | 内容发布 |
| `comment_reply` | 评论回复 |
| `report` | 数据报告 |

## 状态流转

```
pending → in_progress → completed
                       ↘ failed
```

## 诊断6问（故障排查）

1. **saw_rules** - Agent是否看到了规则？
2. **had_tools** - Agent是否有可执行工具？
3. **had_env** - Agent是否有可复现环境？
4. **had_state** - Agent是否有持续状态？
5. **had_feedback** - Agent是否有验证反馈？
6. **clean_exit** - Agent是否清洁退出？

## 状态外部化要求

- ✅ 每个任务必须创建状态文件
- ✅ 任务中必须更新 `updated_at`
- ✅ 任务完成必须写入 `completed_at` 和 `evidence`
- ✅ 失败必须记录 `blocking_issues`
- ❌ 状态不能只存在聊天窗口里
