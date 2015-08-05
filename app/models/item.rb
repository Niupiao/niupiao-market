class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :subitem, :polymorphic => true
  
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :likers, foreign_key: "user_id", class_name: "User"
  has_many :comments, dependent: :destroy
  
  attr_accessor :VALID_ITEM_TYPES 
  serialize :tags, Array
    
  validates_presence_of :name
  validates :item_type, inclusion: { in: VALID_ITEM_TYPES,
                                     message: "%{value} is not a valid type" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
