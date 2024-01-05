class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.integer :target_distance, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :commit, null: false


      t.timestamps
    end
  end
end
