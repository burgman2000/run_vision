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
    @user_running_data = @event.runnings.group(:user).sum(:ran_distance)
    gon.nicknames = @user_running_data.map { |user, distance| user.nickname }
    gon.runnings = @user_running_data.map { |user, distance| distance }
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
