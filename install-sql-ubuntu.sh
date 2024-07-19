#!/bin/bash

# 安装 MySQL
install_mysql() {
    echo "开始安装 MySQL..."
    sudo apt-get update -y
    sudo apt-get install -y mysql-server
    sudo systemctl start mysql
    sudo systemctl enable mysql
    echo "MySQL 安装完成。"
}

# 卸载 MySQL
uninstall_mysql() {
    echo "开始卸载 MySQL..."
    sudo systemctl stop mysql
    sudo apt-get purge -y mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
    sudo apt-get autoremove -y
    sudo apt-get autoclean
    sudo rm -rf /etc/mysql /var/lib/mysql
    echo "MySQL 卸载完成。"
}

# 安装 PostgreSQL
install_postgresql() {
    echo "开始安装 PostgreSQL..."
    sudo apt-get update -y
    sudo apt-get install -y postgresql postgresql-contrib
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    echo "PostgreSQL 安装完成。"
}

# 卸载 PostgreSQL
uninstall_postgresql() {
    echo "开始卸载 PostgreSQL..."
    sudo systemctl stop postgresql
    sudo apt-get purge -y postgresql postgresql-* 
    sudo apt-get autoremove -y
    sudo apt-get autoclean
    sudo rm -rf /etc/postgresql /var/lib/postgresql
    echo "PostgreSQL 卸载完成。"
}

# 在这里取消注释以进行安装或卸载
# 安装
# install_mysql
# install_postgresql

# 卸载
# uninstall_mysql
# uninstall_postgresql

echo "脚本执行完毕。"
