class RenameTransationsToTransactions < ActiveRecord::Migration[6.1]
  def change
    rename_table :transations, :transactions
  end
end
