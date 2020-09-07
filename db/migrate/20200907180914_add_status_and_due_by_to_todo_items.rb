class AddStatusAndDueByToTodoItems < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_items, :status, :boolean, null: false, default: false
    add_column :todo_items, :due_by, :datetime
  end
end
