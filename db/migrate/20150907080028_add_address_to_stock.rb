class AddAddressToStock < ActiveRecord::Migration
  def change

    add_column :stocks, :street, :string
    add_column :stocks, :city, :string

  end
end
