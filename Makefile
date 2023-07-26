DOCKER_COMPOSE_YML		= srcs/docker-compose.yml
DOCKER_DATA_DIR			= $(HOME)/data
DOMAIN					= "127.0.0.1	jiyun.42.fr"

all : run

run : data_dir domain
	docker-compose -f $(DOCKER_COMPOSE_YML) build --no-cache
	docker-compose -f $(DOCKER_COMPOSE_YML) up -d
up :
	docker-compose -f $(DOCKER_COMPOSE_YML) up -d

data_dir :
	mkdir -p $(DOCKER_DATA_DIR)/mariadb
	mkdir -p $(DOCKER_DATA_DIR)/wordpress

domain :
	@if [ ! "$$(sudo grep $(DOMAIN) /etc/hosts)" ]; then sudo sh -c 'echo $(DOMAIN) >> /etc/hosts'; fi

clean :
	docker-compose -f $(DOCKER_COMPOSE_YML) down --rmi all --volumes
	docker system prune -a
	sudo rm -rf $(DOCKER_DATA_DIR)

fclean : clean
	sudo sed -i s/$(DOMAIN)//g /etc/hosts

.PHONY: all run clean fclean