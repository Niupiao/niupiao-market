class ItemsController < ApplicationController
    
    def new
        @item = Item.new
    end
    
    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to @item
        else
            render 'new'
        end
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
