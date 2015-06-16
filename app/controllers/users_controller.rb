class UsersController < ApplicationController
  
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
  
  #  Creates a receipt for the User for the given item.
  def get_receipt(item, quantity_purchased, total_charge)
    if logged_in?
      current_user.receipts.create(
                                   item_name: item.name, 
                                   item_quantity: quantity_purchased,
                                   item_tags: item.tags,
                                   item_type: item.type,
                                   seller_name: item.user.first_name + " " + item.user.last_name,
                                   seller_id: item.user.id,
                                   charge: total_charge
                                   )
      
    else
      flash[:danger] = "You need to be logged in to purchase items"
      redirect_to login_path
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:first_name,:last_name,:email,:password,
                                    :password_confirmation,:address)
    end
    
end
