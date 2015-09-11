class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.text :info

      t.timestamps null: false
    end
  end
end
