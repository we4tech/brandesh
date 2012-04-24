Brandesh::Application.routes.draw do
  devise_for :users

  root :to => "contest_registration#new"

  scope '/contest' do
    post 'registration', :to => 'contest_registration#create', :as => 'contest_registration'

    resources :users do
      resources :projects
    end
  end

end
