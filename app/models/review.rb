class Review < ActiveRecord::Base
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  
  validates :rating, presence: true, inclusion: 0..5
end
