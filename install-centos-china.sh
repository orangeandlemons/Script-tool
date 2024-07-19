#!/bin/bash

# 安装 Docker
install_docker() {
    echo "开始安装 Docker..."
    sudo yum update -y
    sudo yum install -y yum-utils
    # 使用阿里云镜像下载 Docker 官方源
    sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker 安装完成。"
}

# 卸载 Docker
uninstall_docker() {
    echo "开始卸载 Docker..."
    sudo systemctl stop docker
    sudo yum remove -y docker-ce docker-ce-cli containerd.io
    sudo rm -rf /var/lib/docker
    echo "Docker 卸载完成。"
}

# 安装 Docker Compose
install_docker_compose() {
    echo "开始安装 Docker Compose..."
    # 使用国内镜像源下载 Docker Compose
    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m`  > /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose 安装完成。"
}

# 卸载 Docker Compose
uninstall_docker_compose() {
    echo "开始卸载 Docker Compose..."
    sudo rm /usr/local/bin/docker-compose
    echo "Docker Compose 卸载完成。"
}

# 安装 Nginx
install_nginx() {
    echo "开始安装 Nginx..."
    sudo yum install -y epel-release
    sudo yum install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "Nginx 安装完成。"
}

# 卸载 Nginx
uninstall_nginx() {
    echo "开始卸载 Nginx..."
    sudo systemctl stop nginx
    sudo yum remove -y nginx
    sudo rm -rf /etc/nginx /var/log/nginx /usr/share/nginx
    echo "Nginx 卸载完成。"
}

# 在这里取消注释以进行安装或卸载
# 安装
# install_docker
# install_docker_compose
# install_nginx

# 卸载
# uninstall_docker
# uninstall_docker_compose
# uninstall_nginx

echo "脚本执行完毕。"
