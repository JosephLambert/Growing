class AddStateToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :state, :integer, default: Todo.states["incomplete"]
  end
end
