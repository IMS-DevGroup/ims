class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text :info
      t.timestamp :checked

      t.timestamps null: false
    end
  end
end
