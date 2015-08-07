class SuperAdminsController < ApplicationController
  
  # There are few things that make me this nervous. Session is not secure, and
  # how will this stress the server? Future replacement, can you do this better?
  # DOC: Allows database-wide searches and filters for active monitoring.
  def crunch
    # If superadmin is logged in. Then define items. Need to also pass in the kind
    # of query that's passed in.
    if session[:admin]  # Future replacement, while using session already needs to be replaced, consider also setting up an expiration timer.
      if params[:type] == "not picked up"
        @results = Receipt.where(status: "Order Sent")
      
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
          email = params[:filter]
          @results = User.where(email: email)
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
      
      end
    else
      redirect_to admin_path
    end
    # Issue. need to structure the results table based on query type. Lots of partials.
    # Pass in the type of query. 
  end
  
  
end
