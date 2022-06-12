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


  test "profile display" do
    get new_user_session_path
    sign_in @other_user
    get user_path(@other_user)
    assert_template 'users/show'
    # assert_select 'h1', text: @other_user.username
    # assert_select 'section>img.gravatar'
    assert_match @other_user.posts.count.to_s, response.body
    assert_select 'div.pagination'
    @other_user.posts.paginate(page: 1).each do |post|
      assert_match post.description, response.body
    end
  end

  test "login with user valid information, create a post, delete a post and followed by logout" do
    # confirm that user is able to get into login page
    get new_user_session_path
    assert_template 'devise/sessions/new'

    # confirm that user have successfully signed in
    sign_in @user
    assert_response 200
    get root_path
    assert_select "a[href=?]", user_path(@user), :count => 1
    # confirm that user is not able to access another user profile
    assert_select "a[href=?]", user_path(@other_user), :count => 0

    get user_path(@user)
    assert_response 200
    # assert_select "h1", @user.username
    assert_difference "User.find(#{@user.id}).posts.count", 1 do
      post posts_path, params:
      {
        post:
        {
          description: "example post"
        }
      }
    end

    # since we are running through the backend, system will route to the default path which is root
    assert_redirected_to root_path

    assert_difference "User.find(#{@user.id}).posts.count", -1 do
      @user.posts.last.delete
    end

    # since we are running through the backend, system will route to the default path which is root
    assert_redirected_to root_path
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
