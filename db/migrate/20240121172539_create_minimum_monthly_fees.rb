class CreateMinimumMonthlyFees < ActiveRecord::Migration[7.1]
  def change
    create_table :minimum_monthly_fees, id: :uuid do |t|
      t.string :merchant_reference, index: true
      t.decimal :amount, precision: 6, scale: 2

      t.timestamps
    end
  end
end
