class RegistrationController < InternalController

  def new
    @user= User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed up"
      redirect_to projects_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :password_confirmation, :pivotal_tracker_token)
  end
end
