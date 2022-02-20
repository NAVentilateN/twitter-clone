require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "visiting the post index" do
    visit posts_url
    assert_selector "h1", text: "Post"
  end

  test "Ensure all post are being displayed" do
    visit posts_url
    assert_selector ".postlist"
    assert_selector "h2", count: Post.count
  end

  test "lets a signed in user see all post" do
    login_as users(:test_user)
    visit "/posts"
    assert_selector "h1", text: "Post"
  end
end
