class User < ActiveRecord::Base
    before_save{self.email = email.downcase}
    validates :first_name, presence: true
    validates :last_name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email, presence: true,
                format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
                
    validates :password, length: {minimum: 6}, presence: true, unless: :provider
    validates :uid, presence: true, if: :provider
    
    has_secure_password
    
    has_many :items, dependent: :destroy
    has_many :reviews, dependent: :destroy
    
    def self.from_omniauth(auth)
        if user = find_by(uid: auth.uid)
            user.provider = auth.provider
            user.uid = auth.uid
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.email = auth.info.email
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
            user
        else
           User.create(provider: auth.provider, 
                        uid: auth.uid, 
                        first_name: auth.info.first_name, 
                        last_name: auth.info.first_name, 
                        email: auth.info.email,
                        password: 'placeholder',
                        password_confirmation: 'placeholder',
                        oauth_token: auth.credentials.token,
                        oauth_expires_at: Time.at(auth.credentials.expires_at)) 
        end
    end
end