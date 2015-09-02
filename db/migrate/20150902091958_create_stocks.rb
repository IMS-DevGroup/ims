class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.text :info

      t.timestamps null: false
    end
  end
end
