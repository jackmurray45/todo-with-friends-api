class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :content
      t.datetime :due_by
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}

      t.timestamps
    end
  end
end
