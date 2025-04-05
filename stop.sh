#!/bin/bash

# 安全获取所有匹配的PID
pids=()
while IFS= read -r pid; do
    pids+=("$pid")
done < <(pgrep -f 'python3 main' 2>/dev/null)  # 注意这里是英文符号

if [ ${#pids[@]} -eq 0 ]; then
    echo "No running python3 main processes found"
    exit 0
fi

# 终止进程
for pid in "${pids[@]}"; do
    echo "Killing PID: $pid"
    kill -9 "$pid" 2>/dev/null && echo "Success" || echo "Failed"
done

echo "All targets processed"

# 二次确认
remaining=$(pgrep -f 'python3 main' | wc -l)
if [ "$remaining" -gt 0 ]; then
    echo "警告: 仍有 $remaining 个进程存活"
else
    echo "所有目标进程已终止"
fi