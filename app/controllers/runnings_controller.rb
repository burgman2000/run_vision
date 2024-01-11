class RunningsController < ApplicationController
  def index
    @runnings = Running.all
    @running = Running.new
  end

  def json_index  
    @monthly_data = Running.group("DATE_FORMAT(ran_distance, user_id)") # 2023-11 = month, 20 = distance #DBで取得したデータ
      User.joins(:runnings).select(run_distance)
      .select("DATE_FORMAT(ran_distance, user_id) AS month, SUM(ran_distance) AS distance") #DBのどのカラムをつかうのか　少し加工している
      .order("month")
      .map { |record| [record.byuser_distance_data, record.user_name_data] }#map→必要なデータだけを配列に直すメソッド @monthly_data = [["2023-11", 20], ["2023-12", 30].....]

    byuser_distance_data = @monthly_data.map { |data| data[1] }#byuser_distances_data = @monthly_data.map{}[20,30,40]       #1はdistance# [20, 30, 40, 50, 60]
    user_name_data = @monthly_data.map { |data| data[0] }#user_name_data =  @monthly_data.map{}["test1","test2","test3"]   #0はuser# ["test1","test2","test3"] 

    respond_to do |format|
      format.json { render json: { byuser_distances: byuser_distances_data, user_name: user_name_data } } 
    end
  end

  def create
    @running = Running.new(running_params) #ログインしているuserIDを入れる デバイス　ログイン機能→userIDを取得するメソットcurrent.user？
    if @running.save
      respond_to do |format|
        format.html { redirect_to root_path } #画面を表示
        format.json { render json: { running: @running } } #データを返す
      end
    else
      Rails.logger.debug
      @runnings = Running.all
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: { errors: @running.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def running_params
    params.require(:running).permit(:ran_distance).merge(user_id: current_user.id)
  end
end
