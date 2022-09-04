require "application_system_test_case"

class MusicsTest < ApplicationSystemTestCase
  def setup
    sign_in_system_test
    move_to_profile
  end

  test "can create music" do
    click_on "New Music"

    assert_text "New Song"

    fill_in "Title", with: "Opa"
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Create Music"

    assert_text "Opa"
  end

  test "can't create music without title" do
    click_on "New Music"

    assert_text "New Song"

    fill_in "Title", with: ""
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Create Music"

    assert_text "Title can't be blank"
  end

  test "can't create music without music" do
    click_on "New Music"

    assert_text "New Song"

    fill_in "Title", with: "Opa"
    # attach_file "Music", ""
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Create Music"

    assert_text "Music can't be blank"
  end

  test "can't create music without song" do
    click_on "New Music"

    assert_text "New Song"

    fill_in "Title", with: "Opa"
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    # attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Create Music"

    assert_text "Image cover can't be blank"
  end

  test "can't create music without nothing" do
    click_on "New Music"

    assert_text "New Song"

    # fill_in "Title", with: "Opa"
    # attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    # attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Create Music"

    assert_text "Title can't be blank"
    assert_text "Music can't be blank"
    assert_text "Image cover can't be blank"
  end

  test "can't create music without music and image cover invalid" do
    click_on "New Music"

    assert_text "New Song"

    fill_in "Title", with: "Opa"
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"

    click_on "Create Music"

    assert_text "Music has an invalid content type"
    assert_text "Image cover has an invalid content type"
  end

  test "can edit music" do
    click_on "Edit"

    assert_text "Edit Song"

    fill_in "Title", with: "Uepa!"
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Update Music"

    assert_text "Uepa!"
  end

  test "can't edit music without title" do
    click_on "Edit"

    assert_text "Edit Song"

    fill_in "Title", with: ""

    click_on "Update Music"

    assert_text "Title can't be blank"
  end

  test "can edit music without music and image" do
    click_on "Edit"

    assert_text "Edit Song"

    fill_in "Title", with: "Mano"
    # attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    # attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Update Music"

    assert_text "Mano"
  end

  test "can't edit music with music and image invalid" do
    click_on "Edit"

    assert_text "Edit Song"

    fill_in "Title", with: "Opa"
    attach_file "Image cover", "#{Rails.root}/test/fixtures/files/time-for-love.mp3"
    attach_file "Music", "#{Rails.root}/test/fixtures/files/time-for-love.jpg"

    click_on "Update Music"

    assert_text "Music has an invalid content type"
    assert_text "Image cover has an invalid content type"
  end

  test "can destroy music" do
    click_on "Destroy"

    assert_text users(:one).name
    assert_text users(:one).artistic_name
    assert_text "There are no songs"
  end
end
