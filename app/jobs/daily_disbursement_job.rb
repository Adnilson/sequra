class DailyDisbursementJob < ApplicationJob
  queue_as :high

  def perform(*args)
    Repositories::MerchantRepository.daily_disbursed.find_each do |merchant|
      if Date.today.mday == 1
        MinimumMonthlyFeeProcessor.process(merchant.reference, merchant.minimum_monthly_fee)
      end

      CreateDailyDisbursementJob.perform_later(merchant.reference)
    end
  end
end
