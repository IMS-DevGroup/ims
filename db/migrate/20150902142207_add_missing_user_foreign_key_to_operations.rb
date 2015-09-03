class AddMissingUserForeignKeyToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :user_id, :integer
  end
end
