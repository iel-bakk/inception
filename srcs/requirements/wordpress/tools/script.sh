#!/bin/sh
apt update -y && apt upgrade -y
# install three packages "curl, php-form, php-mysql" and download wp-cli.phar
apt install curl php-fpm php-mysql -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# # make the file executable and move it to /usr/local/bin/wp

mkdir -p /run/php
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

wp core download --path=/var/www/html --allow-root 
cat /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php
chmod -R 0777 /var/www/html/
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/html

wp config set DB_NAME $Wordpress_database --path=/var/www/html --allow-root
wp config set DB_USER $Wordpress_database_user --path=/var/www/html --allow-root
wp config set DB_PASSWORD $Wordpress_database_password --path=/var/www/html --allow-root
wp config set DB_HOST $Wordpress_database --path=/var/www/html --allow-root

wp core install --url=$Wordpress_database_host --path=/var/www/html --title='inception' --admin_user=$Wordpress_database_user --admin_password=$Wordpress_database_password --admin_email=$Wordpress_db_email --allow-root
wp user create --allow-root  --path=/var/www/html  $Wordpress_admin_User $Wordpress_admin_email --role='author' --user_pass=$Wordpress_admin_password
php-fpm7.4 -F
