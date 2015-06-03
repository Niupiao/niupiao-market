require 'test_helper'

class UserItemFlowTest < ActionDispatch::IntegrationTest
  include SessionsHelper
  
  def setup
    @user = User.new(first_name:"apoorva",last_name:"lal",
                      email:"foo@bar.com",password:"123456",
                      password_confirmation:"123456")
                      
    @item = Item.new(name:"shoe", price:10, quantity: 10)
  end
  
  test "user unable to sign up using invalid email and password" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email:"user@invalid", password:"foo", password_confirmation:"bar"}
    end
    assert_template 'users/new'
  end
  
  test "user able to sign up using valid email and password" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {first_name:"foo", last_name:"bar",email:"foo@bar.com",
                        password:"foobar", password_confirmation:"foobar"}
    end
    assert_template root_path
  end
  
  
end
