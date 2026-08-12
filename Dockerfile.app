FROM ruby:4.0.6-slim

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  libsqlite3-dev \
  make \
  curl \
  git

RUN curl -sL https://deb.nodesource.com/setup_26.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global pnpm@11

ENV DISABLE_SPRING=1
ENV RAILS_SERVE_STATIC_FILES=enabled

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .

RUN pnpm run build
# NOTE: env for display errors for qa
RUN bin/rails assets:precompile

CMD ["bash", "-c", "make start"]
