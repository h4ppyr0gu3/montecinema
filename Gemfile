source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8.0'
gem 'devise_token_auth', '~> 1.2.0'
gem 'dotenv-rails', '~> 2.7.6'
gem 'minitest', '~> 5.14.4'
gem 'omniauth', '~> 2.0.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.1.4'
gem 'rswag', '~> 2.4.0'
gem 'sidekiq', '~> 6.2.1'
gem 'sidekiq-cron', '~> 1.2.0'
gem 'sentry-ruby', '~> 4.6.4'
gem 'sentry-rails', '~> 4.6.4'
gem 'multi_json'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

group :development, :test do
  gem 'byebug', '>= 11.1.3'
  gem 'factory_bot_rails', '6.2.0'
  gem 'rspec-rails', '~> 5.0.1', require: false
end

group :development do
  gem 'brakeman', '~> 5.1.1'
  gem 'bullet', '~> 6.1.4'
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.18.4'
  gem 'rubocop-rails', '~> 2.11.3',require: false
  gem 'rubocop-rspec', '~> 2.4.0', require: false
  gem 'spring', '>= 2.1.1'
end

group :test do
  gem 'database_cleaner', '~> 2.0.1'
  gem 'simplecov', '~> 0.21.2', require: false
end
