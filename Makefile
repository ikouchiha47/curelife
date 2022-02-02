.PHONY: run

run:
	env $(shell cat .env.local | xargs) ./bin/rails s

run.cli:
	env $(shell cat .env.local | xargs) ./bin/rails c

run.css: 
	tailwindcss --postcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --watch

docker:
	docker-compose config > /tmp/docker-compose-rendered.yml
	env $(shell cat .env.dev | xargs) docker-compose -f /tmp/docker-compose-rendered.yml up
