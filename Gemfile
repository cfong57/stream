source 'https://rubygems.org'

#trying to make Guard work properly
require 'rbconfig'
gem 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i

gem 'rails', '3.2.14'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '4.0.0.rc2'

gem 'pg'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

#https://github.com/dejan/auto_html
#allows simple embedding of youtube links and other html resources
gem 'auto_html'

#performance monitoring
gem 'newrelic_rpm'

#blah blah blah content-length of response body
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 2.3.1.0'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', '~> 2.5.1' #weird error with latest version
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
end

# Use SCSS for stylesheets
# gem 'sass-rails', '~> 4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# seeding
# :path => "C:/Users/Alex/Desktop/bloc/code/faker"
# :git => "git@github.com:/cfong57/faker.git"
gem 'faker', :git => "git://github.com/cfong57/faker.git"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# security
gem 'devise', '~> 3.0.0'
gem 'figaro'

# permissions
gem 'cancan'

# markdown
gem 'redcarpet'

# stuff for handling images
gem 'carrierwave'
gem 'mini_magick', '~> 3.5.0'

# Amazon Web Services helper gem
gem 'fog'

# pagination
gem 'will_paginate', '~> 3.0'

# universal authorization
gem 'omniauth'
gem 'omniauth-facebook'

# "tagging"
gem 'acts-as-taggable-on'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# for possible future improvements
# gem 'simple_form'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
