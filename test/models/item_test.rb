require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @name = 'product'
    @price = 31.12
    @tags = "great, amazing"
  end
  
  test "product has name, price, and tags" do
    assert_not Item.create(name: @name).valid?
    assert_not Item.create(price: @price).valid?
    assert_not Item.create(tags: @tags).valid?
    assert Item.create(name: @name, price: @price, tags: @tags).valid?
  end
end
