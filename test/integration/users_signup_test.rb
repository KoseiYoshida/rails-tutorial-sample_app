require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    # do以降(post)を実行後、"User.count"に変更がないか（no_differenceか）をテストしている
    assert_no_difference "User.count" do
      post signup_path, params: get_invalid_user
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
    assert_select "form[action=?]", signup_path
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: {user:{name:"Example User",
                                      email:"user@example.com",
                                      password:"password",
                                      password_confirmation:"password"
                                      }
                                }
    end
    # postを投げた後の結果を見て、指定されたリダイレクト先に飛ぶ
    follow_redirect!
    
    assert_template "users/show"
    assert_not flash.empty?
    assert is_logged_in?
  end
  
  private
  
    def get_invalid_user
      user = {user: {
                    name: "",
                    email: "user@invalid",
                    password: "foo",
                    password_confirmation: "bar"
                    }
              }
      return user
    end

    
end
