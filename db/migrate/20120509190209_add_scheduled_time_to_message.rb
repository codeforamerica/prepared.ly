class AddScheduledTimeToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :scheduled_time, :datetime
  end
end
