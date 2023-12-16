class CreateRunnings < ActiveRecord::Migration[7.0]
  def change
    create_table :runnings do |t|
      t.references :user_id, null: false
      t.integer :ran_distance, null: false
      t.text :ran_location, null: false
      t.text :impression, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
