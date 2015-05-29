class Item < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name
    validates_presence_of :price
    validates_presence_of :quantity
end
