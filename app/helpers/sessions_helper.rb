module SessionsHelper
    
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        if user.cart && !user.cart.empty?
            session[:cart] = JSON.parse(user.cart) 
        end
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !!current_user
    end
    
    def add_to_cart
        if !session[:cart]
            session[:cart] = {}
        end
        item_id = params[:item_id]
        quantity_available = Item.find_by(id: item_id).quantity
        quantity_bought = params[:quantity].to_i
        quantity_in_cart = session[:cart][item_id].to_i
        
        if quantity_in_cart + quantity_bought <= quantity_available
            session[:cart][item_id] = quantity_bought + quantity_in_cart
            flash[:success] = "Successfully added item to cart!"            
        else
            flash[:danger] = "Can't check out more of this item."
        end
        redirect_to root_path
    end
    
    def remove_from_cart
        session[:cart].delete(params[:item_id])
        redirect_to cart_path
    end
    
    def show_cart
    end
    
    def clear_cart
       session[:cart].clear
    end
    
    def log_out
        current_user.update_attribute(:cart, session[:cart].to_json)
        clear_cart
        session.delete(:user_id)
        @current_user = nil
    end
    
    def update_cart
        debugger
        session[:cart][id] = params[:quantity_updated]
        respond_to do |format|
            format.js
        end
    end
end
