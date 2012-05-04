class UsersController < ApplicationController
  before_filter :authenticate_user!

  def all
    user_type = params[:user_type]
    if can?(:manage, User) && (user_type == 'none' || User::TYPES.include?(user_type.to_sym))
      @users = if user_type == 'none'
        User.recent
      else
        User.send(user_type).recent
      end

      if user_type == 'none'
        @page_title = 'All Users'
      else
        @page_title = user_type.to_s.humanize
      end

      render :index
    else
      warn_and_redirect
    end
  end

  def set_as_paid
    if can? :manage, User
      user = User.find(params[:id])
      if user.update_attribute :paid, true
        redirect_to :back, :notice => 'Set user as paid'
      else
        redirect_to :back, :alert => 'Failed to set user as paid'
      end
    else
      warn_and_redirect
    end
  end
end
