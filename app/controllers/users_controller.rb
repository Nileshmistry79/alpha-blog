class UsersController < ApplicationController
  
  def new
      @user= User.new
  end  
  
  def edit
    @user=User.find(params[:id])
  end 
  
  def update
    @user=User.find(params[:id])
    
    if @user.update(user_param)
      flash[:success]="Your user accounts were successfully updated"  
      redirect_to articles_path
    else
        render 'edit'
    end   
      
  end   
  
  
  
  def create
      #debugger
      @user=User.new(user_param)
      
      if @user.save
        flash[:success]="Welcome to Alpha blog #{@user.username}"
        redirect_to articles_path
      else
        render 'new'
      end
      
  end   
  
  
  private
    def user_param
      params.require(:user).permit(:username,:email,:password)
    end  
  
end