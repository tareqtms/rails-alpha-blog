class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :logged_in_admin?

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def logged_in_admin?
    logged_in? && current_user.admin?
  end

  def require_user
    unless logged_in?
      flash[:danger] = "You need to login to perform this action"
      redirect_to articles_path
    end
  end
end
