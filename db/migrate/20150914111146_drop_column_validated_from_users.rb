class DropColumnValidatedFromUsers < ActiveRecord::Migration
  def change

    remove_column :users, :validated

  end
end
