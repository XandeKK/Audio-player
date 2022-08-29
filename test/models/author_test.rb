require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  def setup
    @author = Author.new(
      user: users(:one),
      music: musics(:two)
    )
  end

  test "should be valid" do
    assert @author.valid?
  end

  test "should save" do
    assert_difference("Author.count") do
      assert @author.save
    end
  end

  test "should not valid without user" do
    @author.user = nil
    assert @author.invalid?
  end
  
  test "should not valid without music" do
    @author.music = nil
    assert @author.invalid?
  end

  test "should destroy" do
    assert_difference("Author.count", -1) do
      assert authors(:one).destroy
    end
  end
end
