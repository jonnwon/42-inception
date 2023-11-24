MARIADB_VOLUME = /home/jonchoi/data/mariadb
WORDPRESS_VOLUME = /home/jonchoi/data/wordpress
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	sudo mkdir -p $(MARIADB_VOLUME)
	sudo mkdir -p $(WORDPRESS_VOLUME)
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v --rmi all --remove-orphans

fclean: clean
	sudo rm -rf /home/jonchoi
	docker system prune --volumes --all --force

re:
	make fclean
	make all

.PHONY:
	all up down clean fclean re
