#!/bin/bash
# DigitLink推广任务状态管理脚本
# 用法: ./state_manager.sh <action> <task_type> [date]

ACTION="$1"
TASK_TYPE="$2"
DATE="${3:-$(date +%Y-%m-%d)}"
STATE_DIR="$(dirname "$0")/../state"

# 创建任务状态文件
create() {
    local task_id="${TASK_TYPE}_${DATE}_$(date +%s)"
    cat > "${STATE_DIR}/${TASK_TYPE}/${DATE}.json" <<EOF
{
  "task_id": "${task_id}",
  "task_type": "${TASK_TYPE}",
  "status": "pending",
  "started_at": null,
  "updated_at": null,
  "completed_at": null,
  "evidence": {"files_written": [], "metrics": {}},
  "handoff": {"next_action": null, "blocking_issues": []},
  "diagnostic": {
    "saw_rules": null,
    "had_tools": null,
    "had_env": null,
    "had_state": null,
    "had_feedback": null,
    "clean_exit": null
  }
}
EOF
    echo "Created: ${task_id}"
}

# 更新状态
update() {
    local status="$4"  # in_progress, completed, failed
    local json="${STATE_DIR}/${TASK_TYPE}/${DATE}.json"
    if [ -f "$json" ]; then
        # 简单更新（实际应该用jq）
        sed -i '' "s/\"status\": \"[^\"]*\"/\"status\": \"${status}\"/g" "$json"
        sed -i '' "s/\"updated_at\": \"[^\"]*\"/\"updated_at\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"/g" "$json"
        echo "Updated ${TASK_TYPE}/${DATE} -> ${status}"
    else
        echo "State file not found: ${TASK_TYPE}/${DATE}.json"
    fi
}

# 显示状态
show() {
    cat "${STATE_DIR}/${TASK_TYPE}/${DATE}.json" 2>/dev/null || echo "No state file found"
}

case "$ACTION" in
    create) create ;;
    update) update ;;
    show) show ;;
    *) echo "Usage: $0 <create|update|show> <task_type> [date]" ;;
esac
