class CreateTodoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_items do |t|
      t.string :content
      t.references :todo, null: false, foreign_key: {to_table: :todos, on_delete: :cascade}

      t.timestamps
    end
  end
end
