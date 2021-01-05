class InvitationsController < ApplicationController
  before_action :require_login!, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])
    event = Event.find(params[:event_id])

    if user and event and !event.attendees.include?(user)
      Invitation.create(attendee: user, event: event)
      flash[:notice] = 'Successfully added attendee'
    else
      flash[:alert] = 'Invalid email or user is already invited'
    end
    redirect_to event
  end

  def destroy
    event = Event.find(params[:id])
    event.attendees.delete(current_user)
    flash[:notice] = 'Your invitation has been cancelled'
    redirect_to event
  end
end
