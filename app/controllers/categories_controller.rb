class CategoriesController < ApplicationController
  before_action :require_admin, only: [:create, :edit, :update, :new]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category saved successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def index
    @categories = Category.paginate(page:params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page:params[:page], per_page: 5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in_admin?
      flash[:danger] = "Only admins can perform this action"
      redirect_to categories_path
    end
  end
end