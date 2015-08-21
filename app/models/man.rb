class Man < ActiveRecord::Base
  has_one :item, as: :subitem
end
