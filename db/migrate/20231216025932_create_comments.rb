class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :running, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.text :comment, null: false
      t.timestamps
    end
  end
end
