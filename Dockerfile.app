FROM ruby:3.1.2-slim

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  libsqlite3-dev \
  make \
  curl \
  git

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn

ENV DISABLE_SPRING=1
ENV RAILS_SERVE_STATIC_FILES=enabled

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY package.json .
COPY yarn.lock .
RUN yarn install

COPY . .

RUN yarn build
# NOTE: env for display errors for qa
RUN RAILS_ENV=development SECRET_KEY_BASE=key_for_build bin/rails assets:precompile

CMD ["bash", "-c", "bin/rails server -b 0.0.0.0 -p $PORT -e $RAILS_ENV"]
