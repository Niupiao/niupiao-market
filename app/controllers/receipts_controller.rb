class ReceiptsController < ApplicationController
    def new
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
