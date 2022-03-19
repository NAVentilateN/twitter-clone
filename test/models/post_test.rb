require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(description: "a" * 140, user: users(:test_user))
  end

  test "Should not save if post is more than 140 character" do
    post = Post.new(description: "a" * 141)
    assert_not post.save
  end

  test "Should not save if post is less than or equal to 140 character but does not have a user" do
    post = Post.new(description: "a" * 140)
    assert_not post.save
  end

  test "Should save if post is less than or equal to 140 character and have a user" do
    post = Post.new(description: "a" * 140)
    post.user = users(:test_user)
    assert post.save
  end
end
