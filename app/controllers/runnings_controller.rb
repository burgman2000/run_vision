class RunningsController < ApplicationController
  def index
    @runnings = Running.all
    @running = Running.new
  end

  def json_index
    @monthly_data = Running.group("DATE_FORMAT(created_at, '%Y-%m')")
      .select("DATE_FORMAT(created_at, '%Y-%m') AS month, SUM(ran_distance) AS distance")
      .order("month")
      .map { |record| [record.month, record.distance] }

    distances = @monthly_data.map { |data| data[1] }
    months = @monthly_data.map { |data| data[0] }

    respond_to do |format|
      format.json { render json: { distances: distances, months: months } }
    end
  end

  def create
    @running = Running.new(running_params)
    if @running.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { running: @running } }
      end
    else
      @runnings = Running.all
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: { errors: @running.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def running_params
    params.require(:running).permit(:ran_distance)
  end
end
