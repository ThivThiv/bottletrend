class AddPriceToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :price, :integer
  end
end
