class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end
  
  def new
    @article ||= Article.new
    @article.autorizim_articles.build
  end
  
  def create
      @article = Article.new(article_params)
      if @article.save
          flash[:success] = "Article successfuly updated"
          redirect_to @article
          
      else
          render 'new'
      end
  end
  
  def show
      @article = Article.find(params[:id])
      
  end
  
  def edit
      @article = Article.find(params[:id])
  end
  
  def destroy
      @article.destroy
      flash[:success] = "Article deleted"
      redirect_to articles_path
  end
  
  def update 
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article successfuly updated"
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  private
  
    def article_params
        params.require(:article).permit(:pershkrimi, :kategoria, :tarif_kodi, :njesia, :kodi, :pershkrimi_gjate,
        :lloji_akcizes, :akciza, :dogana, :tvsh,
        autorizim_articles_attributes: [:id, :article_id, :autorizim_id])
    end
    
    def find_article
        @article = Article.find(params[:id])
    end
    
end