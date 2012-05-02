set :rails_env,             'production'
set :domain,                "welltreat.us:2212"
role :web,                  domain.to_s
role :app,                  domain.to_s
role :db,                   domain.to_s,    :primary => true
set :branch, 'master'

after 'deploy:update' do
  # restart nginx
  #run "cd #{current_path} && #{try_sudo} /etc/init.d/nginx restart"
end
