FROM	debian:buster

# UPDATE & UPGRADE THE SYSTEM
RUN		apt-get update -y \
&&		apt-get upgrade -y

# INSTALL NGINX
RUN		apt-get install -y nginx \
&&		apt-get install -y openssl

# GENERATE SSL KEY & CERTIFICATE
RUN		mkdir -p /etc/nginx/ssl \
&&		openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/llethuil.42.fr.key -out /etc/nginx/ssl/llethuil.42.fr.crt -subj /C=FR

# CONFIGURE NGINX
COPY	./conf/nginx.conf /etc/nginx/sites-available/llethuil.42.fr.conf
RUN		ln -s /etc/nginx/sites-available/llethuil.42.fr.conf /etc/nginx/sites-enabled/llethuil.42.fr.conf

# PORTS
# EXPOSE	443

# START
ENTRYPOINT	["nginx", "-g", "daemon off;"]