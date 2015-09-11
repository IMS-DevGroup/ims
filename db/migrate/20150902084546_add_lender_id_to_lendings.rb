class AddLenderIdToLendings < ActiveRecord::Migration
  def change
    add_column :lendings, :lender_id, :integer
  end
end
