
class TrackerProjectsController < InternalController

  def show
    @tracker_api = TrackerAPI.new
    @tracker_project = @tracker_api.project(current_user.pivotal_tracker_token, params[:id])
  end

end
