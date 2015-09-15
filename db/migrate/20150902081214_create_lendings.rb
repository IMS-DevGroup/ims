classSpongebob wallpaper CreateLendings < ActiveRecord::Migration
  def change
    create_table :lendings do |t|
      t.timestamp :receive
      t.text :lending_info
      t.text :receive_info

      t.timestamps null: false
    end
  end
end
