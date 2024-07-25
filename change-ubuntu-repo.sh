#!/bin/bash

backup_dir="/etc/apt/sources.list.backup"

# 创建备份
create_backup() {
    if [ ! -d "$backup_dir" ]; then
        echo "创建备份目录..."
        sudo mkdir -p "$backup_dir"
    fi

    echo "备份现有的 sources.list 到 $backup_dir..."
    sudo cp /etc/apt/sources.list "$backup_dir/sources.list.$(date +%F-%T)"
}

# 设置阿里云镜像源
set_aliyun_repo() {
    echo "设置阿里云镜像源..."
    sudo tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
}

# 设置科大讯飞镜像源
set_iflytek_repo() {
    echo "设置科大讯飞镜像源..."
    sudo tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.iflytek.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.iflytek.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.iflytek.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.iflytek.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.iflytek.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
}

# 主函数
main() {
    echo "Ubuntu 换源脚本"
    echo "1. 阿里云镜像源"
    echo "2. 科大讯飞镜像源"
    read -p "请选择镜像源 (1 或 2): " choice

    create_backup

    case $choice in
        1)
            set_aliyun_repo
            ;;
        2)
            set_iflytek_repo
            ;;
        *)
            echo "无效的选择"
            exit 1
            ;;
    esac

    sudo apt-get update
    echo "镜像源更换完成。"
}

main
