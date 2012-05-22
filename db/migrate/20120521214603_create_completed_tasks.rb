class CreateCompletedTasks < ActiveRecord::Migration
  def change
    create_table :completed_tasks do |t|
      t.references :user
      t.references :task
      t.boolean :completed
      t.timestamps
    end
  end
end
