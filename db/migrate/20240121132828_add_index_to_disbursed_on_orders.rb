class AddIndexToDisbursedOnOrders < ActiveRecord::Migration[7.1]
  def change
    add_index :orders, :disbursed
  end
end
