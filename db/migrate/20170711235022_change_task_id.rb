class ChangeTaskId < ActiveRecord::Migration
  def change
    rename_column :tasks, :task_id, :tag_id
  end
end
