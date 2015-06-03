require 'test_helper'

class UsersControllerTest < ActionController::TestCase 
  
  def setup
    @user = User.new(first_name:"apoorva",last_name:"lal",
                      email:"foo@bar.com",password:"123456",
                      password_confirmation:"123456")
  end
  
end
