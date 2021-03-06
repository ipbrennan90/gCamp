class UsersController < InternalController
  before_action :auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :hide_token
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
    unless current_user.id == @user.id || current_user.permission==true
      render_404
    end
    @user.skip_password_validation= true
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
    user = User.find(params[:id])
    if user == current_user
      session[:user_id]=nil
    end
    user.destroy
    redirect_to users_path
  end

  private

  def hide_token(token)
    unless token.empty?
      asterisk = "*"*(token.length-3)
      hidden_token="#{token[0..3]}#{asterisk}"
      hidden_token
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:permission, :pivotal_tracker_token)
  end

  def match(user)
    match = user.memberships.pluck(:project_id) & current_user.memberships.pluck(:project_id)
    match.empty?
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end


end
