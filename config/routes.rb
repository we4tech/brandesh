Brandesh::Application.routes.draw do
  devise_for :users

  root :to => "contest_registration#new"

  post 'contest_registration', :to => 'contest_registration#create', :as => 'contest_registration'
  get 'ads', :to => 'projects#new', :as => 'new_project'
  post 'ads', :to => 'projects#create', :as => 'new_project'

end
