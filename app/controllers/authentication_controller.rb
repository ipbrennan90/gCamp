class AuthenticationController < ApplicationController


  def new
    session[:user_id] = nil
  end


  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] ="You have successfully signed in"
      if after_sign_in_path_for(user)==root_path
        redirect_to projects_path
      else
        redirect_to after_sign_in_path_for(user)
      end 

    else
      flash[:failure] = "Email / Password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path

  end


end
