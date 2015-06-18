class Receipt < ActiveRecord::Base
    belongs_to :seller, :class_name => "User"
    belongs_to :buyer, :class_name => "User"
    
    serialize :item_tags, Array
    
    validates :item_name, presence: true
    validates :item_quantity, presence: true, numericality: { greater_than: 0,
                                                              only_integer: true}
    validates :item_type, presence: true, inclusion: { in: VALID_ITEM_TYPES,
                                                       message: "%{value} is not a valid type" }
    validates :seller, presence: true
    validates :charge, numericality: { greater_than_or_equal_to: 0},
                       presence: true
end
