require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test 'should create new invitation' do
    post invitations_url, params: { email: users(:three).email, event_id: events(:one).id }
    assert_redirected_to events(:one)
    assert_equal flash[:notice], 'Successfully added attendee'
  end

  test 'should cancel invitation' do
    login(users(:two))

    delete invitation_url(events(:one))
    assert_response :found, status: 302
    assert_equal flash[:notice], 'Your invitation has been cancelled'
  end

  test 'destroy should redirect unauthenticated user' do
    delete invitation_url(events(:one))
    assert_response :found, status: 302
    assert_redirected_to new_session_url
    assert_equal flash[:alert], 'Log in to continue'
  end
end
