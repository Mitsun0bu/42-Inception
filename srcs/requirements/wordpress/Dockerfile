FROM	debian:buster

ARG		MYSQL_DATABASE
ARG		MYSQL_USER
ARG		MYSQL_PASSWORD
ARG		MYSQL_HOST

# UPDATE & UPGRADE THE SYSTEM
RUN		apt-get update -y \
&&		apt-get upgrade -y \
&&		apt-get install -y wget

# INSTALL & CONFIGURE PHP
RUN		apt-get install -y php-fpm php-mysql \
&&		service php7.3-fpm start && service php7.3-fpm stop \
&&		sed -i "s/\/run\/php\/php7.3-fpm.sock/wordpress:9000/" /etc/php/7.3/fpm/pool.d/www.conf

# INSTALL WORDPRESS
ADD		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN		chmod +x /usr/local/bin/wp \
&&		mkdir -p /var/www/html/wordpress \
&&		wp core download --path="/var/www/html/wordpress" --allow-root

# CONFIGURE WORDPRESS WITH DATABASE INFOS
RUN		cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/localhost/$MYSQL_HOST/" /var/www/html/wordpress/wp-config.php

# PORTS
EXPOSE	9000 3306

# START
COPY	./tools/entrypoint.sh /tmp
ENTRYPOINT	["sh", "/tmp/entrypoint.sh"]