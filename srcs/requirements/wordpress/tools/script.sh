#!/bin/sh
apt update -y && apt upgrade -y
# install three packages "curl, php-form, php-mysql" and download wp-cli.phar
apt install curl php-fpm php-mysql -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# # make the file executable and move it to /usr/local/bin/wp

mkdir -p /run/php
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

wp core download --path=/var/www/html --allow-root 
cat /var/www/html/wp-config-sample.php > /var/www/html/wp-content/wp-config.php
chmod -R 0777 /var/www/html/wp-content
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/html

wp config set DB_NAME $MYSQL_DATABASE --path=/var/www/html --allow-root
wp config set DB_USER $MYSQL_USER --path=/var/www/html --allow-root
wp config set DB_PASSWORD $MYSQL_ROOT_PASSWORD --path=/var/www/html --allow-root
wp config set DB_HOST $MYSQL_HOST --path=/var/www/html --allow-root

wp core install --url='iel-bakk.42.fr' --path=/var/www/html --title=$TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root
wp user create --allow-root  --path=/var/www/html  'iel-bakk' 'iel-bakk-author@student.1337.ma' --role=author --user_pass=$ADMIN_PASSWORD
# wp config set WP_CACHE true --path=/var/www/ --allow-root

php-fpm7.4 -F
# #!/bin/sh
# # update the package manaeger and installs any available updates
# #modifie the PHP-FPM configuration file to change the listen port from the default to 9000
# sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
# # wordpress client is used to download the wordpress files
# wp core download --path="/var/www/html"  --allow-root
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# chown -R www-data:www-data /var/www/html
# # wordpress client is used to create the wp-config.php file with the database details
# wp config --dbname="saad" --dbuser="ssda2" --dbpass="fdsfdsfs" --dbhost="mariadb" --path="/var/www/html" --allow-root --skip-check
# # wordpress client is used to install wordpress with an admin user and password
# wp core install --url=$URL --title=$TITLE \
#     --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD \
#     --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/html
# # wordpress client is used to create a new user with the role of author
# wp user create iel-bakk iel-bakk@gmail.com --user_pass=$MYSQL_PASSWORD --role=author --allow-root --path=/var/www/html/


# # start the php-fpm service and then stop it to creat the pid file
# service php7.4-fpm start
# service php7.4-fpm stop
# # starts the php-fpm service in the foreground so that the container does not exit
# php-fpm7.4 -F