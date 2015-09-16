class AddBossRightToRights < ActiveRecord::Migration
  def change

    add_column :rights, :manage_boss, :boolean

  end
end
