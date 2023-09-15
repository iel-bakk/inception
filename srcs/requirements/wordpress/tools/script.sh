#!/bin/sh
# update the package manaeger and installs any available updates
apt update -y && apt upgrade -y
# install three packages "curl, php-form, php-mysql" and download wp-cli.phar
apt install curl php-fpm php-mysql -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make the file executable and move it to /usr/local/bin/wp
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
#modifie the PHP-FPM configuration file to change the listen port from the default to 9000
sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
# wordpress client is used to download the wordpress files
wp core download --path="/var/www/html"  --allow-root
# wordpress client is used to create the wp-config.php file with the database details
sleep 5
rm -rf /var/www/html/wp-config.php

echo $MYSQL_DATABASE = $MYSQL_USER = $MYSQL_PASSWORD = $MYSQL_HOST = $URL = $TITLE = $ADMIN_USER = $ADMIN_PASSWORD = $ADMIN_EMAIL = $MYSQL_PORT
# wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
#     --dbhost=$MYSQL_HOST --path="/var/www/html/" --allow-root --skip-check
echo "wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --path=/var/www/html --allow-root --skip-check"
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --path=/var/www/html --allow-root --skip-check
sleep 5
ls /var/www/html/
sleep 5
# wordpress client is used to install wordpress with an admin user and password
wp core install --url=$URL --title=$TITLE \
    --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD \
    --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/html
# wordpress client is used to create a new user with the role of author
wp user create iel-bakk iel-bakk@gmail.com --user_pass=$MYSQL_PASSWORD --role=author --allow-root --path=/var/www/html/


# start the php-fpm service and then stop it to creat the pid file
service php7.4-fpm start
service php7.4-fpm stop
# starts the php-fpm service in the foreground so that the container does not exit
php-fpm7.4 -F