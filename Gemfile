source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
  gem 'thin'
  #heroku gems for log and asstets
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end
# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails',   '~> 4.0.0.rc2'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.3.0'


gem 'jquery-rails'

group :test do
  gem 'rake' # for travis, see http://about.travis-ci.org/docs/user/languages/ruby/
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'

  gem 'minitest-spec-rails' # adds the describe / it test dsl as used in second & third example
  gem 'capybara_minitest_spec' # adds the capybara expectations as used in the third example
  gem 'selenium-webdriver'

end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'debugger'

# gems to work with facebook api
gem 'omniauth-facebook'
gem 'fb_graph'
