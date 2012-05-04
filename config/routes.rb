Brandesh::Application.routes.draw do
  devise_for :users

  root :to => "contest_registration#home"
  get '/static/:page_name', :to => 'static_page#serve', :as => 'static_page'

  scope '/contest' do
    get 'join', :to => 'contest_registration#new', :as => 'join_contest_registration'
    post 'registration', :to => 'contest_registration#create', :as => 'contest_registration'
    get 'entries/approved', :to => 'projects#approved', :as => 'approved_projects'
    get 'entries/pending', :to => 'projects#pending', :as => 'pending_projects'
    get 'entries/rejected', :to => 'projects#rejected', :as => 'rejected_projects'
    get 'entries/:id/:status', :to => 'projects#update_status', :as => 'update_project_status'
    get 'all/:user_type', :to => 'users#all', :as => 'all_users'

    scope '/search' do
      post 'agency', :to => 'search#agencies', :as => 'search_agency'
    end

    resources :users do

      member do
        get :set_as_paid
      end

      resources :projects
    end
  end

end
