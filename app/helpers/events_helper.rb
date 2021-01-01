module EventsHelper
  def form_errors(event)
    render 'form_errors' if event.errors.any?
  end

  def creator_actions(event)
    render 'creator_actions' if current_user == event.creator
  end

  def cancel_button(attendee)
    return unless user_signed_in? and current_user == attendee

    css_class = 'btn btn-danger btn-sm py-0 float-right'
    link_to 'Cancel', invitation_path, method: :delete, data: { confirm: 'Cancel invitation?' }, class: css_class
  end

  def join_button(event)
    return 'Attending' if event.attendees.include?(current_user)

    render 'self_join'
  end
end
