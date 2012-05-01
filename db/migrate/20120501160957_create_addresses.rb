class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.point :latlon, :geographic => true

      t.timestamps
    end
  end
end
