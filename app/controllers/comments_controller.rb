class CommentsController < ApplicationController
  before_action :find_and_set_task
  def index

    @comments= @task.comments.all
    @comment = @task.comments.new
  end

  def create
    @comment = @task.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "comment noted"
      redirect_to project_task_path(@task.project.id, @task)
    else
      redirect_to project_task_path(@task.project.id, @task)
    end
  end





  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def find_and_set_task
    @task = Task.find(params[:task_id])
  end


end
