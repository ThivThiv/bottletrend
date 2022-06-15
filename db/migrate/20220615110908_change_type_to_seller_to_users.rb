class ChangeTypeToSellerToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :seller
    add_column :users, :seller, :boolean, default: false
  end
end
