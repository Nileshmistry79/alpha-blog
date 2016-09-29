class UsersController < ApplicationController
  
  def new
      @user= User.new
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