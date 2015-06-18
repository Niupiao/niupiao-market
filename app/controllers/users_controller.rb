class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:success] = "Information updated"
    end
    render 'edit'
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
  
  def storefront
    @user = User.find(params[:id])
    @items = @user.items
  end
  
  private
    
  def user_params
    params.require(:user).permit(:first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :address,
                                  :uid,
                                  :provider,
                                  :oauth_token,
                                  :oauth_expires_at)
  end
end
