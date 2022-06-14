class AddRegionToBatches < ActiveRecord::Migration[6.1]
  def change
    add_column :batches, :region, :string
  end
end
