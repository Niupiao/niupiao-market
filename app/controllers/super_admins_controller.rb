class SuperAdminsController < ApplicationController
  
  # There are few things that make me this nervous. Session is not secure, and
  # how will this stress the server? Future replacement, can you do this better?
  # DOC: Allows database-wide searches and filters for active monitoring.
  def crunch
    # If superadmin is logged in. Then define items. Need to also pass in the kind
    # of query that's passed in.
    if session[:admin]  # Future replacement, while using session already needs to be replaced, consider also setting up an expiration timer.
      if params[:type] == "not picked up"
        @results = Receipt.where(status: "Unclaimed")
      
      elsif params[:type] == "transaction"
        if params[:filter] && params[:filter] != ""
          h = params[:filter].to_i
          @results = Receipt.where(["status != '%s' and updated_at <= '%s'", "Complete", Time.now - h.hours])
        else
          @results = Receipt.all
        end
        
      elsif params[:type] == "drivers"
        if params[:filter] && params[:filter] != ""
          id = params[:filter].to_i
          @results = Driver.where(id: id)
        else
          @results = Driver.all
        end
        
      elsif params[:type] == "delivery"
        if params[:filter] && params[:filter] != ""
          id = params[:filter].to_i
          @results = Receipt.where(id: id)
        else
          @results = Receipt.where.not(status: "Complete")
        end
        
      elsif params[:type] == "users"
        if params[:filter] && params[:filter] != ""
          filter = params[:filter]
          @results = User.where(email: filter)
          if @results.count == 0
            @results = User.where("first_name || ' ' || last_name LIKE ?", "%#{filter}%")
          end
        else
          @results = User.all
        end
        
      elsif params[:type] == "user transaction"
        if params[:filter] && params[:filter] != ""
          email = params[:filter]
          user = User.find_by(email: email)
          @results = Receipt.where("buyer_id = ? OR seller_id = ?", user.id, user.id)
        else
          @results = []
        end
        
      elsif params[:type].nil?
        # Handle the case where there's no type params.
      
      # The failsafe. Someone tries to manually mess with the type params and,
      # for whatever reason, makes a spelling mistake. This is an /extremely/
      # weak failsafe. (If they're already logged in, why would they even bother
      # with personally messing with the url?) Still, it leaves me slightly more
      # at ease knowing _something_ is in place.
      else 
        session[:admin] = false
        redirect_to admin_path
      end
    else
      redirect_to admin_path
    end
  end

  def pay_driver
    if session[:admin]
      driver = Driver.find_by(params[:driver])
      if driver && params[:amount]
        UrtuMailer.send_driver_invoice(driver, params[:amount])
        puts "success"
      end
    end
    redirect_to crunch_path
  end

  def update_driver
    if session[:admin]
      driver = Driver.find_by(params[:driver])
      if driver
        driver.update(key: params[:key]) if params[:key]
        driver.udpate(name: params[:name]) if params[:name]
        driver.update(phone: params[:phone]) if params[:phone]
        driver.update(license: params[:license]) if params[:license]
        driver.update(bank_info: params[:bank_info]) if params[:bank_info]
        driver.update(amount_owed: params[:amount_owed]) if params[:amount_owed]
      end
      redirect_to crunch_path
    end
    redirect_to admin_path
  end
  
  def update_receipt
    if session[:admin]
      @receipt = Receipt.find_by(id: params[:receipt])
      if @receipt
        @receipt.update(item_name: params[:item_name]) if params[:item_name]
        @receipt.update(item_quantity: params[:item_quantity]) if params[:item_quantity]
        @receipt.update(charge: params[:charge]) if params[:charge]
        @receipt.update(status: params[:status]) if params[:status]
      end
      redirect_to crunch_path
    else
      redirect_to admin_path
    end
  end
  
  def search_items
    @search = []
    scores = []
    search_term = params[:search_term]
    if search_term
      search_term = search_term.downcase.gsub(/\s+/m, ' ').strip.split(" ")
      Item.all.each do |item|
        search_space = item.name.downcase + " " + item.desc.downcase + " " +
                       item.user.first_name.downcase + " " + 
                       item.user.last_name.downcase + " " + item.tags.join(" ").downcase
        score = 0
        target_score = (search_term.size / 2.0).ceil # Score must be at least 1
        search_term.each do |word|
          if(search_space.include? word)
            score += (search_space.scan(/#{word}/).length)
          end
        end
        
        if(score >= target_score)
          @search += [item]
          scores += [score]
        end
      end
      
      @search.sort_by.with_index{|_,i| scores[i]}
      @search.reverse!
      return @search
    end
  end
end
