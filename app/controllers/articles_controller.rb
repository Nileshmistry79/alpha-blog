class ArticlesController < ApplicationController
  
  def new
    @article=Article.new
    
  end   
  
  
  def index
    @artilce_all=Article.all
  end  
    
  
  def create
    #render plain: params[:article].inspect
    
    @article=Article.new(parm_method)
    
    if @article.save
      flash[:notice] = "New Article is created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end  
  
  
  def update
    @article=Article.find(params[:id])
    
    if @article.update(parm_method)
      flash[:notice] = "New Article is UPDATED"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end  
    
  
  def show
    @article=Article.find(params[:id])
  end  
  
  
  def destroy
    @article=Article.find(params[:id])
    @article.destroy
    flash[:notice]="Articles is removed"
    redirect_to articles_path
  end 
  
  def edit
    @article=Article.find(params[:id])
  end  
  
  private
    def parm_method
      params.require(:article).permit(:title,:desc)
    end 
  
end