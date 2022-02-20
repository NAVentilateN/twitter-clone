require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "visiting the post index" do
    visit posts_url
    assert_selector "h1", text: "Post"
  end

  test "Ensure all post are being displayed" do
    visit posts_url

    assert_selector ".postlist"
    assert_selector ".post", count: Post.count
  end

  test "lets a signed in user see all post" do
    visit "/"
    # save_and_open_screenshot
    login_as users(:test_user)
    visit "/posts"
    # save_and_open_screenshot
    assert_selector "h1", text: "Post"
    assert_selector ".post", count: Post.count
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
