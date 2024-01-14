class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :merchant_reference, index: true
      t.string :disbursement_reference, index: true
      t.decimal :amount, precision: 20, scale: 2
      t.boolean :disbursed, default: false
      t.string :shopper_reference, index: true

      t.timestamps
    end
  end
end
