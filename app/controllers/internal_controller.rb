class InternalController < ActionController::Base
  helper :all
  helper_method :current_user, :auth, :find_and_set_project, :find_and_set_user, :match, :owner_count
  before_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != sign_in_path &&
        request.path != sign_up_path &&
        request.path != sign_out_path &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
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

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

  def find_and_set_user
    @user = User.find(params[:user_id])
  end

  def match(user)
    match = user.memberships.pluck(:project_id) & current_user.memberships.pluck(:project_id)
    match.empty?
  end

  def owner_count(project)
    project.memberships.where(role:1).count
  end

  


end
