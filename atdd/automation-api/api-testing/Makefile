DOCKER_COMPOSE_FILE = ./docker-compose.yml

all: start_db db_migration mock_api api test down all_done

arrange: start_db mock_api db_migration

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

start_db:
	docker compose -f $(DOCKER_COMPOSE_FILE) up db -d --build

db_migration:
	docker compose -f $(DOCKER_COMPOSE_FILE) up db-migration --exit-code-from db-migration --build

# redis:
# 	docker compose -f $(DOCKER_COMPOSE_FILE) up redis -d --build

mock_api:
	docker compose -f $(DOCKER_COMPOSE_FILE) up mock-api -d --build

api:
	docker compose -f $(DOCKER_COMPOSE_FILE) --env-file ./.env.test up api -d --build

test:
	docker compose -f $(DOCKER_COMPOSE_FILE) up api-test --build

all_done:
	echo "All step done"
