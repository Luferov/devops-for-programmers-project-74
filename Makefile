.PHONY=dev,test,push,init

init:	## Инициализация старта
ifeq ("$(wildcard ./app/.env)", "")
	@cp ./app/.env.example ./app/.env
endif
ifeq ("$(wildcard ./.env)", "")
	@cp .env.example .env
endif
	docker-compose run --rm app npm ci

test:	## Запуск тестов
ifeq ("$(wildcard ./.env)", "")
	@cp .env.example .env
endif
	docker-compose -f docker-compose.yml up --build --abort-on-container-exit --exit-code-from app

dev:	## Запуск проекта в Dev режиме
	docker compose up --abort-on-container-exit --exit-code-from app

TAG ?= latest
push:	## Собираем и пушим образ
	docker login
	docker build -t luferov/services-app:$(TAG) --push -f Dockerfile.production .