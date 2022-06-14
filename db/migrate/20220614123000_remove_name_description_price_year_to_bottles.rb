class RemoveNameDescriptionPriceYearToBottles < ActiveRecord::Migration[6.1]
  def change
    remove_column :bottles, :name
    remove_column :bottles, :description
    remove_column :bottles, :year
  end
end
