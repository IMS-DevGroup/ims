class AddMissingUserForeignKeyToOperations < ActiveRecord::Migration
  def change
    add_column :Operation, :user_id, :integer
  end
end
