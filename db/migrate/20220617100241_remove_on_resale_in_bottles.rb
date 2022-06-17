class RemoveOnResaleInBottles < ActiveRecord::Migration[6.1]
  def change
    remove_column :bottles, :on_resale
  end
end
