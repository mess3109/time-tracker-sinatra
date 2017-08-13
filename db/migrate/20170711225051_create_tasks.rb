class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :user_id
      t.integer :task_id
      t.time :goal_time
      t.time :actual_time
      t.string :notes
    end
  end
end
