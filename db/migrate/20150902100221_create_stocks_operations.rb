class CreateStocksOperations < ActiveRecord::Migration
  def change
    create_table :stocks_operations , id:false do |t|
      t.references :stock
      t.references :operation
    end
  end
end
