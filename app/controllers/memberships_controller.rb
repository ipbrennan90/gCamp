class MembershipsController < InternalController
  #before_action :find_and_set_user
  before_action :find_and_set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :project_auth, only: [:index]
  before_action :project_owner_auth, except: [:show, :new, :index]


  def index
    @memberships = @project.memberships.all
    @name = @project.name
    @membership = @project.memberships.new
  end

  def new
    @membership = @project.memberships.new
  end

  def create
    @memberships = @project.memberships
    @membership = @project.memberships.new(membership_params)
    if @membership.save

      flash[:notice] = "User has been successfully added"
      redirect_to project_memberships_path(@project.id)

    else
      render :index
    end
  end

  def update
    if last_owner
      flash[:danger] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project.id)
    elsif @membership.update(membership_params)
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy

    if last_owner
      flash[:danger] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project.id)
    else
      membership=Membership.find(params[:id])
      membership.destroy
      flash[:notice] = "#{membership.user.full_name} was successfully removed"
      redirect_to projects_path
    end
  end



  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def last_owner
    owner_count(@project) == 1 && @membership.role == 1
  end

  def project_owner_auth
    unless current_user.permission || Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(role: 1)) || current_user.id == @membership.user_id
      flash[:danger] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

end
