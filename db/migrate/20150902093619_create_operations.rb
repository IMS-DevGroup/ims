class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :number
      t.string :type
      t.text :info
      t.string :location
      t.timestamp :close_date

      t.timestamps null: false
    end
  end
end
