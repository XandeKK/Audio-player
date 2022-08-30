require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_up_path
    assert_response :success
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
    end
  end
end
