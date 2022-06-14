class AddPopularityToDomains < ActiveRecord::Migration[6.1]
  def change
    add_column :domains, :popularity, :integer
  end
end
