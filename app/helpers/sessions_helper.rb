module SessionsHelper 
  
  #Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    if user.cart && !user.cart.empty?
      session[:cart] = JSON.parse(user.cart)
    else
      session[:cart] = {}
    end
  end
    
  def logged_in?
    !current_user.nil?
  end
  
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # If cart is invalid, instantiate empty, valid cart.
  def valid_cart?
    if (session[:cart].nil?)
      session[:cart] = {} #Instantiate empty hash.
    end
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
  
  def purchase_cart_contents(user)
    if session[:cart]
      session[:cart].each do |item_id, quantity_bought|
        item = Item.find_by(id: item_id)
        
        # Generates receipt
        get_receipt(user, item.user, item, quantity_bought, quantity_bought * item.price)
        quantity_remaining = item.quantity - quantity_bought
        if quantity_remaining == 0
          item.destroy
        else
          item.update_attribute(:quantity, quantity_remaining)
        end
      end
      clear_cart
    end
  end
  
  # Goes through (at most) 20 most recent receipts and returns top 5 search tags
  # or however many are available.
  def recommended_search_tags(id)
    receipts = Receipt.where(buyer_id: id).order("created_at DESC").limit(20)
    search_tags = {}
    receipts.each do |receipt|
      receipt.item_tags.each do |tag|
        if search_tags.has_key?(tag)
          current_val = search_tags[tag]
          search_tags[tag] = current_val + 1
        else
          search_tags[tag] = 1
        end
      end
    end
    if search_tags.length >= 4
      return Hash[search_tags.sort_by { |k,v| v }.reverse![0..3]]
    else
      return Hash[search_tags.sort_by { |k, v| v }.reverse!]
    end
  end
  
  # Assigns search tags based on items passed in.
  def recommended_search_tags_from_items(item_ids)
    search_tags = {}
    item_ids.each do |id|
      item = Item.find_by(id: id)
      item.tags.each do |tag|
        if search_tags.has_key?(tag)
          current_val = search_tags[tag]
          search_tags[tag] = current_val + 1
        else
          search_tags[tag] = 1
        end
      end
    end
    if search_tags.length >= 4
      return Hash[search_tags.sort_by { |k,v| v }.reverse![0..3]]
    else
      return Hash[search_tags.sort_by { |k, v| v }.reverse!]
    end
  end
    
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
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
    updated_id = params[:id]
    quantity_diff = params[:quantity_updated].to_i - session[:cart][updated_id] 
    total_diff = Item.find(updated_id).price * quantity_diff
    params[:quantity_diff] = quantity_diff
    params[:total_diff] = total_diff
    session[:cart][updated_id] = params[:quantity_updated].to_i
    respond_to do |format|
        format.js
    end
  end
end
