class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @user = User.new(params[:user])
    @project = Project.new(params[:project])
    @project.agency_id = current_user.agency.id
    if @project.save
      redirect_to :root
    else
      render :action => :new
    end
  end
end

