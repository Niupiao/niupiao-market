module SessionsHelper
    
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def add_to_cart
        if session[:cart].nil?
            session[:cart] = {}
        end
        if session[:cart].include?(params[:format])
            session[:cart][params[:format]]+=1
        else
            session[:cart][params[:format]] = 1
        end
        redirect_to cart_path
    end
    
    def remove_from_cart
        session[:cart].delete(params[:format])
        redirect_to cart_path
    end
    
    def show_cart
    end
    
    def clear_cart
        #TODO make sure no memory leaks
       session[:cart] = []
    end
end
