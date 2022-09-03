require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in
    @user = users(:one)
  end
  test "should get show" do
    get profile_path(@user)
    assert_response :success

    assert_select "h1", @user.name
    assert_select "h2", @user.artistic_name
    assert_select "h5", authors(:one).music.title
    assert_select "p", authors(:one).user.artistic_name
  end

  test "should get edit" do
    get edit_profile_path(@user)
    assert_response :success

    assert_select "h2", "Edit profile"
    assert_select "#user_name[value=?]", @user.name
    assert_select "#user_artistic_name[value=?]", @user.artistic_name
    assert_select "#user_email[value=?]", @user.email
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
    follow_redirect!

    assert_select "h1", "Ano"
    assert_select "h2", "Hana"
    assert_select "h5", authors(:one).music.title
    assert_select "p", authors(:one).user.artistic_name
  end

  test "should not udpate without name" do
    put profile_path(@user), params: {
      user: {
        name: "",
        artistic_name: "Hana",
        email: "anohana@crying.com",
        password: "secret_base"
      }
    }
    assert_response :unprocessable_entity

    assert_select "h2", "Edit profile"
    assert_select "#user_name[value=?]", ""
    assert_select "#user_artistic_name[value=?]", "Hana"
    assert_select "#user_email[value=?]", "anohana@crying.com"
  end

  test "should not udpate without email" do
    put profile_path(@user), params: {
      user: {
        name: "Ano",
        artistic_name: "Hana",
        email: "",
        password: "secret_base"
      }
    }
    assert_response :unprocessable_entity

    assert_select "h2", "Edit profile"
    assert_select "#user_name[value=?]", "Ano"
    assert_select "#user_artistic_name[value=?]", "Hana"
    assert_select "#user_email[value=?]", ""
  end

  test "should not udpate without password" do
    put profile_path(@user), params: {
      user: {
        name: "Ano",
        artistic_name: "Hana",
        email: "anohana@crying.com",
        password: ""
      }
    }
    assert_response :unprocessable_entity

    assert_select "h2", "Edit profile"
    assert_select "#user_name[value=?]", "Ano"
    assert_select "#user_artistic_name[value=?]", "Hana"
    assert_select "#user_email[value=?]", "anohana@crying.com"
  end

  test "should destroy" do
    assert_difference("User.count", -1) do
      delete delete_profile_path
      assert_response :redirect
      assert_redirected_to sign_up_path
    end
  end
end
