class CreateTodoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_items do |t|
      t.string :content
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
