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
      redirect_to tasks_path(@task)
    else
      render "task/show"
    end
  end





  private

  def comment_params
    params.require(:comment).permit(:content, :task_id, :user_id)
  end

  def find_and_set_task
    @task = Task.find(params[:task_id])
  end


end
