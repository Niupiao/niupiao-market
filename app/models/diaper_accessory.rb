class DiaperAccessory < ActiveRecord::Base
    has_one :item, as: :subitem
end
