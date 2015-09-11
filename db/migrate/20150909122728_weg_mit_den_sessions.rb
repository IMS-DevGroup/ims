class WegMitDenSessions < ActiveRecord::Migration
  def change

    remove_column :rights, :admin


  end
end
