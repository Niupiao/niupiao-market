class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :correct_user,   only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)
   @user.cart = {}  # Sets user's cart to be non-nil.
    if @user.save
      flash[:success] = "Welcome to the NiuPiao Market!"
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
  
  def destroy
    if User.exists?(params[:id])
      User.delete(params[:id])
    end
    redirect_to root_path
  end

  def index
  end
  
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
  
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  private
    
    def user_params
      params.require(:user).permit(:first_name,:last_name,:email,:password,
                                    :password_confirmation,:address)
    end
    
end
