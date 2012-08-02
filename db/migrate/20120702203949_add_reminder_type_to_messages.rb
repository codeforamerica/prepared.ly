class AddReminderTypeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :reminder_type, :string
  end
end