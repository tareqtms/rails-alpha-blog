class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in!"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Username or password doesn't match!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end