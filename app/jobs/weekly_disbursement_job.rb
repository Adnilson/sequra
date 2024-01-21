class WeeklyDisbursementJob < ApplicationJob
  queue_as :high

  def perform(*args)
    Repositories::MerchantRepository.weekly_disbursed.find_each do |merchant|
      if (1..7).include?(Date.today.mday)
        MinimumMonthlyFeeProcessor.process(merchant.reference, merchant.minimum_monthly_fee)
      end

      CreateWeeklyDisbursementJob.perform_later(merchant.reference)
    end
  end
end
