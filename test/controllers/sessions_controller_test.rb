require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_in_path
    assert_response :success
  end

  test "should sign in" do
    post session_path, params: {
      session: {
        email: users(:one).email,
        password: "password"
      }
    }
    assert_response :redirect
  end

  test "should not sign in without email" do
    post session_path, params: {
      session: {
        email: nil,
        password: "password"
      }
    }
    assert_response :unauthorized
  end

  test "should not sign in without password" do
    post session_path, params: {
      session: {
        email: users(:one).email,
        password: nil
      }
    }
    assert_response :unauthorized
  end

  test "should sign out" do
    sign_in
    # follow_redirect! remove comment if have root_poth
    delete sign_out_path
    assert_response :see_other
    # follow_redirect!
    assert_redirected_to sign_in_path
  end
end
