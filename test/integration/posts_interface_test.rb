require "test_helper"

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
  end

  test "Post interface" do
    sign_in @user
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { description: "" } }
    end
    follow_redirect!
    assert_select 'div.alert'
    # Valid submission
    content = "This Post really ties the room together"
    picture = fixture_file_upload('test/fixtures/question_mark.png', 'image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { description: content, picture: picture } }
    end
    assert Post.first.picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select 'a', text: 'Delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit different user (no delete links)
    get user_path(users(:test_other_user))
    assert_select 'a', text: 'delete', count: 0
  end
end
