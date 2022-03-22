ARG RUBY_VERSION
ARG ALPINE_VERSION
FROM ruby:${RUBY_VERSION}-alpine${ALPINE_VERSION}

RUN apk add --update --no-cache \
  build-base \
  git \
  nodejs \
  openssl-dev \
  yarn \
  postgresql-dev \
  cmake \
  tzdata \
  less \
  chromium \
  chromium-chromedriver \
  sqlite-dev \
  shared-mime-info

WORKDIR /app
COPY Gemfile Gemfile.lock /app/


RUN bundle install
