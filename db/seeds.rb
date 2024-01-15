require "csv"

CSV.read("db/seed_files/merchants.csv", col_sep: ";", headers: true).each do |merchant|
  Merchant.create(
    id: merchant["id"],
    reference: merchant["reference"],
    email: merchant["email"],
    live_on: merchant["live_on"],
    disbursement_frequency: merchant["disbursement_frequency"],
    minimum_monthly_fee: merchant["minimum_monthly_fee"]
  )
end

# Go have a smoke after running this one
CSV.read("db/seed_files/orders.csv", col_sep: ";", headers: true).each do |order|
  Order.create(
    id: order["id"],
    merchant_reference: order["merchant_reference"],
    amount: order["amount"],
    created_at: order["created_at"]
  )
end
