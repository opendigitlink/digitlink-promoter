# DigitLink推广专家 - 完成验证机制

## 验证原则

**Agent说"完成了"不算完，必须通过验证才算完成。**

## 验证类型

### 1. 发布验证 (posting)

```
验证命令: curl -I {post_url} | grep HTTP
通过条件: HTTP 200 + 页面包含内容
证据要求: 截图或HTML片段保存到 evidence/posting_{task_id}/
```

### 2. 竞品监控验证 (competitor_watch)

```
验证命令: test -f data/competitors_{date}.json && wc -l data/competitors_{date}.json
通过条件: 文件存在 且 行数 > 10
证据要求: JSON文件必须包含 accounts 或 videos 字段
```

### 3. 评论回复验证 (comment_reply)

```
验证命令: grep -c "reply_sent" logs/replies_{date}.json
通过条件: 回复数量 > 0
证据要求: 回复内容保存到 evidence/replies_{task_id}/
```

### 4. 报告生成验证 (report)

```
验证命令: test -f reports/{type}_{date}.md && wc -w reports/{type}_{date}.md
通过条件: 文件存在 且 字数 > 100
证据要求: 报告文件必须包含数据摘要
```

## 完成判定清单

每个任务必须全部通过：

- [ ] **构建完成**: 代码/内容生成无错误
- [ ] **验证通过**: 上述验证命令返回成功
- [ ] **证据存在**: 证据文件/目录已创建
- [ ] **交接写入**: 状态文件 `completed_at` 已更新
- [ ] **清洁退出**: 临时文件已清理

## 证据文件命名

```
evidence/
├── posting_{task_id}/
│   ├── screenshot.png
│   └── response.html
├── competitor_watch_{task_id}/
│   └── data.json
├── comment_reply_{task_id}/
│   └── replies.json
└── report_{task_id}/
    └── report.md
```

## 自我评价 vs Harness评价

| Agent说 | Harness要求 |
|----------|-------------|
| "我认为完成了" | 构建过了吗？测试过了吗？ |
| "已经发布了" | 验证命令过了吗？证据存在吗？ |
| "报告已生成" | 文件存在吗？字数够吗？内容完整吗？ |

## 失败处理

验证失败时：
1. 记录 `blocking_issues` 到状态文件
2. 保留失败证据到 `evidence/error_{task_id}/`
3. 发送通知给负责人
4. 触发重试或人工介入
