class ReceiptsController < ApplicationController
    
    def new
    end
    
    def receipts
        user = User.find_by(id: params[:user_id])
        if (logged_in? && current_user?(user))
            @receipts_bought = current_user.receipts_buy
            @receipts_sold = current_user.receipts_sell
        else
            flash[:danger] = "You must be logged in to view receipts"
            redirect_to login_path
        end
    end
    
    def tracker
    end
    
    def track
        code = params[:checkin_id]
        if code
          @receipt = Receipt.find_by(checkin_code: code)
          @receipt
        end
    end
    
    private
    def receipts_params
        params.require(:receipt).permit(
                                        :user_id,
                                        :item_name,
                                        :item_quantity,
                                        :item_tags,
                                        :item_type,
                                        :seller_name,
                                        :seller_id,
                                        :status,
                                        :seller_availability,
                                        :buyer_availability,
                                        :delivery_instruction,
                                        :claimed,
                                        :checkin_code,
                                        :charge
                                        )
    end
end
