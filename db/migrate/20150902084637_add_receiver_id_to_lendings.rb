class AddReceiverIdToLendings < ActiveRecord::Migration
  def change
    add_column :lendings, :receiver_id, :integer
  end
end
