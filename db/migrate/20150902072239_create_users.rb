class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.boolean :active
      t.string :email
      t.string :prename
      t.string :lastname
      t.integer :mobile_number
      t.text :info

      t.timestamps null: false
    end
  end
end
