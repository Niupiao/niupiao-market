class User < ActiveRecord::Base
  require 'securerandom'
  before_save{self.email = email.downcase}
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}, 
            uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, presence: true, unless: :password_digest
  validates :uid, presence: true, if: :provider

  has_secure_password
  has_many :items, dependent: :destroy
  has_many :my_reviews, foreign_key: "user_id", class_name: "Review", dependent: :destroy
  has_many :receipts_sell, :class_name => 'Receipt', :foreign_key => 'seller_id'
  has_many :receipts_buy, :class_name => 'Receipt', :foreign_key => 'buyer_id'
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :likes, foreign_key: "id", class_name: "Item" # This needs to be redone.
  has_many :comments, dependent: :destroy
  has_one  :address, dependent: :destroy

    def self.from_omniauth(auth, user)
        if user
            user.provider = auth.provider
            user.uid = auth.uid
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save
            return user
        elsif user = find_by(uid: auth.uid)
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save
            return user
        else
            random_password = SecureRandom.urlsafe_base64(32, true)
            User.create(provider: auth.provider, 
                        uid: auth.uid, 
                        first_name: auth.info.first_name, 
                        last_name: auth.info.last_name, 
                        email: auth.info.email,
                        password: random_password,
                        password_confirmation: random_password,
                        oauth_token: auth.credentials.token,
                        oauth_expires_at: Time.at(auth.credentials.expires_at)) 
        end
    end
end
