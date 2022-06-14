class CreateTransations < ActiveRecord::Migration[6.1]
  def change
    create_table :transations do |t|
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :bottle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
