class RunningsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] #ログインしていないと使えない！
  def index
    @event = Event.order(created_at: :desc).first 
    @runnings = Running.where(event_id: @event.id)
    @ran_distance_sum = @runnings.sum(:ran_distance) #＜左辺＞合計値を入れる変数名 、＜右辺＞合計を取得
    @rate_achievement = (@ran_distance_sum.to_f  / @event.target_distance) * 100  #<左辺>　＜右辺＞計算で達成率を表示
    @days_remaining = (@event.end_date - Date.today).numerator
    @remaining_distance = @event.target_distance - @ran_distance_sum
    @running = Running.new
    # Rails.logger.debug(@ran_distance_sum / @event.target_distance)
  end

  def json_index  
    @monthly_data = Running.group(:user_id)
      .joins(:user)
      # User.joins(:runnings).select(ran_distance)
      .select("users.nickname AS nickname, SUM(runnings.ran_distance) AS distance") #select取得する
      .order(:user_id)
      .map { |record| [record.nickname, record.distance] }#map→必要なデータだけを配列に直すメソッド @monthly_data = [["2023-11", 20], ["2023-12", 30].....]

    by_user_distances_data = @monthly_data.map { |data| data[1] }#ここでjson名を定義！   
    user_name_data = @monthly_data.map { |data| data[0] } #0はuser# ["test1","test2","test3"] 

    respond_to do |format|
      format.json { render json: { by_user_distances: by_user_distances_data, user_name: user_name_data } } 
    end
  end

  def new
   @running = Running.new
   @event_id = params[:event_id]
  end

  def create
    Running.create(running_params)
    redirect_to '/'
  end

  def edit
    @running = Running.find(params[:id])
  end

  def update
    @running = Event.find(params[:id])
    running.update(running_params)
    redirect_to running_path(runnning.id)
  end

  # def create
  #   @running = Running.new(running_params) #ログインしているuserIDを入れる デバイス　ログイン機能→userIDを取得するメソットcurrent.user？
  #   if @running.save!
  #     respond_to do |format|
  #       format.html { redirect_to root_path } #画面を表示
  #       format.json { render json: { running: @running } } #データを返す
  #     end
  #   else
  #     @runnings = Running.all
  #     respond_to do |format|
  #       format.html { render :index, status: :unprocessable_entity }
  #       format.json { render json: { errors: @running.errors.full_messages }, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def running_params
    params.require(:running).permit(:ran_distance, :event_id).merge(user_id: current_user.id)
  end
end
