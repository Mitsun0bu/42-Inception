FROM	debian:buster

ARG		MYSQL_DATABASE
ARG		MYSQL_USER
ARG		MYSQL_PASSWORD
ARG		MYSQL_HOST

# UPDATE & UPGRADE THE SYSTEM
RUN		apt-get update -y \
&& apt-get upgrade -y \
&& apt-get install -y wget

# INSTALL PHP
RUN		apt-get install -y php-fpm php-mysql \
&&	 	service php7.3-fpm start && service php7.3-fpm stop \
&&		sed -i "s/\/run\/php\/php7.3-fpm.sock/wordpress:9000/" /etc/php/7.3/fpm/pool.d/www.conf

# WORDPRESS
ADD		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN		chmod +x /usr/local/bin/wp \
&&		mkdir -p /var/www/html/wordpress \
&&		cd /var/www/html/wordpress \
&&		wp core download --allow-root

# CONFIGURE DATABASE
RUN		cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/localhost/$MYSQL_HOST/" /var/www/html/wordpress/wp-config.php

# # REPLACE SALTS BY RANDOM GENERATED ONES
# ADD		https://api.wordpress.org/secret-key/1.1/salt/ /var/www/html/wordpress/salt.txt
# RUN		cd /var/www/html/wordpress \
# &&		touch my-wp-config.php \
# &&		start=`expr \`< wp-config.php grep -n -m 1 "AUTH_KEY" | cut -d : -f 1\` - 1` \
# &&		end=`expr \`< wp-config.php wc -l\` - \`< wp-config.php grep -n -m 1 "NONCE_SALT" | cut -d : -f 1\`` \
# &&		head -$start wp-config.php > my-wp-config.php \
# &&		cat salt.txt >> my-wp-config.php \
# &&		tail -$end wp-config.php >> my-wp-config.php \
# &&		rm wp-config.php salt.txt \
# &&		mv my-wp-config.php wp-config.php \
# &&		unset start end

# PORTS
# EXPOSE	9000

# START
COPY	./tools/entrypoint.sh /tmp
ENTRYPOINT	["sh", "/tmp/entrypoint.sh"]
