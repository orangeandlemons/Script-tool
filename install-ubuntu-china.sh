#!/bin/bash

# 安装 Docker
install_docker() {
    echo "开始安装 Docker..."
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    # 使用阿里云镜像下载 Docker GPG 密钥
    curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update -y
    sudo apt-get install -y docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker 安装完成。"
}

# 卸载 Docker
uninstall_docker() {
    echo "开始卸载 Docker..."
    sudo systemctl stop docker
    sudo apt-get purge -y docker-ce
    sudo apt-get autoremove -y --purge docker-ce
    sudo rm -rf /var/lib/docker
    echo "Docker 卸载完成。"
}

# 安装 Docker Compose
install_docker_compose() {
    echo "开始安装 Docker Compose..."
    # 使用国内镜像下载 Docker Compose
    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m`  > /usr/local/bin/docker-compose
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
    sudo apt-get update -y
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "Nginx 安装完成。"
}

# 卸载 Nginx
uninstall_nginx() {
    echo "开始卸载 Nginx..."
    sudo systemctl stop nginx
    sudo apt-get purge -y nginx nginx-common
    sudo apt-get autoremove -y
    sudo rm -rf /etc/nginx /var/log/nginx /var/www/html
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
