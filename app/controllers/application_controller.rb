class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  before_filter :store_location
  helper_method :current_user, :auth, :project_auth, :project_owner_auth



  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.

    if (request.path != sign_in_path &&
        request.path != sign_up_path &&
        request.path != sign_out_path)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url]
  end


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

  def project_owner_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(role: 1) || current_user.permission == true)

      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end
  end

  def project_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id)) || current_user.permission == true

      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end
  end






end
