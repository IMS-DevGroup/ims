class ChangeUserMobilFromIntToString < ActiveRecord::Migration
  def change

    change_column :users, :mobile_number, :String
    change_column :units, :phone_number, :String

  end
end
