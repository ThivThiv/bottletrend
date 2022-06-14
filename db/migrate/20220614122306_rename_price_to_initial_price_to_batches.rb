class RenamePriceToInitialPriceToBatches < ActiveRecord::Migration[6.1]
  def change
    rename_column :batches, :price, :initial_price
  end
end
