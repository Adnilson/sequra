class MinimumMonthlyFeeProcessor
  def self.process(merchant_reference, minimum_monthly_fee)
    if Disbursement.in_last_month(merchant_reference).sum(:fee) < minimum_monthly_fee
      MinimumMonthlyFee.create(merchant_reference: merchant_reference, amount: minimum_monthly_fee)
 
      # Charge mininum monthly fee
    end
  end
end