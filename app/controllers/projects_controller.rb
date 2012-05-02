class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_title = 'All Entries'
    @projects   = current_user.projects
  end

  def edit
    @project       = current_user.projects.find(params[:id])
    @root_category = Category.root
    @root_media    = Category.media_root
    render :new
  end

  def new
    @project       = Project.new
    @root_category = Category.root
    @root_media    = Category.media_root
  end

  def create
    @project           = Project.new(params[:project])
    @project.agency_id = current_user.agencies.first.id

    if @project.save
      redirect_to user_projects_path(current_user), :notice => 'Added new ad.'
    else
      @root_category = Category.root
      @root_media    = Category.media_root
      render :action => :new
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    _params  = params[:project].except(:id, :agency_id)

    _params.delete(:proof) unless _params[:proof].present?
    _params.delete(:media) unless _params[:media].present?

    if @project.update_attributes(_params)
      redirect_to user_projects_path(current_user), :notice => "Update `#{@project.ad_title}`"
    else
      @root_category = Category.root
      @root_media    = Category.media_root
      render :action => :new
    end
  end

  def destroy
    project = current_user.projects.find(params[:id])
    if project.destroy
      redirect_to user_projects_path(current_user), :notice => "Remove ad `#{project.ad_title}`"
    else
      redirect_to user_projects_path(current_user), :notice => "Failed to remove ad `#{project.ad_title}`"
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def approved
    @page_title = 'Approved Entries'
    @projects   = Project.approved.recent
    render :index
  end

  def pending
    @page_title = 'Pending Entries'
    @projects   = Project.pending.recent
    render :index
  end

  def rejected
    @page_title = 'Rejected Entries'
    @projects   = Project.rejected.recent
    render :index
  end

  def update_status
    status = params[:status]
    raise 'Invalid status type' unless Project::STATUS.include?(status.to_sym)

    Project.find(params[:id]).send :"#{status}!"
    redirect_to :back
  end

end

