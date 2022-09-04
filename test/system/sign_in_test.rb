require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  test "visit the sign in and should sign in" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    assert_text "Recents"
    assert_text "Random"
  end

  test "visit the sign in and should not sign in without email" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: ""
    fill_in "Password", with: "password"

    click_on "Sign in"

    assert_text "Sign in"
  end

  test "visit the sign in and should not sign in without password" do
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: ""

    click_on "Sign in"

    assert_text "Sign in"
  end
end
