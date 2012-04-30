Brandesh::Application.routes.draw do
  devise_for :users

  root :to => "contest_registration#home"

  scope '/contest' do
    get 'join', :to => 'contest_registration#new', :as => 'join_contest_registration'
    post 'registration', :to => 'contest_registration#create', :as => 'contest_registration'

    scope '/search' do
      post 'agency', :to => 'search#agencies', :as => 'search_agency'
    end

    resources :users do
      resources :projects
    end
  end

end
