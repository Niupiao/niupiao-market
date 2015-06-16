class Receipt < ActiveRecord::Base
    belongs_to :user
    
    serialize :item_tags, Array
    
    validates :item_name, presence: true
    validates :item_type, presence: true, inclusion: { in: VALID_ITEM_TYPES,
                                                       message: "%{value} is not a valid type" }
    validates :seller_name, presence: true
    validates :seller_id, presence: true, numericality: { greater_than_or_equal_to: 0,
                                                          only_integer: true}
    validates :charge, numericality: { greater_than_or_equal_to: 0},
                       presence: true
end
