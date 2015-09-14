class AddADeviceFKeyTo < ActiveRecord::Migration
  def change



    add_column :notifications, :device_id, :integer


  end
end
