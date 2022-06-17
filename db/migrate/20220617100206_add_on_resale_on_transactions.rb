class AddOnResaleOnTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :on_resale, :boolean, null: false, default: false
  end
end
