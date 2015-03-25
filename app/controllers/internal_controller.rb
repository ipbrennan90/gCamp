class InternalController < ActionController::Base
  helper :all
  helper_method :current_user, :auth, :find_and_set_project, :find_and_set_user, :match, :owner_count

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

  unless Rails.application.config.consider_all_requests_local
   rescue_from Exception, with: lambda { |exception| render_error 500, exception }
   rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
