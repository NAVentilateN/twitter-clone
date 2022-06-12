require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @post = posts(:first_post)
    @other_post = posts(:orange)
    @user = users(:test_user)
    @other_user = users(:test_other_user)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    # updated to devise path
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    # updated to devise path
    assert_redirected_to new_user_session_path
  end

  test "should allow user sign in and to create a post" do
    sign_in @user
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { description: "Lorem ipsum" } }
    end
    assert_redirected_to root_path
  end

  test "should allow user to delete own post" do
    sign_in @user
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to root_path
  end

  test "should not allow user to delete other user post" do
    sign_in @user
    assert_no_difference 'Post.count' do
      delete post_path(@other_post)
    end
    assert_redirected_to root_path
  end


    # test "should get index" do
  #   get posts_index_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get posts_new_url
  #   assert_response :success
  # end

  # test "should get create" do
  #   get posts_create_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get posts_edit_url
  #   assert_response :success
  # end

  # test "should get update" do
  #   get posts_update_url
  #   assert_response :success
  # end

  # test "should get delete" do
  #   get posts_delete_url
  #   assert_response :success
  # end
end
