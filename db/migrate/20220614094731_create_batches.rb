class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.integer, :quantity
      t.integer, :price
      t.references :domain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
