#!/bin/bash

# 设置日志文件路径
LOG_FILE="/tmp/logfile.log"

# 设置采样间隔（以秒为单位）
INTERVAL=5

# 输出日志头
echo "Timestamp, Device, tps, kB_read/s, kB_wrtn/s, kB_read, kB_wrtn" >> "$LOG_FILE"

# 开始记录磁盘吞吐量
while true; do
    # 获取当前时间
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # 使用 iostat 获取磁盘吞吐量信息，并将输出格式化后追加到日志文件
    iostat -dxk $INTERVAL 1 | awk -v timestamp="$TIMESTAMP" '
    NR>6 && NF==14 {
        print timestamp ", " $1 ", " $2 ", " $3 ", " $4 ", " $5 ", " $6
    }' >> "$LOG_FILE"
done
