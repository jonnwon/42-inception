#!/bin/bash

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -f /var/www/html/wp-config.php ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp

  sleep 10

  wp core download --allow-root --path=/var/www/html/
  wp core config --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PWD --dbhost=mariadb:3306 --dbprefix=wp_ --allow-root --path=/var/www/html/
#  wp core install --url=https://$DOMAIN_NAME --title="jonchoi inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html/
#  wp core install --url=https://jonchoi.42.fr --title="jonchoi inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html/
  wp core install --url=https://13.209.222.162 --title="jonchoi inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html/
  wp user create "$WP_USER" "$WP_USER_EMAIL" --role=subscriber --user_pass="$WP_USER_PWD" --allow-root --path=/var/www/html/
fi

mkdir -p /run/php/
chown www-data:www-data /run/php/

#echo "127.0.0.1 jonchoi.42.fr" >> /etc/hosts

exec "$@"
