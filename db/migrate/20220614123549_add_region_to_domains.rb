class AddRegionToDomains < ActiveRecord::Migration[6.1]
  def change
    add_column :domains, :region, :string
  end
end
