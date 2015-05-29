require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name:"mo", last_name:"soussi",email:"foo@bar.com",
                password:"1234567", password_confirmation:"1234567")
  end

  test "should be valid" do 
    assert @user.valid?
  end
  
  test "first name and last name should be present" do
    @user.first_name = "  "
    @user.last_name = "  "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end
  
end
