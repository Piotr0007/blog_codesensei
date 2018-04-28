class ArticlesController < ApplicationController
  def index
  	@articles =Article.all
  end
  def new
  	@article = Article.new
  end
  def create
  	articles_params = params.require(:article).permit(:title, :text)
  	@article = Article.new(articles_params)
  	if @article.save
  	  redirect_to article_path(@article)
  	else
  	  render 'new' 
  	end   
  end 
  def show
  	@article = Article.find(params[:id])
  	
  end

end