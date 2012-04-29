class ContestRegistrationController < ApplicationController

  def home
    @page_context = :full_page
  end

  def new
    @user        = User.new(params[:user])
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

