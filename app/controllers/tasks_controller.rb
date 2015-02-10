class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks= Task.all
  end

  def new
    @task= Task.new
  end


  def create
   @task = Task.new(task_params)
   if @task.save
     redirect_to task_path(@task), notice: "wahtever"
   else
     render: new
   end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      flash[:success]='Task was successfully updated.'
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    task= Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end