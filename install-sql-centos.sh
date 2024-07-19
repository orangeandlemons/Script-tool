#!/bin/bash

# 安装 MySQL
install_mysql() {
    echo "开始安装 MySQL..."
    # 安装 MySQL 官方仓库
    sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
    sudo yum-config-manager --enable mysql80-community
    sudo yum install -y mysql-community-server
    sudo systemctl start mysqld
    sudo systemctl enable mysqld
    echo "MySQL 安装完成。"
}

# 卸载 MySQL
uninstall_mysql() {
    echo "开始卸载 MySQL..."
    sudo systemctl stop mysqld
    sudo yum remove -y mysql-community-server mysql-community-client mysql-community-common mysql-community-libs
    sudo rm -rf /var/lib/mysql /etc/my.cnf
    echo "MySQL 卸载完成。"
}

# 安装 PostgreSQL
install_postgresql() {
    echo "开始安装 PostgreSQL..."
    # 安装 PostgreSQL 官方仓库
    sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/el7/x86_64/pgdg-redhat-repo-latest.noarch.rpm
    sudo yum install -y postgresql15-server postgresql15-contrib
    sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
    sudo systemctl start postgresql-15
    sudo systemctl enable postgresql-15
    echo "PostgreSQL 安装完成。"
}

# 卸载 PostgreSQL
uninstall_postgresql() {
    echo "开始卸载 PostgreSQL..."
    sudo systemctl stop postgresql-15
    sudo yum remove -y postgresql15-server postgresql15-contrib
    sudo rm -rf /var/lib/pgsql /var/lib/pgsql-15 /etc/postgresql
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
