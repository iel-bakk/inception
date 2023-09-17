# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: iel-bakk <iel-bakk@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/12 19:54:29 by iel-bakk          #+#    #+#              #
#    Updated: 2023/09/17 23:57:15 by iel-bakk         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: clean build

build:
	mkdir -p /Users/iel-bakk/Desktop/iel-bakk/MDB
	mkdir -p /Users/iel-bakk/Desktop/iel-bakk/wordpress
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml down

up:
	docker-compose -f srcs/docker-compose.yml up

clean:
	rm -rf /Users/iel-bakk/Desktop/iel-bakk/MDB
	rm -rf /Users/iel-bakk/Desktop/iel-bakk/wordpress
	docker-compose -f srcs/docker-compose.yml down -v

.PHONY: all clean build stop up% 