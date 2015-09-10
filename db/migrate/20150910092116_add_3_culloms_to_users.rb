class Add3CullomsToUsers < ActiveRecord::Migration
  def change


    add_column :users, :validated, :boolean
    add_column :users, :reset_key, :string
    add_column :users, :reset_sent_at, :timestamp
    add_column :users, :language, :string

  end
end
