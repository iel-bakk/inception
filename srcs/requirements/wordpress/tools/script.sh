#!/bin/sh
# update the package manaeger and installs any available updates
apt update -y
# install three packages "curl, php-form, php-mysql" and download wp-cli.phar
apt install curl php-fpm php-mysql -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make the file executable and move it to /usr/local/bin/wp
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
#modifie the PHP-FPM configuration file to change the listen port from the default to 9000
sed -i -e 's/listen =.*/listen = $MYSQL_PORT/g' /etc/php/7.3/fpm/pool.d/www.conf
# wordpress client is used to download the wordpress files
wp core download --path="/var/www/html"  --allow-root && chown -R www-data:www-data /var/www/html
# wordpress client is used to create the wp-config.php file with the database details
wp config create --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
    --dbhost=$MYSQL_HOST --path=/var/www/html --allow-root \
    --skip-check --extra-php << PHP
 
define('WP_REDIS_HOST', 'redis');

define('WP_REDIS_PORT', 6379);

define('WP_REDIS_DISABLED', false);

PHP

# wordpress client is used to install wordpress with an admin user and password
wp core install --url=$URL --title=$TITLE \
    --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD \
    --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/html
# wordpress client is used to create a new user with the role of author
wp user create iel-bakk iel-bakk@gmail.com --user_pass=$MYSQL_PASSWORD --role=author --allow-root --path=/var/www/html/
# starts the php-fpm service 
service php7.3-fpm start
# install redis cache plugin for wordpress
wp plugin install redis-cache --path=/var/www/html --allow-root
# activate redis cache plugin for wordpress
wp plugin activate redis-cache --path=/var/www/html --allow-root
# enable redis cache plugin for wordpress
wp redis enable --path=/var/www/html --allow-root
# stops the php-fpm service
service php7.3-fpm stop
# starts the php-fpm service in the foreground so that the container does not exit
php-fpm7.3 -F