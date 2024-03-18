class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(event_params)
    redirect_to event_path(event.id)#変えたけど変わらない、、、。
  end

  def show
    @ran_distance_sum = @event.runnings.sum(:ran_distance)
    gon.Ran_distance = ::Event.circle_data(@event)
    gon.Ran_user = ::Event.circle_data(@event)
  end

  def edit
  end

  def update
    event.update(event_params)
    redirect_to event_path(event.id)
  end

  private
  def event_params
    params.require(:event).permit(:event_name, :target_distance, :start_date, :end_date, :commit)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
