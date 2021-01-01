class InvitationsController < ApplicationController
  before_action :require_login!, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])
    event = Event.find(params[:event_id])

    if user and event and !event.attendees.include?(user)
      invitation = Invitation.create(user_id: user.id, event_id: event.id)
      flash[:notice] = 'Successfully added attendee'
      redirect_to event_path(invitation.event_id)
    else
      flash[:alert] = 'Invalid email or user is already invited'
      redirect_to event
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.attendees.delete(current_user)
    flash[:notice] = 'Your invitation has been cancelled'
    redirect_to event
  end
end
