require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_up_path
    assert_response :success
    assert_select "h2", "Sign up"
  end

  test "should sign up" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          name: "Alexandre",
          artistic_name: "Xande",
          email: "xande@gmail.com",
          password: "supremo"
        }
      }
      assert_response :redirect
      follow_redirect!
      # assert_select "h2", "Home"
    end
  end

  test "should sign up without artistic_name" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          name: "Alexandre",
          artistic_name: nil,
          email: "xande@gmail.com",
          password: "supremo"
        }
      }
      assert_response :redirect
      # assert_select "h2", "Home"
    end
  end

  test "should not sign up without name" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          name: nil,
          artistic_name: "xande",
          email: "xande@gmail.com",
          password: "supremo"
        }
      }
      assert_response :unprocessable_entity
      assert_select "h2", "Sign up"
    end
  end

  test "should not sign up without email" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          name: "Alexandre",
          artistic_name: "xande",
          email: nil,
          password: "supremo"
        }
      }
      assert_response :unprocessable_entity
      assert_select "h2", "Sign up"
    end
  end

  test "should not sign up without password" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          name: "Alexandre",
          artistic_name: "xande",
          email: "xande@gmail.com",
          password: nil
        }
      }
      assert_response :unprocessable_entity
      assert_select "h2", "Sign up"
    end
  end
end
