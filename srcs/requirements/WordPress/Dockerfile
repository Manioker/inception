FROM	alpine:3.22

RUN		apk update && apk upgrade && apk add --no-cache \
			wget \
			php84 \
			php84-fpm \
			php84-mysqli \
			php84-phar \
			mariadb-client

RUN		ln -s /usr/bin/php84 /usr/bin/php

# ---- User/Group Setup ---- #
RUN		addgroup -g 82 -S www-data || true
RUN		adduser -u 82 -D -S -G www-data www-data || true

# ---- WordPress Download and Setup ---- #
RUN		mkdir -p /var/www/html && chown -R root:root /var/www/html
RUN		wget https://wordpress.org/wordpress-6.8.tar.gz -P /var/www
RUN		tar -xzf /var/www/wordpress-6.8.tar.gz -C /var/www/html --strip-components=1
RUN		rm /var/www/wordpress-6.8.tar.gz
RUN		chown -R www-data:www-data /var/www/html

# ---- PHP-FPM Configuration ---- #
COPY	www.conf /etc/php84/php-fpm.d/www.conf

# ---- WP-CLI Setup ---- #
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp

# ---- Entrypoint Script ---- #
COPY	auto_config.sh /auto_config.sh
RUN		chmod +x /auto_config.sh

COPY	hello.html /hello.html
RUN		chmod +x /hello.html

ENTRYPOINT [ "sh", "/auto_config.sh" ]
