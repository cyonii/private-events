module ApplicationHelper
  def flash_class
    return 'success' if flash[:notice]
    return 'danger' if flash[:alert]
  end

  def flash_message
    render 'layouts/flash_message' if flash.present?
  end

  def user_signed_in?
    return true if session[:user_id]

    false
  end

  def current_user
    return User.find(session[:user_id]) if user_signed_in?

    nil
  end

  def user_actions
    if user_signed_in? and current_user
      render 'layouts/logged_in_user_actions'
    else
      render 'layouts/logged_out_user_actions'
    end
  end

  def event_list(events)
    if events.count.positive?
      render 'events/event_list', events: events
    else
      content_tag :small, class: 'text-muted fst-italic fw-light' do
        'No event data'
      end
    end
  end
end
