class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]  
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_same_admin, only: [:destroy]
  def new
      @user= User.new
  end  
  
  def edit
   
  end 
  
  def update
    
    
    if @user.update(user_param)
      flash[:success]="Your user accounts were successfully updated"  
      redirect_to articles_path
    else
        render 'edit'
    end   
      
  end   
  
  
  def show
    
    @user_articles=@user.articles.paginate(page: params[:page],per_page: 1)
    
  end   
  
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:danger]="All Articles were deleted"
    redirect_to users_path
  end
  
  def index
    @users=User.paginate(page: params[:page], per_page: 5)
  end  
  
  
  
  def create
      
      @user=User.new(user_param)
      
      if @user.save
        session[:user_id]=@user.id
        flash[:success]="Welcome to Alpha blog #{@user.username}"
        redirect_to user_path(@user)
      else
        render 'new'
      end
      
  end   
  
  
  private
    def user_param
      params.require(:user).permit(:username,:email,:password)
    end  
    
    def set_user
      @user=User.find(params[:id])
    end
  
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger]="you can only edit your own account"
        redirect_to root_path
      end  
    end  
    
    def require_same_admin
      if logged_in? and !current_user.admin?
        flash[:danger]="Only Admin User can perform this action"
        redirect_to root_path
      end  
    end  
    
  
end