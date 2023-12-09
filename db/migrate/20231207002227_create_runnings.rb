class CreateRunnings < ActiveRecord::Migration[7.0]
  def change
    create_table :runnings do |t|
      t.integer :ran_distance, null: false
      t.timestamps
    end
  end
end
