class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to users_path
    end
  end

  def index
  end
  
  private
    
    def user_params
      params.require(:user).permit(:first_name,:last_name,:email,:password,
                                    :password_confirmation,:address)
    end
    
end
