class ContestRegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.agency = Agency.new(params[:agency])
    if @user.save
      redirect_to :root
    else
      render :action => :new
    end
  end
end

