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
    validates :status, presence: true, inclusion: { in: VALID_RECEIPT_STATUS,
                                                    message: "%{value} is not a valid status" }
    validates :charge, numericality: { greater_than_or_equal_to: 0},
                       presence: true
                       
    def to_delivery
        buyer = User.find_by(id: buyer_id)
        seller = User.find_by(id: seller_id)
       {id: id,
        item_name: item_name,
        item_quantity: item_quantity,
        seller_availability: seller_availability,
        buyer_availability: buyer_availability,
        claimed: claimed,
        status: status,
        created_at: created_at,
        delivery_instruction: delivery_instruction,
        charge: charge,
        buyer_address: buyer.address,
        seller_address: seller.address,
        buyer_phone: buyer.phone,
        seller_phone: seller.phone}
    end
end
