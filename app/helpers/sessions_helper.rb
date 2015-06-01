module SessionsHelper
    
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        session[:cart] = sto_h(user.cart) if user.cart
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def add_to_cart
        if session[:cart].nil? # If cart doesn't exist, instantiate the cart.
            session[:cart] = {}
        end
        
        item_id = params[:format]
        quantity_available = Item.find_by(id: item_id).quantity
        quantity_bought = 1 # Replace with a param in the future.
        if session[:cart].include?(item_id)
            if session[:cart][item_id] + quantity_bought <= quantity_available
                session[:cart][item_id] += quantity_bought
                redirect_to cart_path
            else
                flash[:danger] = "Can't check out more of this item."
                redirect_to root_path  # Hideously ugly temporary solution.
            end
        else
            if quantity_bought <= quantity_available
                session[:cart][item_id] = quantity_bought
                redirect_to cart_path
            else
                flash[:danger] = "Can't check out more of this item."
                redirect_to root_path  # Hideously ugly temporary solution.
            end
        end
    end
    
    def remove_from_cart
        session[:cart].delete(params[:format])
        redirect_to cart_path
    end
    
    def show_cart
    end
    
    def clear_cart
       session[:cart].clear
    end
    
    def log_out
        current_user.update_attribute(:cart, hto_s(session[:cart]))
        clear_cart
        session.delete(:user_id)
        @current_user = nil
    end
    
    private
        
    #converts hashs to string    
    def hto_s(hash)
        shash = ""
        hash.each do |id, quantity|
            shash += id + " " + quantity.to_s + ","
        end
        return shash
    end
    
    #reverse hto_s
    def sto_h(shash)
        hash = Hash[shash.split(",").map { 
            |str| [str.split[0],str.split[1].to_i]}]
        return hash
    end
        
end
