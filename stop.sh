#!/bin/bash

# 获取所有匹配的PID（安全方式）
pids=()
while IFS= read -r pid; do
    pids+=("$pid")
done < <(pgrep -f 'python3 main' 2>/dev/null)

if [ ${#pids[@]} -eq 0 ]; then
    echo "没有找到运行的 python3 main 进程"
    exit 0
fi

# 终止所有目标进程
for pid in "${pids[@]}"; do
    if [ ! -d "/proc/$pid" ]; then  # 更可靠的进程存在检查
        echo "PID $pid 已不存在"
        continue
    fi

    echo "正在强制停止进程: $pid ($(ps -p "$pid" -o cmd=))"
    
    if kill -9 "$pid" 2>/dev/null; then
        echo "✓ 成功终止 PID $pid"
    else
        echo "✗ 无法终止 PID $pid (权限不足或进程已退出)"
    fi
done

# 二次确认
remaining=$(pgrep -f 'python3 main' | wc -l)
if [ "$remaining" -gt 0 ]; then
    echo "警告: 仍有 $remaining 个进程存活"
else
    echo "所有目标进程已终止"
fi