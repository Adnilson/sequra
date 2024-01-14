class CreateDisbursements < ActiveRecord::Migration[7.1]
  def change
    create_table :disbursements, id: :uuid do |t|
      t.string :reference, index: { unique: true }
      t.string :merchant_reference, index: true
      t.decimal :amount, precision: 20, scale: 2
      t.decimal :fee, precision: 20, scale: 2
      
      t.timestamps
      t.index [:reference, :merchant_reference], unique: true
    end
  end
end
