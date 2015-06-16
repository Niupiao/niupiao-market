require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @name = 'product'
    @item_type = VALID_ITEM_TYPES.first
    @price = 31.12
    @quantity = 2
    @desc = "great, amazing"
    @tags = ["just the best", "better than all the rest"]
  end
  
  test "product has owner, name, price, quantity, item_type, and description" do
    assert_not Item.create(name: @name).valid?
    assert_not Item.create(price: @price).valid?
    assert_not Item.create(desc: @desc).valid?
    assert Item.create(name: @name, price: @price, quantity: @quantity, 
                       desc: @desc, item_type: @item_type).valid?
  end
  
  test "product has nonnegative price, quantity is greater than 0" do
    assert_not(Item.create(name: @name, price: -1, quantity: @quantity, 
                           desc: @desc, item_type: @item_type).valid?,
               "Failure: Price can be negative")
    assert_not(Item.create(name: @name, price: @price, quantity: 0, desc: @desc,
                           item_type: @item_type).valid?,
               "Failure: Quantity can be 0")
    assert_not(Item.create(name: @name, price: @price, quantity: -1, desc: @desc,
                           item_type: @item_type).valid?,
               "Failure: Quantity can be negative")
  end

  test "product can have tags" do
    assert(Item.create(name: @name, price: @price, quantity: @quantity, 
                       item_type: @item_type, desc: @desc, tags: @tags).valid?, 
                       "Failure: Tags cannot be added")
  end
end
