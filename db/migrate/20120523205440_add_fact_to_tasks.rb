class AddFactToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :fact, :text
  end
end
