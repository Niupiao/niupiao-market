class MobileController < ApplicationController
  require 'securerandom'
  include ::ActionController::Serialization
  
  def register
    first = params[:first_name]
    last = params[:last_name]
    email = params[:email]
    @user = User.new(first_name: first, last_name: last, email: email)
    password = params[:password]
    auth = params[:oauth_token]
    expires_at = params[:expires_at]
    facebook_id = params[:facebook_id]
    if password
      @user.password = password
    else
      @user.generate_password # Needed to bypass bcrypts requirements.
    end
    if auth
      @user.oauth_token = auth
    else
      @user.generate_auth_token
    end
    if expires_at
      @user.expires_at = expires_at
    else
      @user.generate_expiration_time
    end
    if facebook_id
      @user.facebook_id = facebook_id
    end
    @user.confirm_email  # remove when email confirmation feature is more fleshed out.
    if @user.save
      render :json => @user.to_json
    else
      error_message(@user.errors.full_messages)
    end
  end
  
  # Updates a user's first or last name.
  def update_user
    if authenticate
      first_name = params[:first_name]
      last_name = params[:last_name]
      
      if first_name
        @user.update_attribute(:first_name, first_name)
      end
      if last_name
        @user.update_attribute(:last_name, last_name)
      end
      success_message("Successful update.")
    else
      error_message(@message)
    end
  end
  
  def update_facebook_id
    if authenticate
      facebook_id = params[:new_facebook_id]
      @user.facebook_id = facebook_id
      @user.save!
      success_message("Successful update.")
    else
      error_message(@message)
    end
  end
  
  # Updates a user's phone number.
  def update_phone
    if authenticate
      phone = params[:phone]
      
      if phone
        if @user.update_attribute(:phone, phone)
          success_message("Successful update.")
        else
          error_message("User phone unable to be updated")
        end
      else
        error_message("No phone param found")
      end
    else
      error_message(@message)
    end
  end
  
  # Confirms a user's email. Ideally should also send out an email confirmation.
  def email_confirm
    if authenticate
      @user.confirm_email
      success_message(@user.email_confirmed?)
    else
      error_message(@message)
    end
  end
  
  # Returns whether or not a user's email is confirmed.
  def email_confirmed?
    if authenticate
      success_message(@user.email_confirmed?)
    else
      error_message(@message)
    end
  end
  
  # Logs a user in.
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
      error_message(@message)
    end
  end
  
  # Logs a user out. Right now, this serves to update the user's cart.
  def logout
    if authenticate
      @user.update_attribute(:cart, params[:cart])
    else
      error_message(@message)
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
      error_message(@message)
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
      error_message(@message)
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
  
  # Returns all reviews about a certain user, as well as the users who wrote those reviews.
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
  
  # Returns all receipts associated with a given user, without duplicates.
  def receipts
    if authenticate
      receipts = Receipt.where("buyer_id = ? OR seller_id = ?", @user.id, @user.id)
      render :json => receipts
    else
      error_message("Wrong account credentials")
    end
  end
  
  # Returns all receipts in which the user purchased an item.
  def purchase_receipts
    if authenticate
      render :json => @user.receipts_buy
    else
      error_message("Wrong account credentials")
    end
  end
  
  # Returns all receipts in which the user sold an item.
  def sale_receipts
    if authenticate
      render :json => @user.receipts_sell
    else
      error_message("Wrong account credentials")
    end
  end
  
  
  def sell
    if authenticate
      name = params[:name]
      tags = params[:tags]
      tags ||= ''
      price = params[:price]
      quantity = params[:quantity]
      desc = params[:desc]
      desc ||= ''
      subcategory = params[:subcategory]
      item = Item.create(name: name, tags: tags, price: price, quantity: quantity,
                      desc: desc)
      @user.items << item
      category = item.categorize(subcategory)
      item.supercategorize(category)
      if subcategory == "FaceMakeup"
        tmp = FaceMakeup.create(color: params[:color], size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "EyeMakeup"
        tmp = EyeMakeup.create(color: params[:color])
        tmp.item = item
      elsif subcategory == "Lips"
        tmp = Lip.create(color: params[:color])
        tmp.item = item
      elsif subcategory == "ToolsAndBags"
        tmp = ToolsAndBag.create()
        tmp.item = item
      elsif subcategory == "Cleanse"
        tmp = Cleanse.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "Moisturize"
        tmp = Moisturize.create(size: params[:size].to_i, color: params[:color])
        tmp.item = item
      elsif subcategory == "Treatments"
        tmp = Treatment.create(size: params[:size].to_i, count: params[:count])
        tmp.item = item
      elsif subcategory == "Women"
        tmp = Woman.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "Men"
        tmp = Man.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "LotionsAndCreams"
        tmp = LotionsAndCream.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "ShowerAndBath"
        tmp = ShowerAndBath.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "Suncare"
        tmp = Suncare.create(size: params[:size].to_i, color: params[:color])
        tmp.item = item
      elsif subcategory == "NailPolish"
        tmp = NailPolish.create(size: params[:size].to_i, color: params[:color])
        tmp.item = item
      elsif subcategory == "KitsSets"
        tmp = KitsSet.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "SpecialEffects"
        tmp = SpecialEffect.create(size: params[:size].to_i, count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "TreatmentsAndTools"
        tmp = TreatmentsAndTool.create()
        tmp.item = item
      elsif subcategory == "StylingProductsAndTools"
        tmp = StylingProductsAndTool.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "ShampooAndConditioner"
        tmp = ShampooAndConditioner.create(size: params[:size].to_i)
        tmp.item = item
      elsif subcategory == "BoysClothing"
        tmp = BoysClothing.create(size: params[:size].to_i, style: params[:style])
        tmp.item = item
      elsif subcategory == "GirlsClothing"
        tmp = GirlsClothing.create(size: params[:size].to_i, style: params[:style])
        tmp.item = item
      elsif subcategory == "Accessories"
        tmp = Accessory.create(style: params[:style], count: params[:count])
        tmp.item = item
      elsif subcategory == "UnderwearAndSocks"
        tmp = UnderwearAndSock.create(size: params[:size].to_i, count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "Beverages"
        tmp = Beverage.create(volume: params[:volume].to_i, count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "Food"
        tmp = Food.create(volume: params[:volume].to_i, count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "BabyFormula"
        tmp = BabyFormula.create(volume: params[:volume].to_i, count: params[:count].to_i, age: params[:age])
        tmp.item = item
      elsif subcategory == "FeedingAccessories"
        tmp = FeedingAccessory.create(count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "BoosterSeats"
        tmp = BoosterSeat.create()
        tmp.item = item
      elsif subcategory == "DiaperAccessories"
        tmp = DiaperAccessory.create(count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "Diapers"
        tmp = Diaper.create(size: params[:size].to_i, count: params[:count].to_i)
        tmp.item = item
      elsif subcategory == "LampAndNightLights"
        tmp = LampAndNightLight.create()
        tmp.item = item
      elsif subcategory == "BeddingSeparates"
        tmp = BeddingSeparate.create()
        tmp.item = item
      elsif subcategory == "BeddingSet"
        tmp = BeddingSet.create(pieces: params[:pieces].to_i)
        tmp.item = item
      elsif subcategory == "WallDecorations"
        tmp = WallDecoration.create(gender: params[:gender])
        tmp.item = item
      elsif subcategory == "BoosterCarSeats"
        tmp = BoosterCarSeat.create(child_weight: params[:child_weight].to_i)
        tmp.item = item
      elsif subcategory == "CarSeatAccessories"
        tmp = CarSeatAccessory.create()
        tmp.item = item
      elsif subcategory == "TravelSets"
        tmp = TravelSet.create()
        tmp.item = item
      elsif subcategory == "Strollers"
        tmp = Stroller.create(fits: params[:fits].to_i)
        tmp.item = item
      elsif subcategory == "BoosterFeedingSeats"
        tmp = BoosterFeedingSeat.create()
        tmp.item = item
      elsif subcategory == "PottySeatsAndStepStools"
        tmp = PottySeatsAndStepStool.create()
        tmp.item = item
      elsif subcategory == "Bikes"
        tmp = Bike.create()
        tmp.item = item
      elsif subcategory == "SleepingToys"
        tmp = SleepingToy.create()
        tmp.item = item
      elsif subcategory == "GymsAndPlaymats"
        tmp = GymsAndPlaymat.create()
        tmp.item = item
      elsif subcategory == "LearningToys"
        tmp = LearningToy.create(age: params[:age].to_i)
        tmp.item = item
      elsif subcategory == "Toys"
        tmp = Toy.create()
        tmp.item = item
      elsif subcategory == "Gates"
        tmp = Gate.create(age: params[:age].to_i, height: params[:height].to_i)
        tmp.item = item
      elsif subcategory == "BabyMonitors"
        tmp = BabyMonitor.create()
        tmp.item = item
      elsif subcategory == "BabyProofingItems"
        tmp = BabyProofingItem.create()
        tmp.item = item
      elsif subcategory == "GroomingHealthcareAndSkincareEssentials"
        tmp = GroomingHealthcareAndSkincareEssential.create()
        tmp.item = item
      end
      success_message(item.to_json)
    else
      error_message("Wrong account credentials")
    end
  end
  
  # Returns a list of items, including sub details.
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
  
  # Returns a specific item, including subitem.
  def item
    if @item = Item.find_by(id: params[:item])
      render :json => @item.to_json(:include => :subitem)
    else
      error_message("Item not found")
    end
  end
  
  # Returns some information of a specific user.
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
  
  # Renews the user's Oauth token. Accepts either the password, or the old oauth token,
  # regardless of whether or not the old oauth token is expired.
  def renew_token
    password = params[:password]
    old_oauth = params[:old_oauth]
    oauth_token = params[:oauth_token]
    expires_at = params[:expires_at]
    
    @user = User.find_by(email: params[:email].downcase)
    if @user
      if old_oauth == @user.oauth_token || @user.authenticate(password)
        if oauth_token
          @user.oauth_token = oauth_token
        else
          @user.generate_auth_token
        end
        
        if expires_at
          @user.expires_at = expires_at
        else
          @user.generate_expiration_time
        end
        success_message(@user)
      else
        error_message("Authentication credentials not correct.")
      end
    else
      error_message("No user found with that email.")
    end
  end
  
  
  private
  # Authenticates the user using email && (password || oauth token)
  def authenticate
    @user = User.find_by(email: params[:email].downcase)
    if params[:password]
      if @user && @user.authenticate(params[:password])
        return @user
      else
        @message = "Wrong account credentials!"
        return false
      end
    else
      authenticate_with_facebook_id
    end
  end
  
  #def authenticate_with_token
    #if @user && @user.oauth_token == params[:oauth_token]
      #if Time.parse(@user.oauth_expires_at) - Time.now >= 0  # Auth token still valid.
        #return @user
      #else
        #@message = "Auth token expired"
        #return false
      #end
    #else
      #@message = "Wrong account credentials!"
      #return false
    #end
  #end
  
  def authenticate_with_facebook_id
    if @user && @user.facebook_id == params[:facebook_id]
      return @user
    else
      @message = "Wrong account credentials!"
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
