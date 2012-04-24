class ContestRegistrationController < ApplicationController
  def new
    @user = User.new
    @user.agency = Agency.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to new_user_project_path(@user)
    else
      render :action => :new
    end
  end
end

