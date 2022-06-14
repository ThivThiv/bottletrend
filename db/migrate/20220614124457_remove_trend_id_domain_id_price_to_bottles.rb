class RemoveTrendIdDomainIdPriceToBottles < ActiveRecord::Migration[6.1]
  def change
    remove_column :bottles, :trend_id
    remove_column :bottles, :domain_id
    remove_column :bottles, :price
  end
end
