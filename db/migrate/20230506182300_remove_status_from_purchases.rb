class RemoveStatusFromPurchases < ActiveRecord::Migration[7.0]
  def change
    remove_column :purchases, :status
  end
end
