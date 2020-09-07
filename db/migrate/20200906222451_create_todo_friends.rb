class CreateTodoFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_friends do |t|
      t.references :todo, null: false, foreign_key: {to_table: :todos, on_delete: :cascade}
      t.references :user, null: false, foreign_key: {to_table: :users, on_delete: :cascade}

      t.timestamps
    end
  end
end
