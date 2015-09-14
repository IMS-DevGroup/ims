class CreateDbconfig < ActiveRecord::Migration
  def change
    create_table :dbconfigs do |t|
      t.boolean :db_status
      t.string :org_name
      t.references :org_head_user
    end
  end
end
