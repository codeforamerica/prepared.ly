class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :user
      t.references :task
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :task_id
  end
end
