module EventsHelper
  def form_errors(event)
    render 'form_errors' if event.errors.any?
  end

  def creator_actions(event)
    render 'creator_actions' if current_user == event.creator
  end
end
