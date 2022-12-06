# frozen_string_literal: true

ruby '3.1.3'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# backwards compat
gem 'bigdecimal', '~> 1.3.5'
gem 'globalid', '~> 1.0'
gem 'rexml'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# no db for now
gem 'activerecord-nulldb-adapter'

gem 'ruby-openid', '~> 2.7'
gem 'steam-api', '~> 1.0'
gem 'typhoeus', '~> 0.7'

group :production do
  gem 'puma', '~> 4'
  gem 'rails_12factor', '~> 0.0'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'foreman'
  gem 'pry-byebug'
  gem 'rubocop', '~> 0.78.0', require: false
  gem 'sqlite3', '~> 1.4'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
