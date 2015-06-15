class Item < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    
    validates_presence_of :name
    validates :type, inclusion: { in: %w(regular clothing ticketing),
    message: "%{value} is not a valid type" }
    validates_presence_of :price
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates_presence_of :quantity
    validates :quantity, numericality: { greater_than: 0 }
    
    
end
