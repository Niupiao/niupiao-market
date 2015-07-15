class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :subitem, :polymorphic => true
  
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :likers, foreign_key: "user_id", class_name: "User"
  
  attr_accessor :VALID_ITEM_TYPES 
  serialize :tags, Array
    
  validates_presence_of :name
  validates :item_type, inclusion: { in: VALID_ITEM_TYPES,
                                     message: "%{value} is not a valid type" }
  validates_presence_of :price
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :quantity
  validates :quantity, numericality: { greater_than: 0 }
end
