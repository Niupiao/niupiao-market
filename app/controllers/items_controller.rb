class ItemsController < ApplicationController
    def new
        @item = Item.new
    end
    
    def create
        @item = current_user.items.new(item_params)
        if @item.save
            redirect_to @item
        else
            render 'new'
        end
    end
    
    def index
    end
    
    def show
        if Item.exists?(params[:id])
           @item = Item.find(params[:id])
        else
           redirect_to items_path
        end
    end
    
    private
    
    def item_params
        params.require(:item).permit( :name,
                                      :price,
                                      :quantity,
                                      :desc
                                      )
    end
end
