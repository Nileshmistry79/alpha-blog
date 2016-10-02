class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit,:update,:show,:destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_user_same, only: [:edit, :destroy, :update]
  
  def new
    @article=Article.new
  end   
  
  
  def index
    @artilce_all=Article.paginate(page: params[:page], per_page: 5)
  end  
    
  
  def create
    
    @article=Article.new(parm_method)
    @article.user=current_user
    if @article.save
      flash[:success] = "New Article is created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end  
  
  
  def update
    if @article.update(parm_method)
      flash[:success] = "New Article is UPDATED"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end  
    
  
  def show
    
  end  
  
  
  def destroy
    @article.destroy
    flash[:danger]="Articles is removed"
    redirect_to articles_path
  end 
  
  def edit
  
  end  
  
  private
    def set_article
      @article=Article.find(params[:id])  
    end
    def parm_method
      params.require(:article).permit(:title,:desc)
    end 
    
    def require_user_same
      if current_user != @article.user and !current_user.admin?
        flash[:danger]="you can only edit/delete your own article"
        redirect_to root_path
      end  
    end  
  
end