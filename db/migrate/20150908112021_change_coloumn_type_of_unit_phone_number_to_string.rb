class ChangeColoumnTypeOfUnitPhoneNumberToString < ActiveRecord::Migration
  def change

    change_column :units, :phone_number,  :string


  end
end
