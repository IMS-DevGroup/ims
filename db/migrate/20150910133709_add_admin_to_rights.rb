class AddAdminToRights < ActiveRecord::Migration
  def change

    add_column :rights, :admin, :boolean

  end
end
