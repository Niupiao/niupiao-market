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
           search_term = search_term.downcase.gsub(/\s+/m, ' ').strip.split(" ")
           Item.all.each do |item|
             search_space = item.name.downcase + " " + item.desc.downcase + " " +
                              item.user.first_name.downcase + " " + 
                              item.user.last_name.downcase
             score = 0
             target_score = (search_term.size / 2) + 1 # Score must be at least 1
             search_term.each do |word|
                 if(search_space.include? word)
                     score += 1
                 end
             end
             if(score >= target_score)
               @search += [item]
             end
           end
           return @search
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
      @review = @item.reviews.build(user_id: current_user.id, body: params[:review][:body], rating: params[:review][:rating])
      @review.save
      redirect_to @item
    end
    
    private
    
    def item_params
        params.require(:item).permit( :name,
                                      :price,
                                      :quantity,
                                      :desc,
                                      :item_type)
    end
end
