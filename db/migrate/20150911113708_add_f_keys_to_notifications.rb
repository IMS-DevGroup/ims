class AddFKeysToNotifications < ActiveRecord::Migration
  def change


    add_column :notifications, :unit_id, :integer
    add_column :notifications, :user_id, :integer



  end
end
