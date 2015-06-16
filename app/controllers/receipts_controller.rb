class ReceiptsController < ApplicationController
    def new
    end
    
    private
    def receipts_params
        params.require(:receipt).permit(:item_name, 
                                        :item_tags,
                                        :seller_name,
                                        :seller_id,
                                        :charge
                                        )
    end
end
