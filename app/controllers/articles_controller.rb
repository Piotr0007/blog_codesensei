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
    @article = Article.new(permitted_attributes(Article))
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
    @like = Like.find_or_initialize_by(article: @article, user: current_user)  

    respond_to do |format|
    format.html do 
      render
  end
    format.json do
    render json: {
      id: @article.likes.count, 
      comments: @article.comments.count
    }
  end
  end 
  end


  def edit; end

  def update
  	if @article.update(permitted_attributes(@article))
      flash[:notice] = "Your article has been saved"
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

  #def article_params
  #	params.require(:article).permit(:title, :text, :tags)
  #end

  def find_article
  	@article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end


end