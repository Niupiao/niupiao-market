class MobileController < ApplicationController
  
  def login
    if authenticate
      render :json => {first_name: @user.first_name, 
                      last_name: @user.last_name, 
                      name: "#{@user.first_name} #{@user.last_name}",
                      cart: @user.cart,
                      address: @user.address,
                      phone: @user.phone,
                      likes: @user.likes
      }
    else
      render :json => {error: "Invalid credentials"}
    end
  end
  
  def logout
    if authenticate
      @user.update_attribute(:cart, params[:cart])
    else
      render :json => {error: "Invalid credentials"}
    end
  end
  
  def self_reviews
    if authenticate
      reviews = @user.reviews
      
      render :json => reviews
    end
  end
  
  def update_address
    if authenticate
      city = params[:city]
      district = params[:district]
      committee = params[:committee]
      street = params[:street]
      door = params[:door]
      if @user.address
        @user.address.attributes = {
                                    city: city, district: district,
                                    committee: committee, street: street,
                                    door: door
                                    }
        render :json => {success: "Address updated"}
      else
        @user.address = Address.create!(
                                        city: city, district: district,
                                        committee: committee, street: street,
                                        door: door
                                        )
        render :json => {success: "Address created"}
      end
    end
  end
  
  def items
    params[:page_size] = 50
    params[:page] ||= '1'
    params[:order] ||= 'id'
    params[:direction] ||= 'DESC'
    @items = Item.limit(params[:page_size].to_i)
       .offset(params[:page_size].to_i * (params[:page].to_i - 1))
       .order("#{params[:order]} #{params[:direction]}")
       .all.each
    render :json => @items.to_json(:include => :subitem)
  end
  
  def item
    if @item = Item.find_by(id: params[:item])
      render :json => @item.to_json(:include => :subitem)
    else
      render :json => {error: "Item not found"}
    end
  end
  
  def user
    if @user = User.find_by(id: params[:user])
      render :json => {first_name: @user.first_name, 
                      last_name: @user.last_name, 
                      name: "#{@user.first_name} #{@user.last_name}"}
    else
      render :json => {error: "User not found"}
    end
  end
  
  def purchase
    if authenticate
      params[:items].each do |item_id, quantity_bought|
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
  
  private
  def authenticate
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      return @user
    else
      return false
    end
  end
end
