class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.point :latlon

      t.timestamps
    end
  end
end
