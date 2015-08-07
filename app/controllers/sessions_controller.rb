class SessionsController < ApplicationController
  before_action :valid_cart?, :only => [:remove_from_cart, :clear_cart, :show_cart]
  
  def new
  end

  def create
    #If the user is logging in through with an email and password, params with have a :session key
    if params[:session]
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to root_path
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    #If the :session key is not present, the user is logging in through Facebook
    else
      user = User.from_omniauth(request.env["omniauth.auth"], current_user)
      session[:user_id] = user.id
      redirect_to root_path
    end
  end
    
  def destroy
      log_out
      redirect_to root_path
  end
  
  def admin
    if params[:session]
      admin = SuperAdmin.find_by(username: params[:session][:username])
      if admin && admin.authenticate(params[:session][:password])
        session[:admin] = true
        redirect_to crunch_path
      else
        flash.now[:danger] = 'Wrong credentials.'
        redirect_to admin_path
      end
    end
  end
end