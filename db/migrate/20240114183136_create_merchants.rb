class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants, id: :uuid do |t|
      t.string :reference, index: { unique: true }
      t.string :email
      t.datetime :live_on
      t.string :disbursement_frequency
      t.decimal :minimum_monthly_fee, precision: 6, scale: 2

      t.timestamps
    end
  end
end
