class UsersController < ApplicationController
  def index
    @users = User.paginate(page:params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog!"
      redirect_to articles_path
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
    render 'new'
  end

  def update
    @user = User.find(params[:id])
    if(@user.update(user_params))
      flash[:success] = "Account updated succesfully!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page:params[:page], per_page: 5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end