#!/bin/bash

backup_dir="/etc/yum.repos.d/backup"

# 创建备份目录
create_backup() {
    if [ ! -d "$backup_dir" ]; then
        echo "创建备份目录..."
        sudo mkdir -p "$backup_dir"
    fi

    echo "备份现有的 yum 源配置文件到 $backup_dir..."
    sudo mv /etc/yum.repos.d/*.repo "$backup_dir"
}

# 设置阿里云镜像源
set_aliyun_repo() {
    echo "设置阿里云镜像源..."
    sudo tee /etc/yum.repos.d/CentOS-Base.repo <<-'EOF'
[base]
name=CentOS-$releasever - Base - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-$releasever - Updates - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-$releasever - Extras - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

[centosplus]
name=CentOS-$releasever - Plus - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=http://mirrors.aliyun.com/epel/7/$basearch/
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/epel/RPM-GPG-KEY-EPEL-7

EOF
}

# 设置科大讯飞镜像源
set_iflytek_repo() {
    echo "设置科大讯飞镜像源..."
    sudo tee /etc/yum.repos.d/CentOS-Base.repo <<-'EOF'
[base]
name=CentOS-$releasever - Base - mirrors.iflytek.com
baseurl=http://mirrors.iflytek.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.iflytek.com/centos/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-$releasever - Updates - mirrors.iflytek.com
baseurl=http://mirrors.iflytek.com/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.iflytek.com/centos/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-$releasever - Extras - mirrors.iflytek.com
baseurl=http://mirrors.iflytek.com/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.iflytek.com/centos/RPM-GPG-KEY-CentOS-7

[centosplus]
name=CentOS-$releasever - Plus - mirrors.iflytek.com
baseurl=http://mirrors.iflytek.com/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.iflytek.com/centos/RPM-GPG-KEY-CentOS-7

[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=http://mirrors.iflytek.com/epel/7/$basearch/
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=http://mirrors.iflytek.com/epel/RPM-GPG-KEY-EPEL-7

EOF
}

# 主函数
main() {
    echo "CentOS 7 换源脚本"
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

    sudo yum clean all
    sudo yum makecache
    echo "镜像源更换完成。"
}

main
