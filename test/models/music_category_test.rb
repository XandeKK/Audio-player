require "test_helper"

class MusicCategoryTest < ActiveSupport::TestCase
  def setup
    @music_category = MusicCategory.new(
      category: categories(:one),
      music: musics(:two)
    )
  end

  test "should be valid" do
    assert @music_category.valid?
  end

  test "should save" do
    assert_difference("MusicCategory.count") do
      assert @music_category.save
    end
  end

  test "should not valid without category" do
    @music_category.category = nil
    assert @music_category.invalid?
  end
  
  test "should not valid without music" do
    @music_category.music = nil
    assert @music_category.invalid?
  end

  test "should destroy" do
    assert_difference("MusicCategory.count", -1) do
      assert music_categories(:one).destroy
    end
  end
end
