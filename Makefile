#!/bin/bash
.PHONY: default
.SILENT:


default:

_local_env:
	-cp -n ./envfiles/develop.env.sample envfiles/develop.env

shell: _local_env
	docker-compose stop django
	docker-compose run --rm --service-ports django bash

shell_plus: _local_env
	docker-compose run --rm django python manage.py shell_plus

bash_django:
	docker-compose exec django bash

createsuperuser: _local_env
	docker-compose run --rm django python manage.py createsuperuser

migrations: _local_env
	docker-compose run --rm django python manage.py makemigrations

migrate: _local_env
	docker-compose run --rm django python manage.py migrate --noinput

populate_cities:
	docker-compose run --rm django python manage.py cities_light

start: _local_env
	docker-compose up -d

start_django: _local_env
	docker-compose run --rm --service-ports django

stop: _local_env
	docker-compose down

build:
	docker-compose build --force-rm --no-cache --pull

logs:
	docker-compose logs --follow

clean-containers:
	-docker ps -aqf ancestor=shorten | xargs docker rm -f

clean-images:
	-docker images -q -f reference=shorten | xargs docker rmi -f

clean-volumes:
	-docker volume ls -q -f name=shorten* | xargs docker volume rm -f

clean-layers:
	-docker images -q -f dangling=true | xargs docker rmi -f

clean-all: stop clean-containers clean-images clean-volumes clean-layers
