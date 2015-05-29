class Item < ActiveRecord::Base
    validates_presence_of :owner
    validates_uniqueness_of :owner
    validates_presence_of :name
    validates_presence_of :price
    validates_presence_of :quantity
end
