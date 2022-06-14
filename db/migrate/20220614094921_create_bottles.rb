class CreateBottles < ActiveRecord::Migration[6.1]
  def change
    create_table :bottles do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :year
      t.references :trend
      t.references :domain
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
