FROM ruby:2.7.5-alpine

ENV BUNDLER_VERSION=2.3.1


RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      npm \
      openssl \
      pkgconfig \
      postgresql-dev \
      python3 \
      tzdata

RUN gem install bundler -v 2.3.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

COPY package.json yarn.lock ./

RUN npm install -g yarn || yarn install --check-files

COPY . ./

EXPOSE '3001'

RUN ./bin/setup

CMD ./bin/stage

