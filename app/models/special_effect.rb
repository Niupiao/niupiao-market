class SpecialEffect < ActiveRecord::Base
  has_one :item, as: :subitem
end
