require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def setup
    @user = users(:test_user)
    @other_user = users(:test_other_user)
  end

  test "login with invalid password will not allow user to login" do
    # confirm that user is able to get into login page
    get new_user_session_path
    assert_template 'devise/sessions/new'

    # confirm that user is not able to signed in
    post user_session_path, params: { session: { email: "test@test.com", password: "incorrect password" }}
    get root_path
    assert_select "a[href=?]", new_user_session_path
  end

  test "login with invalid email will not allow user to login" do
    # confirm that user is able to get into login page
    get new_user_session_path
    assert_template 'devise/sessions/new'

    # confirm that user is not able to signed in
    post user_session_path, params: { session: { email: "invalidtest@test.com", password: "password" }}
    get root_path
    assert_select "a[href=?]", new_user_session_path
  end

  test "login with user valid information, create a post, delete a post and followed by logout" do
    # confirm that user is able to get into login page
    get new_user_session_path
    assert_template 'devise/sessions/new'

    # confirm that user have successfully signed in
    sign_in @user
    get root_path
    assert_select "a[href=?]", user_path(@user), :count => 1
    # confirm that user is not able to access another user profile
    assert_select "a[href=?]", user_path(@other_user), :count => 0

    get user_path(@user)
    assert_select "h1", @user.username
    assert_difference "User.find(#{@user.id}).posts.count", 1 do
      post posts_path, params:
      {
        post:
        {
          description: "example post"
        }
      }
    end

    get posts_path

    assert_difference "User.find(#{@user.id}).posts.count", -1 do
      @user.posts.last.delete
    end

    # confirm that user have successfully signed in
    sign_out @user
    get root_path
    assert_select "a[href=?]", new_user_session_path

    # note
    # improvement to be made, ensure that redirect works for both login and logout
  end

  test "login with other user valid information followed by logout" do
    # confirm that user is able to get into login page
    get new_user_session_path
    assert_template 'devise/sessions/new'

    # confirm that user have successfully signed in
    sign_in @other_user
    get root_path
    assert_select "a[href=?]", user_path(@other_user), :count => 1

    # confirm that user is not able to access another user profile
    assert_select "a[href=?]", user_path(@user), :count => 0

    # confirm that user have successfully signed in
    sign_out @other_user
    get root_path
    assert_select "a[href=?]", new_user_session_path

    # note
    # improvement to be made, ensure that redirect works for both login and logout
  end
end
