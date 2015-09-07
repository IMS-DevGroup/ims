class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.boolean :manage_rights

      t.timestamps null: false
    end
  end
end
