require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "user should not be able to visit the post index if they are not logged in" do
    user = users(:test_user)
    visit user_url(user)
    # save_and_open_screenshot
    assert_text "Log in"
  end

  test "user should be able to visit the post index if they are logged in" do
    visit "/"
    # save_and_open_screenshot
    user = users(:test_user)
    login_as user
    visit user_path(user)
    # save_and_open_screenshot
    assert_selector "h1", text: user.username
    assert_selector ".post", count: user.posts.count
  end

  test "lets a signed in user create a new post" do
    # visit "/"
    # login_as users(:test_user)
    # visit "/posts"
    # assert_selector "h1", text: "Post"
    # assert_selector ".post", count: Post.count
    # visit "/posts/new"
    # save_and_open_screenshot

    # fill_in "description" with "A brand new post"

    # click on "Create Post"
    # save_and_open_screenshot
    # this should redirect user back to page with all the post
    # assert_equal posts_path, page.current_path
    # assert_text "A brand new post"

  end
end
