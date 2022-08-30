require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Alexandre",
      artistic_name: "Xande",
      email: "xande@gmail.com",
      password: "123"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should save" do
    assert_difference("User.count") do
      assert @user.save
    end
  end

  test "should not valid without name" do
    @user.name = nil
    assert @user.invalid?
  end

  test "should valid without artistic name" do
    @user.artistic_name = nil
    assert @user.valid?
  end

  test "should not valid without email" do
    @user.email = nil
    assert @user.invalid?
  end

  test "should not valid without password" do
    @user.password = nil
    assert @user.invalid?
  end

  test "should update" do
    @user.save

    assert @user.update(name: "Tauro")

    assert_equal "Tauro", @user.name
  end

  test "should destroy" do
    @user.save

    assert_difference("User.count", -1) do
      assert @user.destroy
    end
  end
  
end
