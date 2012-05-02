class CreateFireStations < ActiveRecord::Migration
  def change
    create_table :fire_stations do |t|
      t.string :address
      t.point :latlon, :geographic => true
      t.integer :zip

      t.timestamps
    end
  end
end
