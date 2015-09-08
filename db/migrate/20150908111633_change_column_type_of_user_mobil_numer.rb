class ChangeColumnTypeOfUserMobilNumer < ActiveRecord::Migration
  def change

    change_column :users, :mobile_number,  :string

  end
end
