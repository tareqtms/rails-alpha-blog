class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page:params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog!"
      redirect_to user_path(@user)
    else
      render 'new'
    end

  end

  def edit
    render 'new'
  end

  def update
    if(@user.update(user_params))
      flash[:success] = "Account updated succesfully!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @articles = @user.articles.paginate(page:params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:success] = "User and all associated artices are deleted!"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    unless @user == current_user || current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = "Only admin users can perform that action!"
      redirect_to root_path
    end
  end
end