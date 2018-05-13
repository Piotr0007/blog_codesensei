class ArticlesController < ApplicationController
	  before_action :find_article, only: %i[show update edit destroy]
    before_action :authorize_article, only: %i[edit update destroy]
  def index
    @articles =Article.page(params[:page])
   
    @articles = @articles
                .where("? = any(tags)",
                       params[:q].downcase) if params[:q].present?
  end

  def new
  	@article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user
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

  def authorize_article
    if @article.author != current_user
      flash[:alert] = "This is not your article"
      redirect_to articles_path
    end
  end


end
