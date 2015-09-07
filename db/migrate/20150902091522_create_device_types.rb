class CreateDeviceTypes < ActiveRecord::Migration
  def change
    create_table :device_types do |t|
      t.string :name
      t.text :info

      t.timestamps null: false
    end
  end
end
