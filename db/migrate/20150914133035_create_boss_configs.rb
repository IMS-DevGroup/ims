class CreateBossConfigs < ActiveRecord::Migration
  def change
    create_table :boss_configs do |t|
      t.boolean :db_state
      t.string :org_name

      t.timestamps null: false
    end
  end
end
