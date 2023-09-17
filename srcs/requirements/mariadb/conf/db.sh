#!/bin/bash
apt-get update -y && apt-get upgrade -y 
apt-get install -y mariadb-server
chown -R mysql:mysql /var/lib/mysql
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf;

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "socket=/var/run/mysqld/mysqld.sock" >> /etc/mysql/my.cnf
service mariadb start
echo "CREATE DATABASE IF NOT EXISTS $Wordpress_database;" | mariadb
echo "GRANT ALL PRIVILEGES ON $Wordpress_database.* TO '$Wordpress_database_user'@'%' IDENTIFIED BY '$Wordpress_database_password' WITH GRANT OPTION;" | mariadb
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$Wordpress_database_password' WITH GRANT OPTION;" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb
kill `cat /var/run/mysqld/mysqld.pid`
service mariadb stop
mysqld