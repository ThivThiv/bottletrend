class AddSellerToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :seller, :string
  end
end
