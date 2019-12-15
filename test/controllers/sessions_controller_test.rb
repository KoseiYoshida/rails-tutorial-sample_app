require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "should get new" do
    get login_path
    assert_response :success
  end
  
  test "should not redirect forwarding_url again" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_nil session[:forwarding_url]
  end
end
