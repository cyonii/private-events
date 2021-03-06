class EventsController < ApplicationController
  before_action :require_login!, except: %i[index show]
  before_action :set_event, only: %i[show destroy edit update]
  before_action :owner?, only: %i[destroy edit update]

  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = 'Event was successfully created'
      redirect_to @event
    else
      flash[:alert] = 'Error occurred while creating event'
      render :new
    end
  end

  def show; end

  def destroy
    @event.destroy
    flash[:notice] = 'Event was successfully cancelled'
    redirect_to events_path
  end

  def edit; end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated'
      redirect_to @event
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :description, :location, :date)
  end

  # Only allow post owner to take action
  def owner?
    return if current_user == @event.creator

    redirect_back(fallback_location: root_path, alert: 'Unauthorized request!')
  end
end
