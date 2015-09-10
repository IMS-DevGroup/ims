class AddCookiesToUsers < ActiveRecord::Migration
  def change


    add_column :users, :cookies, :string

  end
end
