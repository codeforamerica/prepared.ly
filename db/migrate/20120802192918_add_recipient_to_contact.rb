class AddRecipientToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :recipient, :string
  end
end
