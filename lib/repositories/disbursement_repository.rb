module Repositories
  class DisbursementRepository
    def self.all
      Disbursement.all
    end

    def self.create(merchant_reference)
      reference = "#{Date.today.strftime}_#{merchant_reference}_disbursement"
      total_amount = 0.0
      total_gross_amount = 0.0

      ActiveRecord::Base.transaction do
        Order.where(disbursed: false, merchant_reference: merchant_reference).find_each do |order|
          total_amount += DisbursementAmount.new(order.amount).calculate
          total_gross_amount += order.amount
          order.update(disbursement_reference: reference, disbursed: true)
        end

        Disbursement.create(
          merchant_reference: merchant_reference,
          amount: total_amount,
          fee: total_gross_amount - total_amount,
          reference: reference
        )
      end
    end

    def self.in_last_month(merchant_reference)
      Disbursement.where(
        "merchant_reference = ? AND created_at BETWEEN ? AND ?",
        merchant_reference, 1.month.ago.beginning_of_month , 1.month.ago.end_of_month
      )
    end
  end
end
