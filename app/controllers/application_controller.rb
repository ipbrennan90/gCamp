class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  helper_method :current_user, :auth, :find_and_set_project, :find_and_set_user

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end

  def auth
    unless current_user
      redirect_to sign_in_path
      flash[:danger] = "You must sign in"
    end
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

  def find_and_set_user
    @user = User.find(params[:user_id])
  end


end
