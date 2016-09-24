class ArticlesController < ApplicationController
  
  def new
    @article=Article.new
    
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
  
  def show
    @article=Article.find(params[:id])
  end  
  
  
  private
    def parm_method
      params.require(:article).permit(:title,:desc)
    end 
  
end