class RunningsController < ApplicationController
  def index
    @runnings = Running.all
    @running = Running.new
  end

  def json_index  
    @monthly_data = Running.group(:user_id) 
      # User.joins(:runnings).select(ran_distance)
      .select("user_id, SUM(ran_distance) AS distance") #select取得する
      .order(:user_id)
      .map { |record| [record.user_id, record.distance] }#map→必要なデータだけを配列に直すメソッド @monthly_data = [["2023-11", 20], ["2023-12", 30].....]

    by_user_distances_data = @monthly_data.map { |data| data[1] }#ここでjson名を定義！   
    user_name_data = @monthly_data.map { |data| data[0] } #0はuser# ["test1","test2","test3"] 

    respond_to do |format|
      format.json { render json: { by_user_distances: by_user_distances_data, user_name: user_name_data } } 
    end
  end

  def create
    @running = Running.new(running_params) #ログインしているuserIDを入れる デバイス　ログイン機能→userIDを取得するメソットcurrent.user？
    if @running.save!
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
    params.require(:running).permit(:ran_distance).merge(user_id: current_user.id)
  end
end
