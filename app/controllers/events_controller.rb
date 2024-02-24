class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(event_params)
    redirect_to '/'
  end

  private
  def event_params
    params.require(:event).permit(:event_name, :target_distance, :start_date, :end_date, :commit)
  end
end
