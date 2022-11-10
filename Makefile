start:
	RAILS_ENV=development bin/dev

install:
	bin/setup

.PHONY: test

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop -A
