class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.point :latlon

      t.timestamps
    end
  end
end
