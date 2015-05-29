require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "confirming home links" do 
    get root_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", cart_path
    assert_select "a[href=?]", checkout_path
  end
end
