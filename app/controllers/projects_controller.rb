class ProjectsController < InternalController
  before_action :auth
  before_action :find_and_set_project, only: [:edit, :show, :update]

  def index
    @projects=Project.all
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
      flash[:success] = "Project was successfully created"
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

  def find_and_set_project
    @project = Project.find(params[:id])
  end

end
