class SessionsController < ApplicationController
    
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = session[:user_id]
            redirect_to '/items/new'
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end
    
    def destroy
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
end
