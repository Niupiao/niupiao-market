class ReceiptsController < ApplicationController
    def new
    end
    
    def receipts
        if (logged_in?)
            @receipts_bought = current_user.receipts_buy
            @receipts_sold = current_user.receipts_sell
        else
            flash[:danger] = "You must be logged in to view receipts"
            redirect_to login_path
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
                                        :charge
                                        )
    end
end
