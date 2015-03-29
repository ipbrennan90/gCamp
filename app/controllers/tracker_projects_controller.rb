require_relative "TrackerAPI"
class TrackerProjectsController < InternalController

  def index
    @tracker_api = TrackerAPI.new
    @tracker_project = @tracker_api.project(current_user.pivotal_tracker_token, params[:project_id])
  end
end
