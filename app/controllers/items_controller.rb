class ItemsController < ApplicationController
    
  def new
    @item = Item.new
  end
    
  def create
    if current_user
      # Modify submitted tags to convert it to an array.
      modified_params = item_params
      tags = modified_params[:tags]
      tags = tags.split(/[\s,']/)
      tags.reject(&:empty?)
      modified_params[:tags] = tags
            
      @item = current_user.items.new(modified_params)
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
    scores = []
    search_term = params[:search_term]
    if search_term
      search_term = search_term.downcase.gsub(/\s+/m, ' ').strip.split(" ")
      Item.all.each do |item|
        search_space = item.name.downcase + " " + item.desc.downcase + " " +
                       item.user.first_name.downcase + " " + 
                       item.user.last_name.downcase + " " + item.tags.join(" ").downcase
        score = 0
        target_score = (search_term.size / 2.0).ceil # Score must be at least 1
        search_term.each do |word|
          if(search_space.include? word)
            score += (search_space.scan(/#{word}/).length)
          end
        end
        
        if(score >= target_score)
          @search += [item]
          scores += [score]
        end
      end
      
      p @search.sort_by.with_index{|_,i| scores[i]}
      @search.reverse!
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
    if Review.find_by(user_id: current_user.id, reviewable: @item)
      flash.now[:message] = 'You cannot post multiple reviews'
      redirect_to @item
    else
      @review = @item.reviews.create(user_id: current_user.id, body: params[:review][:body], rating: params[:review][:rating])
      redirect_to @item
    end
  end
    
  private
    
  def item_params
    params.require(:item).permit( :name,
                                  :price,
                                  :quantity,
                                  :desc,
                                  :item_type,
                                  :tags)
  end
end