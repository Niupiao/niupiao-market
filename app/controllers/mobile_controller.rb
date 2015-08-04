class MobileController < ApplicationController
  include ::ActionController::Serialization
  
  
  def register
    first = params[:first_name]
    last = params[:last_name]
    email = params[:email]
    password = params[:password]
    @user = User.new(first_name: first, last_name: last, email: email, password: password)
    if @user.save
      render :json => @user.to_json
    else
      error_message(@user.errors.full_messages)
    end
  end
  
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
      error_message("Wrong account credentials")
    end
  end
  
  def logout
    if authenticate
      @user.update_attribute(:cart, params[:cart])
    else
      error_message("Wrong account credentials")
    end
  end
  
  def add_payment_method
    if authenticate
      payment_type = params[:payment_type].downcase
      if payment_type == "cash"
        @user.payment_methods.create!(payment_type: payment_type)
        success_message("Success")
      elsif payment_type == "wire"
        @user.payment_methods.create!(payment_type: payment_type, bank_account: params[:bank_account])
        success_message("Success")
      elsif payment_type == "deposit"
        @user.payment_methods.create!(payment_type: payment_type, bank_account: params[:bank_account])
        success_message("Success")
      elsif payment_type == "card"
        card_number = params[:card_number]
        cvv = params[:cvv]
        holder = params[:holder]
        exp_month = params[:exp_month]
        exp_year = params[:exp_year]
        email = params[:email]
        @user.payment_methods.create!(payment_type: payment_type, card_number: card_number, cvv: cvv,
                                      holder: holder, exp_month: exp_month,
                                      exp_year: exp_year, email: email)
        success_message("Success")
      end
    else
      error_message("Wrong account credentials")
    end
  end
  
  def remove_payment_method
    if authenticate
      pm = PaymentMethod.find_by(id: params[:id])
      if pm.user_id == @user.id
        pm.destroy
        success_message("Success")
      else
        error_message("Error, payment method does not belong to user")
      end
    else
      error_message("Wrong account credentials")
    end
  end
  
  def update_payment_method
    if authenticate
      pm = PaymentMethod.find_by(id: params[:id])
      pm.update_attribute(params[:paymentmethod])
      render :json => {success: "Success"}
    else
      error_message("Wrong account credentials")
    end
  end
  
  def get_payment_methods
    if authenticate
      render :json => @user.payment_methods
    else
      error_message("Wrong account credentials")
    end
  end
  
  def self_reviews
    if authenticate
      reviews = @user.reviews
      
      render :json => reviews
    else
      error_message("Wrong account credentials")
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
        success_message("Address updated")
      else
        @user.address = Address.create!(
                                        city: city, district: district,
                                        committee: committee, street: street,
                                        door: door
                                        )
        success_message("Address created")
      end
    end
  end
  
  def receipts
    if authenticate
      receipts = Receipt.where("buyer_id = ? OR seller_id = ?", @user.id, @user.id)
      render :json => receipts
    else
      error_message("Wrong account credentials")
    end
  end
  
  def purchase_receipts
    if authenticate
      render :json => @user.receipts_buy
    else
      error_message("Wrong account credentials")
    end
  end
  
  def sale_receipts
    if authenticate
      render :json => @user.receipts_sell
    else
      error_message("Wrong account credentials")
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
      error_message("Item not found")
    end
  end
  
  def user
    if @user = User.find_by(id: params[:user])
      render :json => {first_name: @user.first_name, 
                      last_name: @user.last_name, 
                      name: "#{@user.first_name} #{@user.last_name}"}
    else
      error_message("User not found")
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
  
  def success_message(msg)
    render :json => {success: msg}
  end
  
  def error_message(msg)
    render :json => {error: msg}
  end
end
