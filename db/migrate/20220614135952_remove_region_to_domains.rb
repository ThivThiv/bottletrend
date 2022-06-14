class RemoveRegionToDomains < ActiveRecord::Migration[6.1]
  def change
    remove_column :domains, :region
  end
end
