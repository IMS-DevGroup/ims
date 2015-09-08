class ChangeUserMobilFromIntToString < ActiveRecord::Migration
  def change

    change_column :users, :mobile_number, :string
    change_column :units, :phone_number, :string

  end
end
