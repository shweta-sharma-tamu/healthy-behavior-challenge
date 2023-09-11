FROM ruby:3.1.0

WORKDIR /app

COPY . .
RUN bundle install