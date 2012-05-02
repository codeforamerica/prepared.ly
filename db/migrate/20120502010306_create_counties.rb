class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.multi_polygon :geometry, :geographic => true

      t.timestamps
    end
  end
end
