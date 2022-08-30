require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in
    @user = users(:one)
  end
  test "should get show" do
    get profile_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_path(@user)
    assert_response :success
  end

  test "should udpate" do
    put profile_path(@user), params: {
      user: {
        name: "Ano",
        artistic_name: "Hana",
        email: "anohana@crying.com",
        password: "secret_base"
      }
    }
    assert_response :redirect
  end

  test "should udpate without name" do
    put profile_path(@user), params: {
      user: {
        name: nil,
        artistic_name: "Hana",
        email: "anohana@crying.com",
        password: "secret_base"
      }
    }
    assert_response :redirect
  end

  test "should udpate without email" do
    put profile_path(@user), params: {
      user: {
        name: "Ano",
        artistic_name: "Hana",
        email: nil,
        password: "secret_base"
      }
    }
    assert_response :redirect
  end

  test "should udpate without password" do
    put profile_path(@user), params: {
      user: {
        name: "Ano",
        artistic_name: "Hana",
        email: "anohana@crying.com",
        password: nil
      }
    }
    assert_response :redirect
  end

  test "should destroy" do
    assert_difference("User.count", -1) do
      delete delete_profile_path
      assert_response :redirect
      assert_redirected_to sign_up_path
    end
  end
end
