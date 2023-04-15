# README
Translator API - An API with several endpoints to manage glossaries and translations.

# Requirements
- Ruby 3.1.2
- Rails 7.0.4
- Postgresql 9.3 or higher

# Tests

- Run `bundle install`
- Run `rails db:create db:migrate`
- Run `rspec .`

# Rubocop

RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter \
To check code run `rubocop` or with auto correction `rubocop -A`

# Documentation

Generate swagger yml file for controllers `SWAGGER_DRY_RUN=0 RAILS_ENV=test rails rswag PATTERN="spec/controllers/**/*_spec.rb"` \
Check documentations at `localhost:3000/api-docs` or `localhost:5001/api-docs` while using docker container

# List of env variables needed

- POSTGRES_USER
- POSTGRES_PASSWORD
- RAILS_MASTER_KEY

# Docker

Run `docker build -t translator_api .` in root directory \
Run `docker compose up` to start containers