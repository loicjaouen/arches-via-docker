.PHONY: init-volumes
init-volumes: ## 1. do this only once
	docker volume create --name=logs_nginx
	docker volume create --name=nginx_ssl
	docker volume create --name=certbot_certs
	docker volume create --name=arches_certbot

.PHONY: build
build: ## 2. build images
	docker compose build

.PHONY: up
up: ## 3. first start of the stack: builds containers and start them, run init scripts
	docker compose up --detach

.PHONY: logs
logs: ## 4. show logs of the containers
	docker compose logs --follow

.PHONY: ps
ps: ## 5. list runing containers
	docker compose ps

.PHONY: stop
stop: ## 6. stop the containers
	docker compose stop

.PHONY: start
start: ## 6. start the containers, after they have been stopped, be patient and loo at the logs
	docker compose start

.PHONY: down
down: ## 7. stop and delete the running containers
	docker compose down

.PHONY: volumes-list
volumes-list: ## 7. list existing volumes
	docker volume ls

.PHONY: volumes-clean-generated
volumes-clean-generated: ## 9. delete generated volumes
	docker volume ls | grep arches_proj | awk '{ print $2 }' | xargs docker volume rm

.PHONY: volumes-clean-created
volumes-clean-created: ## 10. delete generated volumes (in step 1.)
	docker volume rm logs_nginx nginx_ssl certbot_certs arches_certbot

.PHONY: help
help: ## 0. this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort -k 3

.DEFAULT_GOAL := help
