# syntax=docker/dockerfile:1
FROM ruby:3.1.2-alpine as api
RUN apk add \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs

WORKDIR /var/www/translator_api/current/

COPY Gemfile* /var/www/translator_api/current/

RUN bundle install

COPY . /var/www/translator_api/current/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 5001

CMD ["rails", "server", "-p", "5001", "-b", "0.0.0.0"]