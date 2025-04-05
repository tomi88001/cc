#!/bin/bash
# sh start.sh https://admin.htfxaus.com/admin/admin/login 1000 100
# 运行 Python 脚本，并后台执行
PYTHON_SCRIPT="main.py"
sh stop.sh
cd /root/cc
if [ "$4" = "back" ]; then
    if [ ! -d "$PYTHON_SCRIPT" ]; then
        nohup python3 "$PYTHON_SCRIPT" "cc" "$1" "$2" "$3" > output.log 2>&1 &
        tail -f output.log
    fi
else
    python3 "$PYTHON_SCRIPT" "cc" "$1" $2 $3
fi


echo "脚本已启动，日志保存在 output.log"
