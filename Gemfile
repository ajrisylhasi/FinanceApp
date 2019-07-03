source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use sqlite3 as the database for Active Record

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets

gem 'ransack'

gem 'bootstrap-sass', '~> 3.2.0'

gem 'bootstrap-datepicker-rails'

gem 'sass-rails', '~> 5.0'

gem 'passenger', '~> 5.0', '>= 5.0.30'

gem 'jquery-rails'

gem 'nested_form', '~> 0.3.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jquery-turbolinks', '~> 2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
  gem 'bcrypt', '3.1.7'
gem 'validates_timeliness', '~> 5.0.0.alpha3'

gem 'wicked_pdf'

gem 'loading_screen', '~> 0.2.3'

gem 'popper_js', '~> 1.9', '>= 1.9.9'

gem 'carrierwave'

gem 'rmagick', '~> 3.1'


gem 'wkhtmltopdf-binary'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.3.2', require: false

group :production do
  gem 'pg', '0.20.0'
  gem 'rails_12factor'
end

group :development do
  gem 'web-console', '3.5.1'
  gem 'listen', '3.1.5'
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', '9.0.6', platform: :mri
  
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
