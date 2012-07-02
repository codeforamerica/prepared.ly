class AddReminderTypeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :reminder_type, :string
    # column name 'type' is reserved 
    remove_column :messages, :type
  end
end