require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "visit the sign up and create a account" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Sign up"

    assert_text "Recents"
    assert_text "Random"
  end

  test "visit the sign up and don't create an account without name" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: ""
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Sign up"

    assert_text "Sign up"
    assert_selector "p", text: "Name can't be blank"
  end

  test "visit the sign up and don't create an account without email" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: ""
    fill_in "Password", with: "VamosBrincar"

    click_on "Sign up"

    assert_text "Sign up"
  end

  test "visit the sign up and don't create an account with email invalid" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Sign up"

    assert_text "Sign up"
  end

  test "visit the sign up and don't create an account without password" do
    visit sign_up_url
  
    assert_text "Sign up"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: ""

    click_on "Sign up"

    assert_text "Sign up"
    assert_selector "p", text: "Password can't be blank"
  end
end
