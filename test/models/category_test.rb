require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(
      name: "Rap"
    )
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "should save" do
    assert_difference("Category.count") do
      assert @category.save
    end
  end

  test "should not valid without name" do
    @category.name = nil
    assert @category.invalid?
  end

  test "should destroy" do
    assert_difference("Category.count", -1) do
      assert categories(:one).destroy
    end
  end
end
