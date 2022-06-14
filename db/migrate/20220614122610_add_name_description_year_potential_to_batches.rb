class AddNameDescriptionYearPotentialToBatches < ActiveRecord::Migration[6.1]
  def change
    add_column :batches, :name, :string
    add_column :batches, :description, :text
    add_column :batches, :year, :integer
    add_column :batches, :potential, :integer
  end
end
