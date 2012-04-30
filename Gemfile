source 'http://rubygems.org'

gem 'rails', '3.2.3'


gem 'haml-rails'
gem 'devise'
gem 'paperclip', '~> 3.0'
gem 'factory_girl'
gem 'factory_girl_rails'
gem "velir_kaltura-ruby", :require => "kaltura"
gem 'acts_as_kaltura', '>= 1.2.1'

group :test do
  gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem 'rspec-rails'
  gem 'rspec-core'
  gem 'rspec2-rails-views-matchers'
  gem 'shoulda-matchers'
  gem 'ZenTest'
  gem 'autotest-rails'
end

group :development, :ci do
  gem 'mysql2'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
end

group :staging do
  #gem 'pg'
end

group :production do
  gem 'mysql2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end


