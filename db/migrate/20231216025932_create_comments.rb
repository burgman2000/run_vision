class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user_id, null: false
      t.references :running_id, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
