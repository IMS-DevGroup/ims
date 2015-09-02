class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_key

      t.timestamps null: false
    end
  end
end
