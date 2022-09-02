require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should search" do
    sign_in

    post search_path(format: :turbo_stream), params: {
      q: "He"
    }
    assert_response :ok
    assert_select "h2", "He"
    authors.each do |author|
      assert_select "h5", author.music.title
      assert_select "p", author.user.artistic_name
    end
  end

  test "should raise UnknownFormat" do
    sign_in

    assert_raise ActionController::UnknownFormat do
      post search_path, params: {
        q: "Hero"
      } 
    end
  end
end
