class ToolsAndBag < ActiveRecord::Base
  has_one :item, as: :subitem
end
