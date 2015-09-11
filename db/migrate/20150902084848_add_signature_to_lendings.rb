class AddSignatureToLendings < ActiveRecord::Migration
  def change
    add_column :lendings, :signature, :text
  end
end
