class ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :update, :edit, :destroy]
  def index
    
  	@articles =Article.all
    if params[:q].present?
      @articles = @articles.where("? = any(tags)", params[:q].downcase)
    end
  end

  def new
  	@article = Article.new
  end

  def create
    @article = Article.new(article_params)
  	if @article.save
  	  redirect_to article_path(@article)
      flash[:notice] = 'You comment has been saved'
  	else
  	  render 'new' 
  	end   
  end 
  def show
    @comment = @article.comments.build(commenter: session[:commenter])
  end
  def edit
    
 
  end

  def update
  	
  
  	if @article.update(article_params)
  		redirect_to article_path(@article)
  	else
  	render 'edit'	
    end
  end
  def destroy
  	
  	@article.destroy
  	redirect_to articles_path
    flash[:notice] = 'You comment has been deleted'
  end	

  private

  def article_params
  	params.require(:article).permit(:title, :text, :tags)
  end
  def find_article
  	@article = Article.find(params[:id])
  end


end
