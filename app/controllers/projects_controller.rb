require_relative "TrackerAPI"
class ProjectsController < InternalController
  before_action :auth
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  before_action :project_auth, only: [:show]
  before_action :project_owner_auth, only: [:edit, :update, :destroy]

  def index
    @projects= Project.all
    @tracker_api = TrackerAPI.new
    @tracker_projects = @tracker_api.projects(current_user.pivotal_tracker_token)
    @user_projects = []
    @projects.each do |r|
      r.users.cycle(1) {|x| if x.id == current_user.id
        @user_projects<< r
      end}
    end
  end

  def new
    @project= Project.new
  end

  def create
    @user=current_user
    @project=Project.new(project_params)
    if @project.save
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
      @project.memberships.create!(role: 1, user_id: @user.id)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Project was successfully updated"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = "Project was successfully deleted"
    project=Project.find(params[:id])
    project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_owner_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(role: 1) || current_user.permission == true)
      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end
  end

  def project_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id)) || current_user.permission == true
      flash[:danger] = "You do not have access"
      redirect_to project_path(@project)
    end
  end



end
