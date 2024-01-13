class DisbursementRepository
  def self.all
    Disbursement.all
  end

  def self.create(merchant)
    reference = "#{Date.today.strftime}_#{merchant.merchant_reference}"
    total_fee = 0.0
    total_amount = 0.0

    merchant.orders.where(disbursed: false).find_each |order| do
      total_fee += DisbursementAmount.new(order.amount).calculate
      total_amount += order.amount
      order.update(disbursement_reference: reference, disbursed: true)
    end

    Disbursement.create(
      merchant_id: merchant.id,
      amount: total_amount - total_fee,
      fee: total_fee,
      disbursement_reference: reference
    )
  end
end