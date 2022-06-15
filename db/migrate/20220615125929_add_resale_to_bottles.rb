class AddResaleToBottles < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :seller
    add_column :bottles, :on_resale, :boolean, default: false
  end
end
