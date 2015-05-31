class SessionsController < ApplicationController
    def new
        create_empty_cart
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            create_empty_cart
            redirect_to '/items/new'
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end
    
    def destroy
    end
end
