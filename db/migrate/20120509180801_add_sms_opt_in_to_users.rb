class AddSmsOptInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sms_opt_in, :boolean, :default => true
  end
end
