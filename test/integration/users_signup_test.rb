require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  # test "the truth" do
  #   assert true
  # end

  # test that user should not be able to sign up with invalid information
  # test will verify by the count of users in the system
  # updated all links to be using devise path rather than the one stated in learnenough
  test "invalid signup information" do
    get new_user_registration_path
    assert_response :success
    assert_no_difference 'User.count' do
      post user_registration_path, params:
      {
        user: {
                username: "invalid user",
                email: "invalid@User",
                password: "pass",
                password_confirmation: "pass"
              }
      }
    end
    # this check that after failure test, it will redirect the user back to new registration page
    assert_template 'devise/registrations/new'
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post user_registration_path, params:
      {
        user:
        {
          username: "example",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
  end
end
