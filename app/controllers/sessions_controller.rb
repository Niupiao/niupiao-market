class SessionsController < ApplicationController
    
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to items_path
        else
            render 'new'
            flash.keep[:notice] = 'Invalid email/password combination'
        end
    end
    
    def destroy
    end
end
