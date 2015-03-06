class TasksController < ApplicationController
  before_action :find_and_set_project
  before_action :auth
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks= @project.tasks
    @name= @project.name
  end

  def new
    @task =  @project.tasks.new
  end


  def create
   @task = @project.tasks.new(task_params)
   if @task.save
     flash[:notice]= 'Task has been created'
     redirect_to project_tasks_path(@project.id)
   else
     render :new
   end
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      @task.completed=false
      flash[:notice]='Task was successfully updated.'
      redirect_to project_tasks_path(@project.id)
    else
      render :edit
    end
  end

  def destroy

    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :completed, :due_date, :project_id)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

end
