class AddBoardIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :board_id, :integer
  end
end
