class RunningsController < ApplicationController
  def index
    @runnings = Running.all
    @running = Running.new
  end

  def json_index  #js用にデータだけを返すために、railsの設定をする
    @monthly_data = Running.group("DATE_FORMAT(created_at, '%Y-%m')") #月ごとに集計# 2023-11 = month, 20 = distance
      .select("DATE_FORMAT(created_at, '%Y-%m') AS month, SUM(ran_distance) AS distance")
      .order("month")
      .map { |record| [record.month, record.distance] } #map→必要なデータだけを配列に直すメソッド @monthly_data = [["2023-11", 20], ["2023-12", 30].....]

    distances = @monthly_data.map { |data| data[1] }#1はdistance# [20, 30, 40, 50, 60]
    months = @monthly_data.map { |data| data[0] }#0はmonth# ["2023-11", "2023-12", "2024-01", "2024-02", "2024-03"]
# { "distances": [20, 30, 40, 50, 60], "months": ["2023-11", "2023-12", "2024-01", "2024-02", "2024-03"]}

    respond_to do |format| #htmlではなく、データを帰したいので、その場合はjsonで返す。
      format.json { render json: { distances: distances, months: months } }
    end
  end

  def create
    @running = Running.new(running_params)
    if @running.save
      respond_to do |format|
        format.html { redirect_to root_path } #画面を表示
        format.json { render json: { running: @running } } #データを返す
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
