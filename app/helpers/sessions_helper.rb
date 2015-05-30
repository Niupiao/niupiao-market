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
    
    #creates an empty cart
    def create_empty_cart
        session[:cart] = []
    end
    
    def add_to_cart
        session[:cart] << Item.find(params[:format])
    end
    
    def show_cart
        #session[:cart]
    end
    
    def clear_cart
        #TODO make sure no memory leaks
       session[:cart] = [] 
    end
end
