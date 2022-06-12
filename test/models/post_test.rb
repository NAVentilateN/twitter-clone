require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:most_recent)
  end

  test "post is valid if it have a user and description is within 140 characters" do
    assert @post.valid?
  end

  test "post is invalid if it have does not have a user" do
    @post.user = nil
    assert_not @post.valid?
  end

  test "Should not save if post is more than 140 character" do
    post = Post.new(description: "a" * 141)
    assert_not post.save
  end

  test "order should be that the most recent should be first" do
    assert_equal posts(:most_recent), Post.first
  end
end
