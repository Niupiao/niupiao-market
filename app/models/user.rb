class User < ActiveRecord::Base
  require 'securerandom'
  before_save{self.email = email.downcase}
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}, 
            uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, presence: true
  validates :uid, presence: true, if: :provider

  has_secure_password
  has_many :items, dependent: :destroy
  has_many :reviews, dependent: :destroy
    
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