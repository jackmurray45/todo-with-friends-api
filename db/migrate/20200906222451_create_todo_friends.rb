class CreateTodoFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_friends do |t|
      t.references :todo, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
