class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || detect_next_url(resource)
  end

  protected
    def warn_and_redirect
      redirect_to :root, :alert => 'You are not authorized'
    end

    def detect_next_url(user)
      if user.advertiser?
        new_user_project_path(user)
      elsif user.delegate? && !user.paid
        static_page_path('delegation')
      elsif user.delegate?
        static_page_path('notice')
      elsif user.admin?
        pending_projects_path
      else
        approved_projects_path
      end
    end
  end
