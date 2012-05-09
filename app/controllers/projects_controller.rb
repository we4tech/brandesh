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
    if can? :create, Project
      @project       = Project.new
      @root_category = Category.root
      @root_media    = Category.media_root
    else
      warn_and_redirect
    end
  end

  def create
    if can? :create, Project
      @project           = Project.new(params[:project])
      @project.agency_id = current_user.agencies.first.id

      if @project.save
        redirect_to user_projects_path(current_user), :notice => 'Added new ad.'
      else
        @root_category = Category.root
        @root_media    = Category.media_root
        render :action => :new
      end
    else
      warn_and_redirect
    end
  end

  def update
    @project = Project.find(params[:id])

    if can? :update, @project
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
    else
      warn_and_redirect
    end
  end

  def destroy
    project = Project.find(params[:id])
    if can? :destroy, project
      if project.destroy
        redirect_to user_projects_path(current_user), :notice => "Remove ad `#{project.ad_title}`"
      else
        redirect_to user_projects_path(current_user), :notice => "Failed to remove ad `#{project.ad_title}`"
      end
    else
      warn_and_redirect
    end
  end

  def show
    @project = Project.find(params[:id])
    unless can? :show, @project
      warn_and_redirect
    end
  end

  def approved
    @page_title = 'Approved Entries'
    @projects   = Project.approved.recent

    return redirect_to static_page_path('notice') if @projects.empty?

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

