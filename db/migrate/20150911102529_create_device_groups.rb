class CreateDeviceGroups < ActiveRecord::Migration
  def change
    create_table :device_groups do |t|
      t.string :name
      t.text :info

      t.timestamps null: false
    end
  end
end
