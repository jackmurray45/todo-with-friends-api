class ChangeContentToTitleInTodos < ActiveRecord::Migration[6.0]
  def change
    rename_column :todos, :content, :title
  end
end
