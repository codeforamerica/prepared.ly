class AddShareCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :share_code, :string
  end
end
