class AddMissingForeignKeys < ActiveRecord::Migration
  def change
    #Property
    add_column :properties, :data_type_id, :integer
    add_column :properties, :device_type_id, :integer

    #Value
    add_column :values, :property_id, :integer
    add_column :values, :device_id, :integer

    #Device
    add_column :devices, :device_type_id, :integer
    add_column :devices, :stock_id, :integer

    #Lending
    add_column :lendings, :device_id, :integer
    add_column :lendings, :user_id, :integer

    #Stock
    add_column :stocks, :unit_id, :integer

    #Unit
    add_column :units, :user_id, :integer

    #User
    add_column :users, :unit_id, :integer

    #Right
    add_column :rights, :user_id, :integer

    #Session
    add_column :sessions, :user_id, :integer
  end
end
