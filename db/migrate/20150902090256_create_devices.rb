class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.boolean :ready
      t.text :info
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
