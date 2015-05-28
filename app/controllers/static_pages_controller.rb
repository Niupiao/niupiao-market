class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def items
    
    def index
      @items = Item.all
    end
    
  end
end
