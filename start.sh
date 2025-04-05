#!/bin/bash
git pull

# 运行 Python 脚本，并后台执行
PYTHON_SCRIPT="main.py"
sh stop.sh
if [ "$1" = "back" ]; then
    if [ ! -d "$PYTHON_SCRIPT" ]; then
        nohup python3 "$PYTHON_SCRIPT" > output.log 2>&1 &
        tail -f output.log
    fi
else
    python3 "$PYTHON_SCRIPT"
fi


echo "脚本已启动，日志保存在 output.log"
