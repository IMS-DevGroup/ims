class AddRightsToRights < ActiveRecord::Migration
  def change

    add_column :rights, :manage_users, :boolean
    add_column :rights, :manage_devices, :boolean
    add_column :rights, :manage_device_types, :boolean
    add_column :rights, :manage_stocks_and_units, :boolean
    add_column :rights, :manage_operations, :boolean


  end
end
