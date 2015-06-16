class SessionsController < ApplicationController
    def new
    end

    def create
      if params[:session]
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to root_path
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      else
          user = User.from_omniauth(request.env["omniauth.auth"])
          session[:user_id] = user.id
          redirect_to root_path
      end
    end
    
    def destroy
        log_out
        redirect_to root_path
    end
end
