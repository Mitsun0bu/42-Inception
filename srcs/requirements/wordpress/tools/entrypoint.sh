#!/bin/bash

# WORDPRESS SITE SETUP
cd /var/www/html/wordpress
if ! wp core is-installed --allow-root
then
	wp core install	--allow-root \
					--url=$DOMAIN_NAME \
					--title="$WP_SITE_TITLE" \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL
fi

# LAUNCH PHP-FPM
php-fpm7.3 -F