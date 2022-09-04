require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  def setup
    sign_in_system_test
    move_to_profile
  end
  
  test "can edit profile" do
    click_on "Edit profile"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Update User"

    assert_text "Alexandre"
    assert_text "Xandekk"
    assert_text musics(:one).title
  end

  test "can't edit profile without name" do
    click_on "Edit profile"

    fill_in "Name", with: ""
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Update User"

    assert_selector "p", text: "Name can't be blank"
  end

  test "can edit profile without artistic name" do
    click_on "Edit profile"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: ""
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: "VamosBrincar"

    click_on "Update User"

    assert_text "Alexandre"
    assert_text musics(:one).title
  end

  test "can't edit profile without email" do
    click_on "Edit profile"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: ""
    fill_in "Password", with: "VamosBrincar"

    click_on "Update User"

    assert_selector "p", text: "Email can't be blank"
  end

  test "can't edit profile without password" do
    click_on "Edit profile"

    fill_in "Name", with: "Alexandre"
    fill_in "Artistic name", with: "Xandekk"
    fill_in "Email", with: "examples@gmail.com"
    fill_in "Password", with: ""

    click_on "Update User"

    assert_selector "p", text: "Password can't be blank"
  end

  test "can destroy" do
    find('#user-menu-button > div').click
    click_on "Destroy profile"

    assert_text "Sign up"
  end
end
