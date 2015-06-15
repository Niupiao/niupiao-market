class Item < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates_presence_of :name
    validates_presence_of :price
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates_presence_of :quantity
    validates :quantity, numericality: { greater_than: 0 }
end
