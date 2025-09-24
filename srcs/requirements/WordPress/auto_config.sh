#!/bin/sh

sleep 5

echo "[ INFO ] Starting WordPress..."

if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp config create \
		--allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/html'
fi

cp /path/to/hello.html /var/www/html/hello.html

echo "[ INFO ] Running PHP-FPM..."
exec php-fpm84 -F
