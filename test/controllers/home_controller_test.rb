require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    sign_in

    get root_path
    assert_response :success
    assert_select "h2", "Recents"
    assert_select "h2", "Random"
    authors.each do |author|
      assert_select "h5", author.music.title
      assert_select "p", author.user.artistic_name
    end
  end
end
