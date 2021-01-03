require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_url
    assert_response :success, status: 200
  end

  test 'should log in user' do
    login(users(:one))
    assert_response :redirect, status: 302
  end

  test 'new should redirect authenticated user' do
    login(users(:one))
    get new_session_url
    assert_response :redirect, status: 302
  end

  test 'should logout user' do
    login(users(:one))
    delete session_url(current_user)
    assert_response :redirect, status: 302
  end
end
