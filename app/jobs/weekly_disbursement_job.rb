class WeeklyDisbursementJob < ApplicationJob
  queue_as :high

  def perform(*args)
    Repositories::MerchantRepository.weekly_disbursed.find_each do |merchant|
      CreateWeeklyDisbursementJob.perform_later(merchant.reference)
    end
  end
end
