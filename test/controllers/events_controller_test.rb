require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get events_url
    assert_response :success, status: 200
  end

  test 'should get new' do
    login(users(:one))
    get new_event_url
    assert_response :success
  end

  test 'new should redirect unauthenticated user' do
    get new_event_url
    assert_redirected_to new_session_url
  end

  test 'create should redirect unauthenticated user' do
    post events_url
    assert_redirected_to new_session_url
  end

  test 'should create new event' do
    user = users(:three)
    login(user)
    post events_url, params: {
      event: {
        name: 'RailsCON',
        description: "Let's ride",
        location: 'Remote, Internet',
        date: '2022-01-01 16:00:00'
      }
    }
    assert_equal user.events.count, 1
    assert_equal flash[:notice], 'Event was successfully created'
  end

  test 'should not create event with incomplete data' do
    login(users(:three))
    post events_url, params: { event: { name: '', description: '', location: '', date: '' } }

    assert_equal flash[:alert], 'Error occurred while creating event'
    assert_response :success, status: 200
  end

  test 'should destroy event' do
    event = events(:one)
    login(event.creator)

    delete event_path(event)
    assert_equal flash[:notice], 'Event was successfully cancelled'
    assert_redirected_to events_url
  end

  test 'should get edit' do
    login(events(:one).creator)

    get edit_event_url(events(:one))
    assert_response :success, status: 200
  end

  test 'edit should redirect unauthenticated user' do
    get edit_event_url(events(:one))
    assert_response :found, status: 302
    assert_redirected_to new_session_url
  end

  test 'should update event' do
    event = events(:one)
    login(event.creator)

    patch event_url(event), params: { event: { name: 'Edited event' } }
    assert_equal flash[:notice], 'Event was successfully updated'
    assert_redirected_to event
  end

  test 'update should redirect unauthenticated user' do
    patch event_url(events(:one)), params: { event: { name: 'Edited event' } }
    assert_response :found, status: 302
    assert_redirected_to new_session_url
  end
end
