class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  helper_method :current_user, :auth, :project_auth


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

  def project_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id))

      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end


  end






end
