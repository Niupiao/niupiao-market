class Driver < ActiveRecord::Base
  
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :bank_info, presence: true
  
  has_many :deliveries, class_name: 'Receipt', foreign_key: 'claimed'
  
end
