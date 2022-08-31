require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should search" do
    post search_path(format: :turbo_stream), params: {
      q: "Hero"
    }
    assert_response :ok
  end

  test "should raise UnknownFormat" do
    assert_raise ActionController::UnknownFormat do
      post search_path, params: {
        q: "Hero"
      } 
    end
  end
end
