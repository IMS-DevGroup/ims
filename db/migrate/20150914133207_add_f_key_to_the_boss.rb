class AddFKeyToTheBoss < ActiveRecord::Migration
  def change

    add_column :boss_configs, :user_id, :integer

  end
end
