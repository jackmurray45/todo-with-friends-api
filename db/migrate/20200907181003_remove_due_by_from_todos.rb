class RemoveDueByFromTodos < ActiveRecord::Migration[6.0]
  def change
    remove_column :todos, :due_by, :datetime
  end
end
