class CreateTrends < ActiveRecord::Migration[6.1]
  def change
    create_table :trends do |t|
      t.integer :potential
      t.integer :variation

      t.timestamps
    end
  end
end
