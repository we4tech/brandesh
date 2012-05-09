require 'capistrano/ext/multistage'
require 'rvm/capistrano'
require 'bundler/capistrano'

set :rvm_ruby_string, 'ruby-1.9.3@brandesh'
set :rvm_type, :system
default_run_options[:pty] = true

set :stages, %w(production)
set :default_stage, "production"

set :application, "brandesh"
set :deploy_to, lambda { "/home/#{application}/app_#{stage}" }
set :user, "brandesh"
set :scm, :git
set :scm_verbose, true
#set :deploy_via, :remote_cache
set :repository, "git://github.com/we4tech/brandesh.git"
set :branch, "master"
set :runner, user

set :use_sudo, false

namespace :util do
  desc 'Symblink database configuration'
  task :symlink_db_config do
    run "cd #{current_path} && rm #{current_path}/config/database.yml"
    run "cd #{current_path} && ln -s #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

  desc 'Migrate database'
  task :db_migrate do
    #run "cd #{current_path} && rake db:schema:load RAILS_ENV=#{stage.to_s} && rake db:seed RAILS_ENV=#{stage.to_s}"
    run "cd #{current_path} && rake db:migrate RAILS_ENV=#{stage.to_s}"
  end

  desc 'Assets precompile'
  task :assets_precompile do
    run "cd #{current_path} && rake assets:precompile RAILS_ENV=#{stage.to_s}"
  end

  desc 'Stop app server'
  task :stop_app do
    run "cd #{current_path} && cat #{current_path}/tmp/pids/unicorn.pid | xargs kill -9 \"$@\""
  end

  desc 'Start app server'
  task :start_app do
    run "cd #{current_path} && unicorn_rails -p 8800 -E #{stage.to_s} -D"
  end
end

before 'deploy:update', 'util:stop_app'
after 'deploy:update', 'util:symlink_db_config',
      'util:db_migrate', 'util:assets_precompile',
      'util:start_app'