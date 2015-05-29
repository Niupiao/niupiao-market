require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @owner = 1
    @name = 'product'
    @price = 31.12
    @quantity = 2
    @desc = "great, amazing"
  end
  
  test "product has owner, name, price, quantity, and description" do
    assert_not Item.create(owner: @owner).valid?
    assert_not Item.create(name: @name).valid?
    assert_not Item.create(price: @price).valid?
    assert_not Item.create(desc: @desc).valid?
    assert Item.create(owner: @owner, name: @name, price: @price, quantity: @quantity, desc: @desc).valid?
  end

end
