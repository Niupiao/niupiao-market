class Address < ActiveRecord::Base
  
  # Downcase all attributes for consistency.
  before_save { 
    self.city = city.downcase
    self.district = district.downcase
    self.committee = committee.downcase
    self.street = street.downcase
    self.door = door.downcase
  }
  
  validates :city, presence: true
  validates :street, presence: true
end
