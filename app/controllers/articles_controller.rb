class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article saved succesfully!"
      redirect_to article_path(@article)
    else 
      render 'new'
    end

  end

  def article_params
    params.require(:article).permit(:title,:description)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
    render 'new'
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article updated succesfully"
      redirect_to article_path(@article)
    else 
      render 'new'
    end
  end
end