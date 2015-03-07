class MembershipsController < ApplicationController
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
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @membership.update(membership_params)
      flash[:notice] = ""
      redirect_to project_memberships_path(@project.id)
    else
      render :edit
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    flash[:notice] = ""
  end

  private


  def find_and_set_project
    @project= Project.find(params[:project_id])
  end

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end
end
