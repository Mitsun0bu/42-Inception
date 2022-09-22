FROM	debian:buster

# SYSTEM UPDATE AND DEPENDENCIES
RUN		apt-get update -y && apt-get upgrade -y

# NGINX INSTALLATION
RUN		apt-get install -y nginx

# CONFIGURATIONS
COPY	./conf/nginx.conf /etc/nginx/sites-available/llethuil.42.fr.conf
RUN		ln -s /etc/nginx/sites-available/llethuil.42.fr.conf /etc/nginx/sites-enabled/llethuil.42.fr.conf

# PORTS
EXPOSE	443

# START
ENTRYPOINT	["nginx", "-g", "daemon off;"]