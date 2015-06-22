class Deliveryman < ActiveRecord::Base
  
  validates :name, presence: true
  validates :phone, presence: true
  validates :bank_info, presence: true
  
end
