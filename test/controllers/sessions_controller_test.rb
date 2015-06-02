require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper
  
  def setup
    @user = User.new(first_name:"apoorva",last_name:"lal",
                      email:"foo@bar.com",password:"123456",
                      password_confirmation:"123456")
  end
  
  test "valid users able to log in" do
    @user.save
    log_in @user
    assert logged_in?
    assert current_user == @user
  end
  
  test "can't log in to a non-existing user" do
    log_in @user
    assert_not logged_in?, "User #{@user.first_name} #{@user.last_name} doesn't exist."
  end
  
end
