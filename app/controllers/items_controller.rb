class ItemsController < ApplicationController
    
    def new
        @item = Item.new
    end
    
    def create
        @item = Item.create(item_params)
        
    end
    
    def show
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name,
                                      :price,
                                      :tags
                                      )
    end
end
