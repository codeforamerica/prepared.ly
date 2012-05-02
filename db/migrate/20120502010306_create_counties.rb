class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.polygon :geometry, :geographic => true

      t.timestamps
    end
  end
end
