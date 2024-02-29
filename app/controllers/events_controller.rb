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

  def show
    @event = Event.find(params[:id])
    @ran_distance_sum = @event.runnings.sum(:ran_distance)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    redirect_to event_path(event.id)
  end

  private
  def event_params
    params.require(:event).permit(:event_name, :target_distance, :start_date, :end_date, :commit)
  end
end
