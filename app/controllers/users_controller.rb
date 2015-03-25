class UsersController < InternalController
  before_action :auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users=User.all
  end

  def new
    @user= User.new
  end

  def create

    @user=User.new(user_params)
    if @user.save
      flash[:notice]="User was successfully created"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    render 
  end

  def show
  end

  def update
    if @user.update(user_params)
      flash[:notice]="User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy

    @user.destroy
    session[:user_id] = nil
    redirect_to users_path


  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :permission)
  end

  def match(user)
    match = user.memberships.pluck(:project_id) & current_user.memberships.pluck(:project_id)
    match.empty?
  end


end
