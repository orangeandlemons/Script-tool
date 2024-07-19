#!/bin/bash

# 安装 Docker
install_docker() {
    echo "开始安装 Docker..."
    sudo yum update -y
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
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
    sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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
