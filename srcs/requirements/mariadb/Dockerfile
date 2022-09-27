FROM	debian:buster

ARG		MYSQL_ROOT_PASSWORD
ARG		MYSQL_DATABASE
ARG		MYSQL_USER
ARG		MYSQL_PASSWORD

# UPDATE & UPGRADE THE SYSTEM
RUN		apt-get update -y && apt upgrade -y

# INSTALL MARIADB
RUN		apt-get install -y mariadb-server

# CREATE THE WORDRPRESS DATABASE
RUN		service mysql start \
&&		mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" \
&&		mysql -e "alter user 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD';" \
&&		mysql -e "grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';" \
&&		mysql -e "flush privileges;"

# PORTS
EXPOSE	3306

# START
ENTRYPOINT	["mysqld", "--bind-address=0.0.0.0"]