class ArticlesController < ApplicationController
  
  def new
    @article=Article.new
    
  end   
  
  
  def create
    #render plain: params[:article].inspect
    
    @article=Article.new(parm_method)
    @article.save
    
    redirect_to articles_show(@article)
  end  
  
  private
    def parm_method
      params.require(:article).permit(:title,:desc)
    end 
  
end