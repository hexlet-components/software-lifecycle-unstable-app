start:
	rm -f tmp/pids/server.pid || true
	RAILS_ENV=development bin/rails s -b 0.0.0.0

install:
	bin/setup

.PHONY: test

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop -A

compose-production-run-app:
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml build
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml up

compose-production-console:
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml exec app bin/rails console

ci:	lint
