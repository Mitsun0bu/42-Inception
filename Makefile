# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: llethuil <llethuil@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/29 18:13:55 by llethuil          #+#    #+#              #
#    Updated: 2022/07/22 15:53:50 by llethuil         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                                                              #
#                              ~~~ VARIABLES ~~~                               #
#                                                                              #
# **************************************************************************** #

NAME		= inception

COMPOSE		= docker-compose --project-directory=srcs -p $(NAME)

# ************************************************************************** #
#                                                                            #
#                              ~~~ RULES & COMMANDS ~~~                      #
#                                                                            #
# ************************************************************************** #

all:		up

re:			fclean all

up:			build
			$(COMPOSE) up --detach

down:
			$(COMPOSE) down

build:		volumes
			$(COMPOSE) build --parallel

create:		build
			$(COMPOSE) create

ps:
			$(COMPOSE) ps --all

exec:
ifeq '$(CONTAINER)' ''
	@echo "Usage: CONTAINER=<CONTAINER_NAME> make exec"
else
	$(COMPOSE) exec $(CONTAINER) /bin/bash
endif

start:
			$(COMPOSE) start

restart:
			$(COMPOSE) restart

stop:
			$(COMPOSE) stop

clean:
			docker-compose --project-directory=srcs down --rmi all

fclean:
			docker-compose --project-directory=srcs down --rmi all --volumes
			sudo rm -rf /home/$(USER)/data/*

volumes:
			@mkdir -p /home/$(USER)/data/site
			@mkdir -p /home/$(USER)/data/db

.PHONY:		all re up down build create ps exec start restart stop clean fclean