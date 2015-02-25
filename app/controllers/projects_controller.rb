class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :show, :update]

  def index
    @projects=Project.all
  end

  def new
    @project= Project.new
  end

  def create
    @project=Project.new(project_params)
    if @project.save
      flash[:success] = "Project was successfully created"
      redirect_to projects_path
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

  def set_project
    @project=Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
