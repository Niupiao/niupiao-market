class SleepingToy < ActiveRecord::Base
    has_one :item, as: :subitem
end
