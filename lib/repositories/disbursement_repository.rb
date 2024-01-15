module Repositories
  class DisbursementRepository
    def self.all
      Disbursement.all
    end

    def self.create(merchant_reference)
      reference = "#{Date.today.strftime}_#{merchant_reference}_disbursement"
      total_fee = 0.0
      total_amount = 0.0

      ActiveRecord.transaction do
        Orders.where(disbursed: false, merchant_reference: merchant_reference).find_each |order| do
          total_fee += DisbursementAmount.new(order.amount).calculate
          total_amount += order.amount
          order.update(disbursement_reference: reference, disbursed: true)
        end

        Disbursement.create(
          merchant_id: merchant_reference,
          amount: total_amount - total_fee,
          fee: total_fee,
          disbursement_reference: reference
        )
      end
    end
  end
end
