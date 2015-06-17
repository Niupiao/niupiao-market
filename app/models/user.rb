class User < ActiveRecord::Base
    before_save{self.email = email.downcase}
    validates :first_name, presence: true
    validates :last_name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email, presence: true,
                format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
                
    validates :password, length: {minimum: 6}, presence: true
    
    has_secure_password
    has_many :items, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :receipts_sell, :class_name => 'Receipt', :foreign_key => 'seller_id'
    has_many :receipts_buy, :class_name => 'Receipt', :foreign_key => 'buyer_id'
    #has_one cart
end
