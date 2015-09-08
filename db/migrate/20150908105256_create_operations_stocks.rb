class CreateOperationsStocks < ActiveRecord::Migration
  def change
    create_table :operations_stocks, id:false do |t|
    t.belongs_to :stock
    t.belongs_to :operation
    end
  end
end
