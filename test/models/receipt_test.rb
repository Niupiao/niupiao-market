require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  def setup
    @item_name = "test"
    @item_quantity = 1
    @item_type = VALID_ITEM_TYPES.first
    @seller_name = "foo"
    @seller_id = 1
    @charge = 2.0
  end
  
  test "valid receipt is valid" do
    receipt = Receipt.new(item_name: @item_name, item_quantity: @item_quantity,
                          item_type: @item_type, seller_name: @seller_name,
                          seller_id: @seller_id, charge: @charge)
                          
    assert receipt.valid?, "Valid receipt is not valid."
  end
end
