class MinimumMonthlyFeeProcessor
  def self.process(merchant_reference, minimum_monthly_fee)
    last_month_fee = Repositories::DisbursementRepository.in_last_month(merchant_reference).sum(:fee)

    if last_month_fee < minimum_monthly_fee
      Repositories::MinimumMonthlyFeeRepository.create(merchant_reference: merchant_reference, amount: minimum_monthly_fee)

      # Charge mininum monthly fee
    end
  end
end