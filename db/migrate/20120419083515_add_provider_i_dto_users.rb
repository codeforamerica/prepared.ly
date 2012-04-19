class AddProviderIDtoUsers < ActiveRecord::Migration
  def change
  	add_column :users, :provider_id, :string
  	remove_column :users, :twitter_id
  end
end
