class AddDetailToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :detail, :text
  end
end
