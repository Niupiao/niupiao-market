class ItemsController < ApplicationController
    def new
        @item = Item.new
    end
    
    def create
        if current_user
            @item = current_user.items.new(item_params)
            if @item.save
                redirect_to @item
            else
                render 'new'
            end
        else
            flash[:danger] = "You need to be logged in"
            redirect_to login_path
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
    
    def search
        @search = []
       search_term = params[:search_term]
       if search_term
           Item.where(name: search_term).find_each do |item|
             @search += [item]
            end
       end
    end
    
    def destroy
        if Item.exists?(params[:id])
            Item.delete(params[:id])
        end
        redirect_to current_user
    end
    
    def review
      @item = Item.find(params[:item_id])
      @review = @item.reviews.build(user_id: current_user.id, body: params[:comment][:body], rating: params[:comment][:rating])
      @review.save
      redirect_to @item
    end
    
    private
    
    def item_params
        params.require(:item).permit( :name,
                                      :price,
                                      :quantity,
                                      :desc,
                                      :category_id,
                                      :category
                                      )
    end
end
