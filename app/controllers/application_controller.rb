class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || user_projects_path(current_user)
  end
end
