class MembershipsController < InternalController
  #before_action :find_and_set_user
  before_action :find_and_set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = @project.memberships
    @name = @project.name
    @membership = @project.memberships.new
  end

  def new
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "User has been successfully added"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      flash[:notice] = ""
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy
    if owner_count(@project) == 1 && @membership.role == 1
      flash[:danger] = "Projects much have at least one owner"
      redirect_to project_memberships_path(@project.id)
    else
      membership = Membership.find(params[:id])
      membership.destroy
      flash[:notice] = "#{membership.user.full_name} was successfully removed"
      redirect_to project_memberships_path(@project.id)
    end
  end

  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def owner_count(project)
    project.memberships.where(role:1).count
  end

end
