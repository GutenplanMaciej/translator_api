source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

gem 'active_model_serializers', '~> 0.10.13'

gem 'rswag-api', '~> 2.8.0'
gem 'rswag-ui', '~> 2.8.0'

gem 'rubocop', '~> 1.38', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 3.0'
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rswag-specs', '~> 2.8.0'
end
