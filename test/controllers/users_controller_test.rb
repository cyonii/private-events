require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_url
    assert_response :success, status: 200
  end

  test 'new should redirect authenticated user' do
    login(users(:one))
    get new_user_url
    assert_response :found, status: 302
    assert_equal flash[:notice], "You're already logged in"
  end

  test 'should create new user' do
    post users_url, params: { user: { email: 'test@email.com', name: 'Test User' } }
    assert_equal flash[:notice], 'User was successfully created'
    assert_response :found, status: 302
  end

  test 'should get show' do
    login(users(:one))
    get user_url(:one)
    assert_response :success, status: 200
  end

  test 'show should redirect unauthenticated user' do
    get user_url(:one)
    assert_response :found, status: 302
    assert_equal flash[:alert], 'Log in to continue'
  end
end
