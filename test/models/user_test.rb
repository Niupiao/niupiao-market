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
  
  test "email should have the right form" do
    invalid_addresses = %w[modsoussi modsou.@asdh modsoussi@bar..com haha@haha.]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid "
    end
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end
  
  test "password should be at least 6 chars long" do
    @user.password = @password_confirmation = "a"*5
    assert_not @user.valid?
  end
  
end
