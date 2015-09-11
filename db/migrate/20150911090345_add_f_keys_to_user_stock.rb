class AddFKeysToUserStock < ActiveRecord::Migration
  def change


    add_column :users, :stock_id, :integer

  end
end
