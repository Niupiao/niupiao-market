class GymsAndPlaymat < ActiveRecord::Base
    has_one :item, as: :subitem
end
