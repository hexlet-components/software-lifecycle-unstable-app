start:
	rm -f tmp/pids/server.pid || true
	RAILS_ENV=development bin/rails s -b 0.0.0.0

install:
	bin/setup

test:
	bin/rails test

lint:
	bundle exec rubocop
	pnpm exec herb-lint app/views

lint-fix:
	bundle exec rubocop -A

compose-production-run-app:
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml build
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml up

compose-production-console:
	docker-compose -p rails_bulletin_board_project_ru-production -f docker-compose.production.yml exec app bin/rails console

ci: lint test

.PHONY: test
