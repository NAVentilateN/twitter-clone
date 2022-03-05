require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@email.com", username: "test", password: "testpassword")
  end

  test "user must have username, email and password" do
    assert @user.valid?
  end

  test "user cannot be created if it does not email" do
    @user.email = '   '
    assert_not @user.valid?
  end

  test "user cannot be created if it does not username" do
    @user.username = '   '
    assert_not @user.valid?
  end

  test "username cannot be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email cannot be too long" do
    @user.username = "#{'a' * 201}@email.com"
    assert_not @user.valid?
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "test@EMAIL.COM"
    @user.email = mixed_case_email
    @user.save
    # reload will check that the attribute is also persisted
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
