namespace :disbursements do
  desc "create disbursements from the seed files"
  task create: [:environment] do
    start = Time.now

    Merchant.find_each do |merchant|
      puts "processing disbursements for Merchant: #{merchant.reference}"

      create_disbursement("2022", merchant.reference)
      create_disbursement("2023", merchant.reference)
    end

    finish = Time.now - start

    puts "It took #{finish} seconds!"
  end

  def create_disbursement(year, merchant_reference)
    reference = "#{year}_#{merchant_reference}_disbursement"
    total_amount = 0.0
    total_gross_amount = 0.0
    orders = Order.where(
      "EXTRACT(YEAR FROM created_at) = ? AND disbursed = ? AND merchant_reference = ?",
      year, false, merchant_reference
    )

    orders.find_each do |order|
      total_amount += DisbursementAmount.new(order.amount).calculate
      total_gross_amount += order.amount
      order.update(disbursement_reference: reference, disbursed: true)
    end

    Disbursement.create(
      merchant_reference: merchant_reference,
      amount: total_amount,
      fee: total_gross_amount - total_amount,
      reference: reference,
      created_at: "#{year}-01-01"
    )
  end
end
