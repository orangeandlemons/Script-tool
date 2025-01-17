#!/bin/bash
#Author:orales
#2024/10
# 日志文件路径
log_file="artifactory-access.log"

# 用于存储每分钟的统计数据
declare -A download_count
declare -A deploy_count
declare -A unique_users

# 读取日志文件
while IFS= read -r line; do
    # 仅处理包含 [ACCEPTED DOWNLOAD] 或 [ACCEPTED DEPLOY] 的行
    if echo "$line" | grep -qE "\[ACCEPTED DOWNLOAD\]|\[ACCEPTED DEPLOY\]"; then
        # 提取时间戳和用户IP
        timestamp=$(echo "$line" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}')
        user=$(echo "$line" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')  # 提取IP地址作为唯一用户标识

        if [[ -n "$timestamp" && -n "$user" ]]; then
            # 判断操作类型并统计
            if echo "$line" | grep -q "\[ACCEPTED DOWNLOAD\]"; then
                ((download_count["$timestamp"]++))
            elif echo "$line" | grep -q "\[ACCEPTED DEPLOY\]"; then
                ((deploy_count["$timestamp"]++))
            fi

            # 记录唯一用户（仅统计一次每个用户）
            unique_users["$timestamp,$user"]=1
        fi
    fi
done < "$log_file"

# 输出结果
echo "每分钟 [ACCEPTED DOWNLOAD] 和 [ACCEPTED DEPLOY] 统计及唯一用户数："
for minute in "${!download_count[@]}" "${!deploy_count[@]}"; do
    downloads=${download_count["$minute"]:="0"}
    deploys=${deploy_count["$minute"]:="0"}

    # 统计唯一用户数
    unique_user_count=$(printf "%s\n" "${!unique_users[@]}" | grep "^$minute," | wc -l)

    echo "$minute: DOWNLOAD=$downloads, DEPLOY=$deploys, UNIQUE_USERS=$unique_user_count"
done | sort
