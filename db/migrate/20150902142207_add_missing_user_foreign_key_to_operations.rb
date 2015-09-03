class AddMissingUserForeignKeyToOperations < ActiveRecord::Migration
  def change
    add_column :operation, :user_id, :integer
  end
end
