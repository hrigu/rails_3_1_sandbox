source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem "haml-rails"
gem "simple_form"

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'database_cleaner'
  gem 'rails3-generators' #mainly for factory_girl & simple_form at this point
  gem 'factory_girl_rails'
  gem 'cucumber-rails'
  gem 'mocha'
end

#to enable the rake tasks, rspec-rails must be in the development group: see https://www.relishapp.com/rspec/rspec-rails and https://github.com/rspec/rspec-rails/issues/438
group :test, :development do
  gem 'rspec-rails', "~> 2.4"
end

# for javascript engine
gem 'execjs'
gem 'therubyracer'


# for generate doc
gem "RedCloth"